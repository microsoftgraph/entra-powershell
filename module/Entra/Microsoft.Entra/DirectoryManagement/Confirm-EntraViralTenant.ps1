# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------
function Confirm-EntraViralTenant {
    [CmdletBinding()]
    param (
        # User Principal Name or Email
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = "Enter the user's UPN or email address.")]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern("^[^@\s]+@[^@\s]+\.[^@\s]+$")] # Validate email format
        [Alias("Email")]
        [string]$UserEmail
    )

    process {
        try {
            $ApiVersion = "2.1"
            $IsViralTenant = $false
            # Validate email address format (defense in depth)
            if (-not $UserEmail -or -not $UserEmail.Contains("@")) {
                throw "Invalid email address format: $UserEmail"
            }

            # Build the URI for user realm discovery
            $uriBuilder = New-Object System.UriBuilder "https://login.microsoftonline.com/common/userrealm/$UserEmail"
                
            # Add the query string for the API version
            if (![string]::IsNullOrWhiteSpace($uriBuilder.Query)) {
                $uriBuilder.Query = $uriBuilder.Query.TrimStart('?') + "&api-version=$ApiVersion"
            }
            else {
                $uriBuilder.Query = "api-version=$ApiVersion"
            }
            $uri = $uriBuilder.Uri.AbsoluteUri

            # Call the user realm discovery endpoint
            $response = Invoke-RestMethod -Method Get -Uri $uri -UseBasicParsing

            if ($response.NameSpaceType -eq "Managed") {
                $IsViralTenant = $false
                Write-Output "The domain for $UserEmail is associated with a managed Microsoft Entra ID tenant."
            }
            elseif ($response.NameSpaceType -eq "Federated") {
                $IsViralTenant = $false
                Write-Output "The domain for $UserEmail is federated and not viral."
            }
            elseif ($response.NameSpaceType -eq "Unknown") {
                $IsViralTenant = $false
                Write-Output "The domain for $UserEmail is unknown or not associated with any tenant."
            }
            else {
                $IsViralTenant = $false
                Write-Output "Unable to determine the tenant type for $UserEmail."
            }

            # Add IsViralTenant property to the response object
            $response | Add-Member -MemberType NoteProperty -Name "IsViralTenant" -Value $IsViralTenant -Force

            # Output the modified response object
            Write-Output $response
        }
        catch {
            Write-Error "Failed to check the tenant type for $UserEmail. $_"
        }
    }
}
