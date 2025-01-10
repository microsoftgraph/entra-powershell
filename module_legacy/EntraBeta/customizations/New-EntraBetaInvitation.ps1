# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADMSInvitation"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
       
        if($null -ne $PSBoundParameters["InvitedUser"])
        {
            $TmpValue = $PSBoundParameters["InvitedUser"]
            $Temp = @{}
            foreach ($property in $TmpValue.PSObject.Properties) {
                $Temp[$property.Name] = $property.Value
            }
            $params["InvitedUser"] = $Temp
        }
        if($null -ne $PSBoundParameters["ResetRedemption"])
        {
            $params["ResetRedemption"] = $PSBoundParameters["ResetRedemption"]
        }
        if($null -ne $PSBoundParameters["InvitedUserMessageInfo"])
        {
            $TmpValue = $PSBoundParameters["InvitedUserMessageInfo"]
            $Temp = @{}
            $Temp["CustomizedMessageBody"] = $TmpValue.CustomizedMessageBody
            $Temp["MessageLanguage"] = $TmpValue.MessageLanguage
            $Temp["CcRecipients"] = $TmpValue.CcRecipients
            $Value = $Temp
            $params["InvitedUserMessageInfo"] = $Value
        }
        if($null -ne $PSBoundParameters["InvitedUserType"])
        {
            $params["InvitedUserType"] = $PSBoundParameters["InvitedUserType"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if($null -ne $PSBoundParameters["SendInvitationMessage"])
        {
            $params["SendInvitationMessage"] = $PSBoundParameters["SendInvitationMessage"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if($null -ne $PSBoundParameters["InvitedUserEmailAddress"])
        {
            $params["InvitedUserEmailAddress"] = $PSBoundParameters["InvitedUserEmailAddress"]
        }
        if($null -ne $PSBoundParameters["InvitedUserDisplayName"])
        {
            $params["InvitedUserDisplayName"] = $PSBoundParameters["InvitedUserDisplayName"]
        }
        if($null -ne $PSBoundParameters["InviteRedirectUrl"])
        {
            $params["InviteRedirectUrl"] = $PSBoundParameters["InviteRedirectUrl"]
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
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = New-MgBetaInvitation @params -Headers $customHeaders
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
    
            }
        }
        $response
    }
'@
}