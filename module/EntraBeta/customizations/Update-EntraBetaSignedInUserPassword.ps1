# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Update-AzureADSignedInUserPassword"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{}
        if($null -ne $PSBoundParameters["NewPassword"])
        {
            $params["NewPassword"] = $PSBoundParameters["NewPassword"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
	    if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if($null -ne $PSBoundParameters["CurrentPassword"])
        {
            $params["CurrentPassword"] = $PSBoundParameters["CurrentPassword"]
        } 
        $currsecur = [System.Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocUnicode($params.CurrentPassword)
        $curr = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($currsecur)
    
        $newsecur = [System.Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocUnicode($params.NewPassword)
        $new = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($newsecur)
    
        $params["Url"]  = "https://graph.microsoft.com/beta/me/changePassword"
        $body = @{
            currentPassword = $curr
            newPassword = $new 
        }
        $body = $body | ConvertTo-Json
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================
")
        
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params.Url -Method POST -Body $body
        $response
    } 
'@
}