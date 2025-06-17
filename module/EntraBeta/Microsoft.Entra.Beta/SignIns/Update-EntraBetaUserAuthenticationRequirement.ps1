# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Update-EntraBetaUserAuthenticationRequirement {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Enter the User ID (ObjectId or UserPrincipalName) of the user whose authentication requirements you want to update.")]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [System.String] $UserId,

        [Parameter(Mandatory = $true, HelpMessage = "Specify the Multi-Factor Authentication (MFA) state for individual users. Valid values include 'Enabled', 'Disabled', and 'Enforced'.")]
        [ValidateSet('Enabled', 'Disabled', 'Enforced')]
        [System.String] $PerUserMfaState
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Policy.ReadWrite.AuthenticationMethod' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        try {

            if ($PSBoundParameters.ContainsKey("Verbose")) {
                Write-Verbose "Updating authentication requirements for user: $UserId"
                Write-Verbose "Setting MFA state to: $PerUserMfaState"
            }

            # Initialize headers and URI
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

            # Proper URL encoding for the UserId to handle special characters
            $encodedUserId = [System.Web.HttpUtility]::UrlEncode($UserId)
            $uri = "/beta/users/$encodedUserId/authentication/requirements"
            
            # Create the body for the PATCH request
            $body = @{
                perUserMfaState = $PerUserMfaState
            } | ConvertTo-Json -Depth 10

            Write-Debug("============================ REQUEST DETAILS ============================")
            Write-Debug("URI: $uri")
            Write-Debug("Body: $body")
            Write-Debug("=========================================================================`n")

            # Make the API call
            $response = Invoke-MgGraphRequest -Headers $customHeaders -Uri $uri -Method PATCH -Body $body

            # Return the response
            return $response
            
        }
        catch {
            $statusCode = $null
            if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
                $statusCode = $_.Exception.Response.StatusCode.value__
            }
            
            if ($statusCode -eq 404) {
                Write-Error "User with ID '$UserId' not found or you don't have permissions to access their authentication requirements."
            } 
            elseif ($statusCode -eq 403) {
                Write-Error "Insufficient permissions. Ensure you have `Policy.ReadWrite.AuthenticationMethod` scopes. Please run `Connect-Entra -Scopes Policy.ReadWrite.AuthenticationMethod` to authenticate."
            }
            elseif ($statusCode -eq 401) {
                Write-Error "Unauthorized access. Please run `Connect-Entra -Scopes Policy.ReadWrite.AuthenticationMethod` to authenticate."
            }
            else {
                Write-Error "An error occurred: $($_.Exception.Message)"
                Write-Error "An error occurred while updating user authentication requirements: $_"
            } 
            
        }
    }
}