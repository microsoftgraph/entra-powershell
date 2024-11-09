# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraBetaUserAuthenticationRequirement {
    [CmdletBinding(DefaultParameterSetName = 'AllRequirements')]
    param (
        [Alias("ObjectId")]
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Enter the User ID (ObjectId or UserPrincipalName) of the user whose authentication requirements you want to retrieve.")]
        [System.String] $UserId
    )

    PROCESS {
        try {
            # Initialize parameters and headers
            $params = @{}
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
            $uri = "https://graph.microsoft.com/beta/users/$UserId/authentication/requirements"

            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")

            # Make the API call
            $response = Invoke-RestMethod -Headers $customHeaders -Uri $uri -Method Get

            # Return the response
            return $response
        } catch {
            Write-Error "An error occurred while retrieving user authentication requirements: $_"
        }
    }
}