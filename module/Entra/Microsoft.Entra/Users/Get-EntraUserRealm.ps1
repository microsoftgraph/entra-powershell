# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraUserRealm {
    [CmdletBinding()]
    [OutputType([PsCustomObject[]])]
    param (
        # User Principal Name
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, HelpMessage = 'A list of UserIds or User Principal Names')]
        [ValidateNotNullOrEmpty()]
        [string[]] $UserIds,

        # API Version
        [Parameter(Mandatory = $false, HelpMessage = 'API Version, will default to 2.1')]
        [string] $ApiVersion = '2.1'
    )

    process {
        foreach ($user in $UserIds) {
            try {
                # Build the base URI
                $uriBuilder = New-Object System.UriBuilder "https://login.microsoftonline.com/common/userrealm/$user"
                
                # Add the query string for the API version
                if (![string]::IsNullOrWhiteSpace($uriBuilder.Query)) {
                    $uriBuilder.Query = $uriBuilder.Query.TrimStart('?') + "&api-version=$ApiVersion"
                }
                else {
                    $uriBuilder.Query = "api-version=$ApiVersion"
                }
                $uri = $uriBuilder.Uri.AbsoluteUri
                
                # Make the REST API call
                $Result = Invoke-RestMethod -UseBasicParsing -Method Get -Uri $uri
                
                # Output the result
                Write-Output $Result
            }
            catch {
                Write-Error "Failed to retrieve user realm information for $user. $_"
            }
        }
    }
}
