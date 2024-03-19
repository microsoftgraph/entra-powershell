# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Update-AzureADSignedInUserPassword"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$customHeaders = New-EntraCustomHeaders -Command `$MyInvocation.MyCommand
        `$keysChanged = @{}
        if(`$null -ne `$PSBoundParameters["NewPassword"])
        {
            `$params["NewPassword"] = `$PSBoundParameters["NewPassword"]
        }
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
        if(`$null -ne `$PSBoundParameters["CurrentPassword"])
        {
            `$params["CurrentPassword"] = `$PSBoundParameters["CurrentPassword"]
        } 
        `$currsecur = [System.Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocUnicode(`$params.CurrentPassword)
        `$curr = [System.Runtime.InteropServices.Marshal]::PtrToStringUni(`$currsecur)
    
        `$newsecur = [System.Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocUnicode(`$params.NewPassword)
        `$new = [System.Runtime.InteropServices.Marshal]::PtrToStringUni(`$newsecur)
    
        `$params["Url"]  = "https://graph.microsoft.com/beta/me/changePassword"
        `$body = @{
            currentPassword = `$curr
            newPassword = `$new 
        }
        `$body = `$body | ConvertTo-Json
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        `$response = Invoke-GraphRequest -Uri `$params.Url -Method POST -Body `$body
        `$response
        }
"@
}