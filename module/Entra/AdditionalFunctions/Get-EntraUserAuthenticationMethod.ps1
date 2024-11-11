# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraUserAuthenticationMethod {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Enter the User ID (ObjectId or UserPrincipalName) of the user whose authentication requirements you want to update.")]
        [Alias("ObjectId")]
        [System.String] $UserId
    )

    PROCESS {
        try {
            # Initialize headers and URI
            $params = @{}
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

            if ($null -ne $PSBoundParameters["UserId"]) {
                $params["UserId"] = $PSBoundParameters["UserId"]
            }

            $params["Url"] = "https://graph.microsoft.com/v1.0/users/$($params.UserId)/authentication/methods"

            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")

            # Make the API call
            $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params.Url -Method GET

            # Extract keys and values from the response
            $responseObject = $response | ConvertFrom-Json

            return $responseObject
        }
        catch {
            Write-Error "An error occurred while updating user authentication requirements: $_"
        }
    }
}