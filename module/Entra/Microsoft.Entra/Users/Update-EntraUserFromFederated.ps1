# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Update-EntraUserFromFederated {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingUserNameAndPassWordParams", "", Scope = "Function", Target = "*")]
    [CmdletBinding(DefaultParameterSetName = 'CloudOnlyPasswordScenarios')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "UserPrincipalName of the user to update.")]
        [Alias('UserId')]
        [System.String] $UserPrincipalName,

        [Parameter(ParameterSetName = "HybridPasswordScenarios", Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "New password for the user.")]
        [SecureString] $NewPassword,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "TenantId of the user to update.")]
        [Obsolete("It ensures backward compatibility with Azure AD and MSOnline for partner scenarios. The TenantID applies to the logged-in resource.")]
        [guid] $TenantId      
    )

    PROCESS {    
        # Define essential variables
        $authenticationMethodId = "28c10230-6103-485e-b985-444c60001490"
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $params["UserId"] = $UserPrincipalName
        $params["Url"] = "https://graph.microsoft.com/v1.0/users/$($UserPrincipalName)/authentication/methods/$($authenticationMethodId)/resetPassword"

        # Handle password conversion securely
        if ($PSBoundParameters.ContainsKey("NewPassword") -and $NewPassword) {
            $newSecurePassword = [System.Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocUnicode($NewPassword)
            try {
                $newPasswordValue = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($newSecurePassword)
                $params["NewPassword"] = $newPasswordValue
            }
            finally {
                [System.Runtime.InteropServices.Marshal]::ZeroFreeGlobalAllocUnicode($newSecurePassword)  # Securely free memory
            }

            # Create request body with new password
            $body = @{
                newPassword = $params["NewPassword"]
            } | ConvertTo-Json
        }
        else {
            # Create an empty body
            $body = @{} | ConvertTo-Json
        }

        # Debugging output
        Write-Debug "============================ TRANSFORMATIONS ============================"
        $params.Keys | ForEach-Object { Write-Debug "$_ : $($params[$_])" }
        Write-Debug "=========================================================================`n"

        # Invoke request
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params.Url -Method POST -Body $body
        return $response
    }
}