# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false, HelpMessage = "The ID of the Agent Identity Blueprint to grant permissions to.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentBlueprintId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.ReadWrite.All, AgentIdUser.ReadWrite.IdentityParentedBy' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Use provided ID or fall back to stored ID
        if (-not $AgentBlueprintId) {
            if (-not $script:CurrentAgentBlueprintId) {
                throw "No Agent Blueprint ID provided and no stored ID available. Please run New-EntraBetaAgentIdentityBlueprint first or provide the AgentBlueprintId parameter."
            }
            $AgentBlueprintId = $script:CurrentAgentBlueprintId
            Write-Verbose "Using stored Agent Blueprint ID: $AgentBlueprintId"
        }
        else {
            Write-Verbose "Using provided Agent Blueprint ID: $AgentBlueprintId"
        }

        # Initialize script-level cache variable if not exists
        if (-not (Get-Variable -Name MSGraphServicePrincipalId -Scope Script -ErrorAction SilentlyContinue)) {
            $script:MSGraphServicePrincipalId = $null
        }

        # Retrieves the service principal ID (object ID) for Microsoft Graph (app ID 00000003-0000-0000-c000-000000000000) in the current tenant.
        function Get-MSGraphServicePrincipalId {
            param()
            # Return cached value if available
            if ($script:MSGraphServicePrincipalId) {
                Write-Verbose "Using cached Microsoft Graph Service Principal ID: $script:MSGraphServicePrincipalId"
                return $script:MSGraphServicePrincipalId
            }

            try {
                # Microsoft Graph App ID is always 00000003-0000-0000-c000-000000000000
                $msGraphAppId = "00000003-0000-0000-c000-000000000000"

                # Get the service principal for Microsoft Graph
                $msGraphServicePrincipalResponse = Invoke-MgGraphRequest -Method GET -Uri "v1.0/servicePrincipals?`$filter=appId eq '$msGraphAppId'&`$select=id,appId,displayName"

                if (-not $msGraphServicePrincipalResponse.value -or $msGraphServicePrincipalResponse.value.Count -eq 0) {
                    throw "Microsoft Graph Service Principal not found in tenant"
                }

                $msGraphServicePrincipal = $msGraphServicePrincipalResponse.value[0]
                Write-Verbose "MS Graph Service Principal found - ID: $($msGraphServicePrincipal.id), Display Name: $($msGraphServicePrincipal.displayName)"

                # Cache the result
                $script:MSGraphServicePrincipalId = $msGraphServicePrincipal.id
                return $script:MSGraphServicePrincipalId
            }
            catch {
                Write-Error "Failed to retrieve Microsoft Graph Service Principal ID: $_"
                throw
            }
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = '/beta/servicePrincipals'

        try {
            Write-Host "Adding permission to create Agent Users to Agent Identity Blueprint Principal..." -ForegroundColor Cyan
            Write-Verbose "Retrieving Blueprint Service Principal ID from tenant..."
            $blueprintServicePrincipalResponse = Invoke-MgGraphRequest -Method GET -Uri "${baseUri}?`$filter=appId eq '$AgentBlueprintId'&`$select=id,appId,displayName"

            if (-not $blueprintServicePrincipalResponse.value -or $blueprintServicePrincipalResponse.value.Count -eq 0) {
                throw "Blueprint Service Principal not found in tenant"
            }

            $blueprintServicePrincipal = $blueprintServicePrincipalResponse.value[0]

            # Cache the result
            $script:CurrentAgentBlueprintServicePrincipalId = $blueprintServicePrincipal.id

            Write-Verbose "Blueprint Service Principal found - ID: $script:CurrentAgentBlueprintServicePrincipalId, Display Name: $($blueprintServicePrincipal.displayName)"

            $servicePrincipalId = $script:CurrentAgentBlueprintServicePrincipalId
            Write-Verbose "Using stored Agent Identity Blueprint Service Principal ID: $servicePrincipalId"

            # Get the Microsoft Graph Service Principal ID using our internal function
            Write-Verbose "Retrieving Microsoft Graph Service Principal ID..."
            $msGraphServicePrincipalId = Get-MSGraphServicePrincipalId

            # AgentIdUser.ReadWrite.IdentityParentedBy permission ID
            $appRoleId = "4aa6e624-eee0-40ab-bdd8-f9639038a614"
            Write-Verbose "App Role ID (AgentIdUser.ReadWrite.IdentityParentedBy): $appRoleId"
            # Prepare the body for the app role assignment
            $body = @{
                principalId = $servicePrincipalId
                resourceId = $msGraphServicePrincipalId
                appRoleId = $appRoleId
            }

            Write-Verbose "Request Details:"
            Write-Verbose "  Principal ID (Service Principal): $servicePrincipalId"
            Write-Verbose "  Resource ID (Microsoft Graph): $msGraphServicePrincipalId"
            Write-Verbose "  App Role ID: $appRoleId (AgentIdUser.ReadWrite.IdentityParentedBy)"

            # Create the app role assignment using the Microsoft Graph REST API
            $apiUrl = "${baseUri}/$servicePrincipalId/appRoleAssignments"
            Write-Verbose "API URL: $apiUrl"

            $JsonBody = $body | ConvertTo-Json -Depth 3
            Write-Debug "Request Body: $JsonBody"

            $appRoleAssignmentResponse = Invoke-MgGraphRequest -Headers $customHeaders -Uri $apiUrl -Method POST -Body $JsonBody

            Write-Host "Successfully granted AgentIdUser.ReadWrite.IdentityParentedBy permission" -ForegroundColor Green
            Write-Verbose "App Role Assignment ID: $($appRoleAssignmentResponse.id)"
            Write-Verbose "Principal ID: $($appRoleAssignmentResponse.principalId)"
            Write-Verbose "Resource ID: $($appRoleAssignmentResponse.resourceId)"
            Write-Verbose "App Role ID: $($appRoleAssignmentResponse.appRoleId)"

            # Add descriptive properties to the response
            $appRoleAssignmentResponse | Add-Member -MemberType NoteProperty -Name "AgentBlueprintId" -Value $AgentBlueprintId -Force
            $appRoleAssignmentResponse | Add-Member -MemberType NoteProperty -Name "AgentBlueprintServicePrincipalId" -Value $servicePrincipalId -Force
            $appRoleAssignmentResponse | Add-Member -MemberType NoteProperty -Name "PermissionName" -Value "AgentIdUser.ReadWrite.IdentityParentedBy" -Force
            $appRoleAssignmentResponse | Add-Member -MemberType NoteProperty -Name "PermissionDescription" -Value "Allows creation of agent users parented to agent identities" -Force
            $appRoleAssignmentResponse | Add-Member -MemberType NoteProperty -Name "MSGraphServicePrincipalId" -Value $msGraphServicePrincipalId -Force

            return $appRoleAssignmentResponse
        }
        catch {
            Write-Error "Failed to add AgentIdUser.ReadWrite.IdentityParentedBy permission to Agent Identity Blueprint Principal: $_"
            if ($_.Exception.Response) {
                Write-Debug "Response Status: $($_.Exception.Response.StatusCode)"
                if ($_.Exception.Response.Content) {
                    Write-Debug "Response Content: $($_.Exception.Response.Content)"
                }
            }
            throw
        }
    }
}
