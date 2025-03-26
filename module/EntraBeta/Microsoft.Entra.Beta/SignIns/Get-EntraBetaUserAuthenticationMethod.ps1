# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaUserAuthenticationMethod {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The User ID (ObjectId or UserPrincipalName) of the user whose authentication methods you want to retrieve.")]
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
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes UserAuthenticationMethod.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        try {
            if ($PSBoundParameters.ContainsKey("Verbose")) {
                Write-Verbose "Retrieving authentication methods for user: $UserId"
            }
            
            # Initialize headers and URI
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
            $encodedUserId = [System.Web.HttpUtility]::UrlEncode($UserId)
            $uri = "https://graph.microsoft.com/beta/users/$encodedUserId/authentication/methods"

            Write-Debug("============================ REQUEST DETAILS ============================")
            Write-Debug("URI: $uri")
            Write-Debug("=========================================================================`n")

            # Make the API call
            $response = Invoke-MgGraphRequest -Headers $customHeaders -Uri $uri -Method GET

            # Extract the value property if it exists
            if ($response.ContainsKey('value')) {
                $response = $response.value
            }
    
            $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json       
            
            # Create a properly formatted object list
            $authMethodList = @()
            foreach ($res in $data) {
                $authMethodType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphAuthenticationMethod
                $res.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name.Substring(0, 1).ToUpper() + $_.Name.Substring(1)
                    $propertyValue = $_.Value
                    $authMethodType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $authMethodType | Add-Member -MemberType AliasProperty -Name AuthenticationMethodType -Value '@odata.type'
                $authMethodList += $authMethodType
            }

            return $authMethodList
        }
        catch {
            $errorObj = $_
            $statusCode = $null
            $errorMessage = $errorObj.Exception.Message

            # Extract status code using different approaches based on error structure
            if ($errorObj.Exception.Response) {
                try {
                    $statusCode = $errorObj.Exception.Response.StatusCode.value__
                }
                catch {
                    # If StatusCode property doesn't exist
                }
            }
            
            # Try to get status code from ErrorDetails if available
            if (-not $statusCode -and $errorObj.ErrorDetails) {
                try {
                    $errorContent = $errorObj.ErrorDetails | ConvertFrom-Json -ErrorAction SilentlyContinue
                    if ($errorContent.error.code) {
                        $statusCode = $errorContent.error.code
                    }
                    if ($errorContent.error.message) {
                        $errorMessage = $errorContent.error.message
                    }
                }
                catch {
                    # If conversion fails
                }
            }
            
            # Handle different error scenarios
            if ($statusCode -eq 404 -or $errorMessage -match "ResourceNotFound" -or $errorMessage -match "not found") {
                Write-Error "User with ID '$UserId' not found or you don't have permissions to access their authentication methods."
            } 
            elseif ($statusCode -eq 403 -or $errorMessage -match "Authorization_RequestDenied") {
                Write-Error "Insufficient permissions. Ensure you have UserAuthenticationMethod.Read.All scopes."
            }
            elseif ($statusCode -eq 401 -or $errorMessage -match "Authentication_MissingOrMalformed") {
                Write-Error "Unauthorized access. Please run Connect-Entra -Scopes UserAuthenticationMethod.Read.All to authenticate."
            }
            else {
                Write-Error "An error occurred retrieving authentication methods: $errorMessage"
            }
        }
    }
}
