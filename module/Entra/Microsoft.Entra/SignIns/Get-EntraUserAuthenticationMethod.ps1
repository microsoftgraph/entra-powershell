# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraUserAuthenticationMethod {
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
            $params = @{}
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
            $encodedUserId = [System.Web.HttpUtility]::UrlEncode($UserId)
            $uri = "/v1.0/users/$encodedUserId/authentication/methods"

            Write-Debug("============================ REQUEST DETAILS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
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
                $authMethodType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphAuthenticationMethod
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
            $statusCode = $null
            if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
                $statusCode = $_.Exception.Response.StatusCode.value__
            }
            
            if ($statusCode -eq 404) {
                Write-Error "User with ID '$UserId' not found or you don't have permissions to access their authentication methods."
            } 
            elseif ($statusCode -eq 403) {
                Write-Error "Insufficient permissions. Ensure you have `UserAuthenticationMethod.Read.All` scopes."
            }
            elseif ($statusCode -eq 401) {
                Write-Error "Unauthorized access. Please run `Connect-Entra -Scopes UserAuthenticationMethod.Read.All` to authenticate."
            }
            else {
                Write-Error "An error occurred: $($_.Exception.Message)"
            } 
        }
    }
}
