# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Remove-EntraBetaUserAuthenticationMethod {
    [CmdletBinding()]
    param (
        # The user UPN or ID to delete the authentication methods for.
        [string]
        [Parameter(ParameterSet="Default",HelpMessage="Specify the UserId for which the authentication methods will be removed.")]
        [string]
        $UserId
    )

    process{

       $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
       
    function DeleteAuthMethod($uid, $method) {
        switch ($method.AdditionalProperties['@odata.type']) {
            '#microsoft.graph.emailAuthenticationMethod' {
                Write-Host 'Removing emailAuthenticationMethod'
                Remove-MgBetaUserAuthenticationEmailMethod -UserId $uid -EmailAuthenticationMethodId $method.Id -Headers $customHeaders
            }
            '#microsoft.graph.fido2AuthenticationMethod' {
                Write-Host 'Removing fido2AuthenticationMethod'
                Remove-MgBetaUserAuthenticationFido2Method -UserId $uid -Fido2AuthenticationMethodId $method.Id
            }
            '#microsoft.graph.microsoftAuthenticatorAuthenticationMethod' {
                Write-Host 'Removing microsoftAuthenticatorAuthenticationMethod'
                Remove-MgBetaUserAuthenticationMicrosoftAuthenticatorMethod -UserId $uid -MicrosoftAuthenticatorAuthenticationMethodId $method.Id -Headers $customHeaders
            }
            '#microsoft.graph.phoneAuthenticationMethod' {
                Write-Host 'Removing phoneAuthenticationMethod'
                Remove-MgBetaUserAuthenticationPhoneMethod -UserId $uid -PhoneAuthenticationMethodId $method.Id -Headers $customHeaders
            }
            '#microsoft.graph.softwareOathAuthenticationMethod' {
                Write-Host 'Removing softwareOathAuthenticationMethod'
                Remove-MgBetaUserAuthenticationSoftwareOathMethod -UserId $uid -SoftwareOathAuthenticationMethodId $method.Id -Headers $customHeaders
            }
            '#microsoft.graph.temporaryAccessPassAuthenticationMethod' {
                Write-Host 'Removing temporaryAccessPassAuthenticationMethod'
                Remove-MgBetaUserAuthenticationTemporaryAccessPassMethod -UserId $uid -TemporaryAccessPassAuthenticationMethodId $method.Id -Headers $customHeaders
            }
            '#microsoft.graph.windowsHelloForBusinessAuthenticationMethod' {
                Write-Host 'Removing windowsHelloForBusinessAuthenticationMethod'
                Remove-MgBetaUserAuthenticationWindowsHelloForBusinessMethod -UserId $uid -WindowsHelloForBusinessAuthenticationMethodId $method.Id -Headers $customHeaders
            }
            '#microsoft.graph.passwordAuthenticationMethod' {
                # Password cannot be removed currently
                Write-Host "Password Authentication Method cannot be removed currrently." -ForegroundColor Yellow
            }
            Default {
                Write-Host 'This script does not handle removing this auth method type: ' + $method.AdditionalProperties['@odata.type']
            }
        }
        return $? # Return true if no error and false if there is an error
    }

    $methods = Get-MgBetaUserAuthenticationMethod -UserId $userId
    # -1 to account for passwordAuthenticationMethod
    $methods = @($methods) # Convert to array
    Write-Host "Found $($methods.Length - 1) auth method(s) for $userId"

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
    if ($null -ne $defaultMethod) {
        Write-Host "Removing default auth method"
        $result = DeleteAuthMethod -uid $userId -method $defaultMethod
    }

    Write-Host "Re-checking auth methods..."
    $methods = Get-MgBetaUserAuthenticationMethod -UserId $userId
    $methods = @($methods) # Convert to array
    # -1 to account for passwordAuthenticationMethod
    Write-Host "Found $($methods.Length - 1) auth method(s) for $userId"
    }
 
}

