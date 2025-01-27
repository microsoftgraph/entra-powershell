# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Reset-EntraStrongAuthenticationMethodByUpn {
    [CmdletBinding(DefaultParameterSetName = 'SetAccidentalDeletionThreshold')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][System.String] $UserPrincipalName,
        [Parameter(ParameterSetName = "SetAccidentalDeletionThreshold", ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId
        )

    PROCESS {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["UserPrincipalName"]) {
            $userId = $PSBoundParameters.UserPrincipalName
        }
        function DeleteAuthMethod($uid, $method){
            switch ($method.AdditionalProperties['@odata.type']) {
                '#microsoft.graph.emailAuthenticationMethod' { 
                    Remove-MgUserAuthenticationEmailMethod -UserId $uid -EmailAuthenticationMethodId $method.Id
                }
                '#microsoft.graph.phoneAuthenticationMethod' { 
                    Remove-MgUserAuthenticationPhoneMethod -UserId $uid -PhoneAuthenticationMethodId $method.Id
                }
                Default {
                    
                }
            }
            return $? # Return true if no error and false if there is an error
        }

        $methods = Get-MgUserAuthenticationMethod -UserId $userId -Headers $customHeaders
        # -1 to account for passwordAuthenticationMethod

        foreach ($authMethod in $methods) {
            $deleted = DeleteAuthMethod -uid $userId -method $authMethod
            if(!$deleted){
                # We need to use the error to identify and delete the default method.
                $defaultMethod = $authMethod
            }
        }

        # Graph API does not support reading default method of a user.
        # Plus default method can only be deleted when it is the only (last) auth method for a user.
        # We need to use the error to identify and delete the default method.
        try {
            if($null -ne $defaultMethod){
                $result = DeleteAuthMethod -uid $userId -method $defaultMethod
            }
        }
        catch {}
   
        if($null -ne $methods){
            $methods = Get-MgUserAuthenticationMethod -UserId $userId
        }
    }
}
