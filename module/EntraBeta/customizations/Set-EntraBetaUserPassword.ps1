# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADUserPassword"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $keysChanged = @{ObjectId = "Id"}
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $userId = $PSBoundParameters["ObjectId"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["Password"])
        {
            $Temp = $PSBoundParameters["Password"]
            $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Temp)
            $PlainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
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
        if($null -ne $PSBoundParameters["ForceChangePasswordNextLogin"])
        {
            $ForceChangePasswordNextSignIn = $PSBoundParameters["ForceChangePasswordNextLogin"]
        }
        if($null -ne $PSBoundParameters["EnforceChangePasswordPolicy"])
        {
            $EnforceChangePasswordPolicy = $PSBoundParameters["EnforceChangePasswordPolicy"]
        }

        $PasswordProfile = @{}
        if($null -ne $PSBoundParameters["ForceChangePasswordNextLogin"]) { $PasswordProfile["ForceChangePasswordNextSignIn"] = $ForceChangePasswordNextSignIn }
        if($null -ne $PSBoundParameters["EnforceChangePasswordPolicy"]) { $PasswordProfile["ForceChangePasswordNextSignInWithMfa"] = $ForceChangePasswordNextSignInWithMfa }
        if($null -ne $PSBoundParameters["Password"]) { $PasswordProfile["password"] = $PlainPassword }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Update-MgBetaUser -UserId $userId -PasswordProfile $PasswordProfile @params
        $response
    } 
'@
}