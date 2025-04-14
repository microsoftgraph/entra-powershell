# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Add-EntraGroupOwner {
    [CmdletBinding(DefaultParameterSetName = 'ByGroupIdAndOwnerId', SupportsShouldProcess = $true)]
    param (
        [Alias('ObjectId')]
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $false, ParameterSetName = 'ByGroupIdAndOwnerId', 
            HelpMessage = "Unique ID of the group. Should be a valid GUID value.")]
        [ValidateNotNullOrEmpty()]
        [Guid] $GroupId,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, 
            HelpMessage = "Object ID of a user or service principal to assign as a group owner.")]
        [Alias('RefObjectId', 'Id')]
        [ValidateNotNullOrEmpty()]
        [Guid] $OwnerId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Group.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
        
        # Get the Graph endpoint from the current environment
        $environment = (Get-EntraContext).Environment
        $graphEndpoint = (Get-EntraEnvironment | Where-Object Name -eq $environment).GraphEndPoint
        
        # Default to global endpoint if not found
        if (-not $graphEndpoint) {
            $graphEndpoint = "https://graph.microsoft.com"
            Write-Verbose "Using default Graph endpoint: $graphEndpoint"
        }
        else {
            Write-Verbose "Using environment-specific Graph endpoint: $graphEndpoint"
        }
    }

    PROCESS {
        try {
            # Get custom headers for Microsoft Graph API requests
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
            
            # Set up the request parameters
            $params = @{
                Method      = "POST"
                Uri         = "/v1.0/groups/$GroupId/owners/`$ref"
                Headers     = $customHeaders
                Body        = @{
                    "@odata.id" = "$graphEndpoint/v1.0/directoryObjects/$OwnerId"
                } | ConvertTo-Json
                ContentType = "application/json"
            }
            
            # Debug output
            Write-Debug("============================ TRANSFORMATIONS ============================")
            Write-Debug("Uri : $($params.Uri)")
            Write-Debug("Method : $($params.Method)")
            Write-Debug("Body : $($params.Body)")
            Write-Debug("GroupId : $GroupId")
            Write-Debug("OwnerId : $OwnerId")
            Write-Debug("=========================================================================`n")
            
            # Add ShouldProcess to prevent accidental modifications
            if ($PSCmdlet.ShouldProcess("Add owner '$OwnerId' to group '$GroupId'")) {
                Write-Verbose "Adding owner $OwnerId to group $GroupId"
                
                # Make the API call
                $response = Invoke-MgGraphRequest @params
                
                # Create a custom object for output
                if ($null -eq $response) {
                    $result = [PSCustomObject]@{
                        GroupId = $GroupId
                        OwnerId = $OwnerId
                        Status  = "Success"
                        Action  = "Added"
                    }
                    return $result
                }
                
                return $response
            }
        }
        catch {
            # Handle error messages based on the failure
            $statusCode = $null
            if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
                $statusCode = $_.Exception.Response.StatusCode.value__
            }
            
            if ($statusCode -eq 404) {
                Write-Error "Either group $GroupId or owner $OwnerId not found."
            }
            elseif ($statusCode -eq 403) {
                Write-Error "You don't have permission to add owners to this group. To connect, use 'Connect-Entra -Scopes Group.ReadWrite.All'"
            }
            elseif ($statusCode -eq 400 -and $_.Exception.Message -match "One or more added object references already exist") {
                Write-Warning "Owner $OwnerId is already a owner of group $GroupId."
            }
            else {
                Write-Error "Failed to add owner: $_"
            }
        }
    }
}
Set-Alias -Name New-EntraGroupOwner -Value Add-EntraGroupOwner -Scope Global -Force
