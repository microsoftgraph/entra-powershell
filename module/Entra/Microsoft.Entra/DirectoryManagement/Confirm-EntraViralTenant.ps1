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
        [string]$UserEmail
    )

    process {
        try {
            $ApiVersion = "2.1"
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

            Write-Host "URI: $uri"

            # Call the user realm discovery endpoint
            $response = Invoke-RestMethod -Method Get -Uri $uri -UseBasicParsing

            Write-Host "Response: $response"

            # Parse the response
            if ($response.NameSpaceType -eq "Managed" -and $response.is_viral_tenant -eq $true) {
                Write-Output "The domain for $UserEmail is associated with a viral (unmanaged) Microsoft Entra ID tenant."
            }
            elseif ($response.NameSpaceType -eq "Managed") {
                Write-Output "The domain for $UserEmail is associated with a managed Microsoft Entra ID tenant."
            }
            elseif ($response.NameSpaceType -eq "Federated") {
                Write-Output "The domain for $UserEmail is federated and not viral."
            }
            elseif ($response.NameSpaceType -eq "Unknown") {
                Write-Output "The domain for $UserEmail is unknown or not associated with any tenant."
            }
            else {
                Write-Output "Unable to determine the tenant type for $UserEmail."
            }
        }
        catch {
            Write-Error "Failed to check the tenant type for $UserEmail. $_"
        }
    }
}
<# 
function Confirm-EntraViralTenant {
    [CmdletBinding()]
    param (
        # User Principal Name or Email
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, HelpMessage = "Enter the user's UPN or email address.")]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern("^[^@\s]+@[^@\s]+\.[^@\s]+$")] # Validate email format
        [string]$UserEmail
    )

    process {
        try {
            # Validate email address format (defense in depth)
            if (-not $UserEmail -or -not $UserEmail.Contains("@")) {
                throw "Invalid email address format: $UserEmail"
            }

            # Build the URI for user realm discovery
            $baseUri = "https://login.microsoftonline.com/common/userrealm/"
            $encodedEmail = [uri]::EscapeDataString($UserEmail) # Ensure the email is properly URL-encoded
            $uri = "$baseUri$encodedEmail?api-version=2.1"

            Write-Host "URI: $uri"

            # Securely call the user realm discovery endpoint
            $response = Invoke-RestMethod -Method Get -Uri $uri -UseBasicParsing -ErrorAction Stop

            Write-Host "Response: $response"

            # Parse the response and ensure its integrity
            if ($response -and $response.NameSpaceType) {
                switch ($response.NameSpaceType) {
                    "Managed" {
                        if ($response.is_viral_tenant -eq $true) {
                            Write-Output "The domain for $UserEmail is associated with a viral (unmanaged) Microsoft Entra ID tenant."
                        }
                        else {
                            Write-Output "The domain for $UserEmail is associated with a managed Microsoft Entra ID tenant."
                        }
                    }
                    "Federated" {
                        Write-Output "The domain for $UserEmail is federated and not viral."
                    }
                    "Unknown" {
                        Write-Output "The domain for $UserEmail is unknown or not associated with any tenant."
                    }
                    default {
                        Write-Output "Unable to determine the tenant type for $UserEmail."
                    }
                }
            }
            else {
                throw "Unexpected response format from the server."
            }
        }
        catch {
            # Log detailed error messages for auditing and debugging
            Write-Error "Failed to check the tenant type for $UserEmail. Error: $_"
        }
    }
}
 #>