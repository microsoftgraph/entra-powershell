# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Reset-EntraStrongAuthenticationMethodByUpn {
    [CmdletBinding(DefaultParameterSetName = 'ResetAuthenticationMethod')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = 'The unique identifier for the user (User Principal Name or UserId) whose strong authentication method you want to reset.')]
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

        [Parameter(ParameterSetName = "ResetAuthenticationMethod", ValueFromPipelineByPropertyName = $true, HelpMessage = 'The tenant ID.')]
        [Obsolete("Ensures backward compatibility with Azure AD and MSOnline for partner scenarios. The TenantID applies to the logged-in Tenant ID.")]
        [System.Guid] $TenantId
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
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["UserPrincipalName"]) {
            $userId = $PSBoundParameters.UserPrincipalName
        }
        function DeleteAuthMethod($uid, $method) {
            switch ($method.AdditionalProperties['@odata.type']) {
                '#microsoft.graph.emailAuthenticationMethod' { 
                    Remove-MgUserAuthenticationEmailMethod -UserId $uid -EmailAuthenticationMethodId $method.Id
                }
                '#microsoft.graph.phoneAuthenticationMethod' { 
                    Remove-MgUserAuthenticationPhoneMethod -UserId $uid -PhoneAuthenticationMethodId $method.Id
                }
                '#microsoft.graph.fido2AuthenticationMethod' { 
                    Remove-MgUserAuthenticationFido2Method -UserId $uid -Fido2AuthenticationMethodId $method.Id
                }
                '#microsoft.graph.softwareOathAuthenticationMethod' { 
                    Remove-MgUserAuthenticationSoftwareOathMethod -UserId $uid -SoftwareOathAuthenticationMethodId $method.Id
                }
                '#microsoft.graph.temporaryAccessPassAuthenticationMethod' { 
                    Remove-MgUserAuthenticationTemporaryAccessPassMethod -UserId $uid -TemporaryAccessPassAuthenticationMethodId $method.Id
                }
                '#microsoft.graph.windowsHelloForBusinessAuthenticationMethod' { 
                    Remove-MgUserAuthenticationWindowsHelloForBusinessMethod -UserId $uid -WindowsHelloForBusinessAuthenticationMethodId $method.Id
                }
                '#microsoft.graph.microsoftAuthenticatorAuthenticationMethod' { 
                    Remove-MgUserAuthenticationMicrosoftAuthenticatorMethod -UserId $uid -MicrosoftAuthenticatorAuthenticationMethodId $method.Id
                }
                Default {
                    
                }
            }
            return $? # Return true if no error and false if there is an error
        }

        $methods = Get-MgUserAuthenticationMethod -UserId $userId -Headers $customHeaders
        # -1 to account for passwordAuthenticationMethod

        $defaultMethod = $null

        foreach ($authMethod in $methods) {
            $deleted = DeleteAuthMethod -uid $userId -method $authMethod
            if (!$deleted) {
                # We need to use the error to identify and delete the default method.
                $defaultMethod = $authMethod
            }
        }

        # Graph API does not support reading default method of a user.
        # Plus default method can only be deleted when it is the only (last) auth method for a user.
        # We need to use the error to identify and delete the default method.
        try {
            if ($null -ne $defaultMethod) {
                $result = DeleteAuthMethod -uid $userId -method $defaultMethod
                if (-not $result) {
                    Write-Warning "Could not delete the default authentication method with ID [$($defaultMethod.Id)] for user [$userId]."
                }
            }
            else {
                Write-Verbose "No default authentication method found or all methods were successfully deleted for user [$userId]."
            }
        }
        catch {
            $errorMessage = "Exception occurred while attempting to delete the default method"
            
            # Extract method details if possible
            if ($null -ne $defaultMethod) {
                try {
                    $methodType = $defaultMethod.AdditionalProperties['@odata.type']
                    $methodId = $defaultMethod.Id
                    $errorMessage += " of type [$methodType] with ID [$methodId]"
                }
                catch {
                    # Couldn't extract method details
                    $errorMessage += " (could not determine method type or ID)"
                }
            }
            else {
                $errorMessage += " (method object was null)"
            }
            
            $errorMessage += ": $_"
            Write-Warning $errorMessage
            
            # Add more detailed error info for debugging
            Write-Debug "Exception details: $($_.Exception | ConvertTo-Json -Depth 2)"
        }
    }
}

