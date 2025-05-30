# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Update-EntraBetaSignedInUserPassword {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Security.SecureString] $NewPassword,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Security.SecureString] $CurrentPassword
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Directory.AccessAsUser.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["NewPassword"]) {
            $params["NewPassword"] = $PSBoundParameters["NewPassword"]
        }
        if ($null -ne $PSBoundParameters["CurrentPassword"]) {
            $params["CurrentPassword"] = $PSBoundParameters["CurrentPassword"]
        } 
        $currsecur = [System.Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocUnicode($params.CurrentPassword)
        $curr = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($currsecur)
    
        $newsecur = [System.Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocUnicode($params.NewPassword)
        $new = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($newsecur)
    
        $params["Url"] = "/beta/me/changePassword"
        $body = @{
            currentPassword = $curr
            newPassword     = $new 
        }
        $body = $body | ConvertTo-Json
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================
")
        
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params.Url -Method POST -Body $body
        $response
    }     
}

