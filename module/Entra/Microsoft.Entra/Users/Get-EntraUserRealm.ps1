# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Get-EntraUserRealm {
    [CmdletBinding()]
    [OutputType([PsCustomObject[]])]
    param (
        # User Principal Name
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, Position = 1)]
        [string[]] $User,
        # Check For Microsoft Account
        [Parameter(Mandatory = $false)]
        [switch] $CheckForMicrosoftAccount,
        # API Version
        [Parameter(Mandatory = $false)]
        [string] $ApiVersion = '2.1'
    )

    process {
        foreach ($_User in $User) {
            $uriUserRealm = New-Object System.UriBuilder 'https://login.microsoftonline.com/common/userrealm'
            $uriUserRealm.Query = ConvertTo-QueryString @{
                'api-version'              = $ApiVersion
                'checkForMicrosoftAccount' = $CheckForMicrosoftAccount
                'user'                     = $_User
            }

            $Result = Invoke-RestMethod -UseBasicParsing -Method Get -Uri $uriUserRealm.Uri.AbsoluteUri
            Write-Output $Result
        }
    }
}