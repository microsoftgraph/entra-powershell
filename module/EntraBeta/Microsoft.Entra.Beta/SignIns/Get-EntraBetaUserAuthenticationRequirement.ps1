# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaUserAuthenticationRequirement {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The User ID (ObjectId or UserPrincipalName) of the user whose authentication requirements you want to retrieve.")]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [System.String] $UserId
    )

    begin {

        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Policy.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

    }

    PROCESS {
        try {
            if ($PSBoundParameters.ContainsKey("Verbose")) {
                Write-Verbose "Retrieving authentication requirements for user: $UserId"
            }
            # Initialize parameters and headers
            $params = @{}
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
            $encodedUserId = [System.Web.HttpUtility]::UrlEncode($UserId)
            $baseUri = "/beta/users/$encodedUserId"
            $params["Uri"] = "$baseUri/authentication/requirements"

            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")

            # Make the API call
            $response = Invoke-MgGraphRequest -Uri $($params.Uri) -Method GET -Headers $customHeaders | ConvertTo-Json | ConvertFrom-Json

            # Return the response
            return $response
        }
        catch {
            $statusCode = $null
            if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
                $statusCode = $_.Exception.Response.StatusCode.value__
            }
            
            # Handle different error scenarios
            if ($statusCode -eq 404 -or $errorMessage -match "ResourceNotFound" -or $errorMessage -match "not found") {
                Write-Error "User with ID '$UserId' not found or you don't have permissions to access their authentication requirements."
            } 
            elseif ($statusCode -eq 403 -or $errorMessage -match "Authorization_RequestDenied") {
                Write-Error "Insufficient permissions. Ensure you have Policy.Read.All scopes."
            }
            elseif ($statusCode -eq 401 -or $errorMessage -match "Authentication_MissingOrMalformed") {
                Write-Error "Unauthorized access. Please run Connect-Entra -Scopes Policy.Read.All to authenticate."
            }
            else {
                Write-Error "An error occurred retrieving authentication requirements: $errorMessage"
            }
        }
    }
}
