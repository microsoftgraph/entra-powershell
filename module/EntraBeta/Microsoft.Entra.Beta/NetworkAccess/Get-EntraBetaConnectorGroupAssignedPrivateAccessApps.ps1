# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaConnectorGroupAssignedPrivateAccessApps {
    [CmdletBinding()]
    param (
        [string]$ConnectorGroupId,
        [Alias('ObjectId')]
        [string]$ProfileId = "applicationProxy"
    )

    PROCESS {
        try {
            # Create custom headers for the request
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

            #Write-Host "Reading service principals with specific tags. This operation might take longer..." -ForegroundColor Green
            $spUri = "/beta/servicePrincipals?`$filter=tags/Any(x: x eq 'PrivateAccessNonWebApplication') or tags/Any(x: x eq 'NetworkAccessManagedApplication')&`$select=appId,appDisplayName"
            $taggedServPrinc = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri $spUri
            $taggedAppIds = $taggedServPrinc.value | Select-Object -ExpandProperty appId

            #Write-Host "Reading Microsoft Entra applications. This operation might take longer..." -ForegroundColor Green
            $appsUri = "/beta/applications?`$top=999&`$select=appId,displayName"
            $allApps = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri $appsUri
            $allAppsDict = @{}
            foreach ($app in $allApps.value) {
                $allAppsDict[$app.appId] = $app.displayName
            }

            #Write-Host "Reading connector groups. This operation might take longer..." -ForegroundColor Green
            $cgUri = "/beta/onPremisesPublishingProfiles/$ProfileId/connectorGroups"
            $connectorGroups = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri $cgUri

            $groupsToProcess = if ($ConnectorGroupId) {
                $connectorGroups.value | Where-Object { $_.id -eq $ConnectorGroupId }
            } else {
                $connectorGroups.value
            }

            $output = @()
            foreach ($group in $groupsToProcess) {
                if ($group.connectorGroupType -eq "applicationProxy") {
                    $appsUri = "/beta/onPremisesPublishingProfiles/$ProfileId/connectorGroups/$($group.id)/applications"
                    $assignedApps = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri $appsUri

                    foreach ($app in $assignedApps.value) {
                        if ($taggedAppIds -contains $app.appId) {
                            $output += [PSCustomObject]@{
                                ConnectorGroupName = $group.name
                                ConnectorGroupId   = $group.id
                                Region             = $group.region
                                AppDisplayName     = $allAppsDict[$app.appId]
                                AppId              = $app.appId
                            }
                        }
                    }
                }
            }

            # Show the response value if it exists
            if ($output) {
                Write-Output $output
            }
            else {
                Write-Error "Failed to retrieve the connector group assigned private access applications."
            }
        }
        catch {
            Write-Error "An error occurred while retrieving connector group assignments: $_"
        }
    }
}