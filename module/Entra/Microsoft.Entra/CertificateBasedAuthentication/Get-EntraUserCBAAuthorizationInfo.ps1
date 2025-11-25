# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraUserCBAAuthorizationInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'The unique identifier for the user (User Principal Name or UserId).')]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [string]$UserId,

        [Parameter(Mandatory = $false, HelpMessage = 'If specified`, returns the raw response from the API.')]
        [Alias('RawResponse')]
        [switch]$Raw
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Directory.ReadWrite.All, User.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    process {
        try {
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
            # Determine if UserId is a GUID (ObjectId) or a UserPrincipalName
            $isGuid = $UserId -match "^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$"
            $filter = if ($isGuid) { "id eq '$UserId'" } else { "userPrincipalName eq '$UserId'" }
            
            # First look up the user to get the ID if not already a GUID
            $uri = "/v1.0/users?`$filter=$filter"
            $lookupCustomHeaders = @{} + $customHeaders + @{"ConsistencyLevel" = "eventual" }
            $userLookup = Invoke-MgGraphRequest -Uri $uri -Method GET -Headers $lookupCustomHeaders -ErrorAction Stop
            
            if ($userLookup.value.Count -eq 0) {
                throw "User '$UserId' not found in Entra ID"
            }
            
            $userId = $userLookup.value[0].id
            
            # Now fetch the authorization info
            $apiCallUrl = "/v1.0/users/$userId`?`$select=id,displayName,userPrincipalName,userType,authorizationInfo"
            $response = Invoke-MgGraphRequest -Uri $apiCallUrl -Method GET -Headers $customHeaders -ErrorAction Stop
            
            # If Raw switch is specified, return the raw response
            if ($Raw) {
                return $response
            }
            
            # Create a structured object for the certificate user IDs
            $certificateUserIds = @()
            
            if ($response.authorizationInfo -and $response.authorizationInfo.certificateUserIds) {
                foreach ($certId in $response.authorizationInfo.certificateUserIds) {
                    if ($certId -match 'X509:<([^>]+)>(.+)') {
                        $type = $matches[1]
                        $value = $matches[2]
                        
                        # Create a descriptive name for the certificate type
                        $typeName = switch ($type) {
                            "PN" { "PrincipalName" }
                            "S" { "Subject" }
                            "I" { "Issuer" }
                            "SR" { "SerialNumber" }
                            "SKI" { "SubjectKeyIdentifier" }
                            "SHA1-PUKEY" { "SHA1PublicKey" }
                            default { $type }
                        }
                        
                        $certificateUserIds += [PSCustomObject]@{
                            Type           = $type
                            TypeName       = $typeName
                            Value          = $value
                            OriginalString = $certId
                        }
                    }
                    else {
                        # For any ID that doesn't match the expected format
                        $certificateUserIds += [PSCustomObject]@{
                            Type           = "Unknown"
                            TypeName       = "Unknown"
                            Value          = $certId
                            OriginalString = $certId
                        }
                    }
                }
            }
            
            # Create a structured AuthorizationInfo object
            $authInfo = [PSCustomObject]@{
                CertificateUserIds   = $certificateUserIds
                RawAuthorizationInfo = $response.authorizationInfo
            }
            
            # Create a custom output object with the properties of interest
            $result = [PSCustomObject]@{
                Id                = $response.id
                DisplayName       = $response.displayName
                UserPrincipalName = $response.userPrincipalName
                UserType          = $response.userType
                AuthorizationInfo = $authInfo
            }
            
            return $result
        }
        catch {
            $errorDetails = $_.Exception.Message
            Write-Error "Failed to retrieve authorization info: $errorDetails"
            throw
        }
    }

    end {
        # Cleanup if needed
    }
}

Set-Alias -Name Get-EntraUserAuthorizationInfo -Value Get-EntraUserCBAAuthorizationInfo -Description "Gets a user's authorization information from Microsoft Entra ID" -Scope Global -Force
