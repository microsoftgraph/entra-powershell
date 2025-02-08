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
            $baseUri = 'https://login.microsoftonline.com/common/userrealm/'
            Write-Output  $baseUri
            $uriUserRealm = "$baseUri/$($user)?api-version=$ApiVersion"
            Write-Output  $uriUserRealm
            $Result = Invoke-RestMethod -UseBasicParsing -Method Get -Uri $uriUserRealm
            Write-Output $Result
        }
    }
}