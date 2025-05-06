# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaPrivateAccessApplication {
    
    [CmdletBinding(DefaultParameterSetName = 'AllPrivateAccessApps')]
    param (
        [Alias("ObjectId")]
        [Parameter(Mandatory = $True, ParameterSetName = 'SingleAppID')]
        [System.String]
        $ApplicationId,
        
        [Parameter(Mandatory = $False, ParameterSetName = 'SingleAppName')]
        [System.String]
        $ApplicationName
    )

    PROCESS {
        try {
            # Create custom headers for the request
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

            switch ($PSCmdlet.ParameterSetName) {
                "AllPrivateAccessApps" {
                    # Retrieve all private access applications
                    $response = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri '/beta/applications?$count=true&$select=displayName,appId,id,tags,createdDateTime,servicePrincipalType,createdDateTime,servicePrincipalNames&$filter=tags/Any(x: x eq ''PrivateAccessNonWebApplication'') or tags/Any(x: x eq ''NetworkAccessManagedApplication'') or tags/Any(x: x eq ''NetworkAccessQuickAccessApplication'')'
                    $response.value
                    break
                }
                "SingleAppID" {
                    # Retrieve a single application by ID
                    $response = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri "/beta/applications/$ApplicationId/?`$select=displayName,appId,id,tags,createdDateTime,servicePrincipalType,createdDateTime,servicePrincipalNames"
                    $response
                    break
                }
                "SingleAppName" {
                    # Retrieve a single application by name
                    $response = Invoke-GraphRequest -Method GET -Headers $customHeaders -OutputType PSObject -Uri "/beta/applications?`$count=true&`$select=displayName,appId,id,tags,createdDateTime,servicePrincipalType,createdDateTime,servicePrincipalNames&`$filter=DisplayName eq '$ApplicationName'"
                    $response.value
                    break
                }
            }
        }
        catch {
            Write-Error "Failed to retrieve the application(s): $_"
        }
    }
}
