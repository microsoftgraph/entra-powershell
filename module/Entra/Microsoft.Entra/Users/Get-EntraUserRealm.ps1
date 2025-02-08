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

        # Check For Microsoft Account
        [Parameter(Mandatory = $false, HelpMessage = 'Check for Microsoft Account')]
        [switch] $CheckForMicrosoftAccount,

        # API Version
        [Parameter(Mandatory = $false, HelpMessage = 'API Version, will default to 2.1')]
        [string] $ApiVersion = '2.1'
    )

    process {
        foreach ($user in $UserIds) {
            try {
                $uriBuilder = New-Object System.UriBuilder "https://login.microsoftonline.com/common/userrealm/$user"
                $uriBuilder.Query = [System.Web.HttpUtility]::ParseQueryString("api-version=$ApiVersion")
                $uri = $uriBuilder.Uri.AbsoluteUri
                $Result = Invoke-RestMethod -UseBasicParsing -Method Get -Uri $uri
                Write-Output $Result
            }
            catch {
                Write-Error "Failed to retrieve user realm information for $user $_"
            }
        }
    }
}