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
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{}
        if($null -ne $PSBoundParameters["InvitedUser"])
        {
            $TmpValue = $PSBoundParameters["InvitedUser"]
            $Temp = @{}
            foreach ($property in $TmpValue.PSObject.Properties) {
                $Temp[$property.Name] = $property.Value
            }
            $params["InvitedUser"] = $Temp
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
        if($null -ne $PSBoundParameters["SendInvitationMessage"])
        {
            $params["SendInvitationMessage"] = $PSBoundParameters["SendInvitationMessage"]
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
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = New-MgInvitation @params -Headers $customHeaders
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $response
    }
'@
}