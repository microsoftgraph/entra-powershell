# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Update-EntraBetaUserAuthenticationRequirement {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Enter the User ID (ObjectId or UserPrincipalName) of the user whose authentication requirements you want to update.")]
        [Alias("ObjectId")]
        [System.String] $UserId,

        [Parameter(Mandatory = $true, HelpMessage = "Specify the per-user MFA state. Valid values are 'enabled', 'disabled', 'enforced' or 'unknownFutureValue'.")]
        [ValidateSet("enabled", "disabled", "enforced" , "unknownFutureValue")]
        [System.String] $PerUserMfaState
    )

    PROCESS {
        try {
            # Initialize headers and URI
            $params = @{}
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
            $uri = "https://graph.microsoft.com/beta/users/$UserId/authentication/requirements"

            # Create the body for the PATCH request
            $body = @{
                perUserMfaState = $PerUserMfaState
            } | ConvertTo-Json -Depth 10

            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")

            # Make the API call
            $response = Invoke-RestMethod -Headers $customHeaders -Uri $uri -Method Patch -ContentType "application/json" -Body $body

            # Return the response
            return $response
        } catch {
            Write-Error "An error occurred while updating user authentication requirements: $_"
        }
    }
}