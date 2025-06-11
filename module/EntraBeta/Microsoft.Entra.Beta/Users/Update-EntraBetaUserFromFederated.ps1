# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Update-EntraBetaUserFromFederated {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingUserNameAndPassWordParams", "", Scope = "Function", Target = "*")]
    [CmdletBinding(DefaultParameterSetName = 'CloudOnlyPasswordScenarios')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "UserPrincipalName of the user to update.")]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserId')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserPrincipalName must be a valid email address or GUID."
            })]
        [System.String] $UserPrincipalName,

        [Parameter(ParameterSetName = "HybridPasswordScenarios", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "New password for the user.")]
        [SecureString] $NewPassword,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "TenantId of the user to update.")]
        [Obsolete("This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID. It should not be used for any other purpose.")]
        [guid] $TenantId      
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes UserAuthenticationMethod.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        # Define essential variables
        $authenticationMethodId = "28c10230-6103-485e-b985-444c60001490"
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{ "UserId" = $UserPrincipalName }
        $params["Url"] = "/beta/users/$($UserPrincipalName)/authentication/methods/$authenticationMethodId/resetPassword"

        # Handle password conversion securely
        $passwordRedacted = $false
        $newPasswordValue = $null
        if ($PSBoundParameters.ContainsKey("NewPassword") -and $NewPassword) {
            $newSecurePassword = [System.Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocUnicode($NewPassword)
            try {
                $newPasswordValue = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($newSecurePassword)
                $params["NewPassword"] = $newPasswordValue
            }
            finally {
                [System.Runtime.InteropServices.Marshal]::ZeroFreeGlobalAllocUnicode($newSecurePassword)  # Securely free memory
            }

            # Mark for redaction
            $passwordRedacted = $true
        }

        # Create JSON body
        $body = if ($passwordRedacted) {
            if ($DebugPreference -ne 'SilentlyContinue') {
                # Redact password in debug mode
                @{ newPassword = "[REDACTED]" } | ConvertTo-Json
            }
            else {
                @{ newPassword = $newPasswordValue } | ConvertTo-Json
            }
        }
        else {
            @{} | ConvertTo-Json
        }

        # Debugging output with redaction
        Write-Debug "========================= TRANSFORMATIONS ========================="
        foreach ($key in $params.Keys) {
            $value = if ($passwordRedacted -and $key -eq "NewPassword") { "[REDACTED]" } else { $params[$key] }
            Write-Debug "$key : $value"
        }
        Write-Debug "JSON Body: $body"
        Write-Debug "==================================================================`n"

        # Invoke request
        try {
            $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params.Url -Method POST -Body $body
            return $response
        }
        catch {
            Write-Error "Failed to update user $($UserPrincipalName): $_"
            return $null
        }
    }
}