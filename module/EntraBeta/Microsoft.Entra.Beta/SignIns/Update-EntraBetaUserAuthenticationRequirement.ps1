# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Update-EntraBetaUserAuthenticationRequirement {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Enter the User ID (ObjectId or UserPrincipalName) of the user whose authentication requirements you want to update.")]
        [Alias("ObjectId")]
        [System.String] $UserId,

        [Parameter(Mandatory = $true, HelpMessage = "Specify the Multi-Factor Authentication (MFA) state for individual users. Valid values include 'Enabled', 'Disabled', and 'Enforced'.")]
        [System.String] $PerUserMfaState
    )

    PROCESS {
        try {
            # Initialize headers and URI
            $params = @{}
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand

            if ($null -ne $PSBoundParameters["UserId"]) {
                $params["UserId"] = $PSBoundParameters["UserId"]
            }
            if ($null -ne $PSBoundParameters["PerUserMfaState"]) {
                $params["PerUserMfaState"] = $PSBoundParameters["PerUserMfaState"]
            }

            $params["Url"] = "https://graph.microsoft.com/beta/users/$UserId/authentication/requirements"
            # Create the body for the PATCH request
            $body = @{
                perUserMfaState = $PerUserMfaState
            } | ConvertTo-Json -Depth 10

            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")

            # Make the API call
            $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params.Url -Method PATCH -Body $body

            # Return the response
            return $response

            
        }
        catch {
            Write-Error "An error occurred while updating user authentication requirements: $_"
        }
    }
}