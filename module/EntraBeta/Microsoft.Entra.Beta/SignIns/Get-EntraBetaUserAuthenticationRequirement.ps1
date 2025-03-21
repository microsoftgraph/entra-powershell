# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaUserAuthenticationRequirement {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Alias("ObjectId")]
        [Parameter(ParameterSetName = "GetQuery", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Enter the User ID (ObjectId or UserPrincipalName) of the user whose authentication requirements you want to retrieve.")]
        [System.String] $UserId
    )

    PROCESS {
        try {
            # Initialize parameters and headers
            $params = @{}
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
            $baseUri = "https://graph.microsoft.com/beta/users/$UserId"
            $params["Uri"] = "$baseUri/authentication/requirements"

            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")

            # Make the API call
            $response = Invoke-GraphRequest -Uri $($params.Uri) -Method GET -Headers $customHeaders | Convertto-json | convertfrom-json

            # Return the response
            return $response
        }
        catch {
            Write-Error "An error occurred while retrieving user authentication requirements: $_"
        }
    }
}
