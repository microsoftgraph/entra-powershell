# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Update-EntraUserFromFederated {
        [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "UserPrincipalName of the user to update.")]
        [Alias('UserId')]
        [System.String] $UserPrincipalName,

        [Parameter(Mandatory=$false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName=$true, HelpMessage = "New password for the user.")]
        [SecureString] $NewPassword,

        [Parameter(Mandatory=$false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName=$true, HelpMessage = "TenantId of the user to update.")]
        [guid] $TenantId          
    )

        PROCESS {    
            $params = @{}
            $authenticationMethodId = "28c10230-6103-485e-b985-444c60001490"
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

            if ($null -ne $PSBoundParameters["UserId"]) {
                $UserId = $PSBoundParameters["UserId"]
            }
            if($null -ne $PSBoundParameters["NewPassword"])
            {
                $params["NewPassword"] = $PSBoundParameters["NewPassword"]
            }        
        
            $newsecur = [System.Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocUnicode($params.NewPassword)
            $new = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($newsecur)
        
            $params["Url"]  = "/users/$($UserId)/authentication/methods/$($authenticationMethodId)/resetPassword"
            $body = @{
                newPassword = $new
            }
            $body = $body | ConvertTo-Json
        
            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")
            
            $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params.Url -Method POST -Body $body
            $response
        }   
}

