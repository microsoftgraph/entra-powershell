# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraInvitation {
    [CmdletBinding(DefaultParameterSetName = 'ByEmailAndRedirectUrl')]
    param (                
        [Parameter(ParameterSetName = "ByEmailAndRedirectUrl", Mandatory = $true)]
        [System.String] $InvitedUserEmailAddress,
                
        [Parameter(ParameterSetName = "ByEmailAndRedirectUrl")]
        [System.String] $InvitedUserDisplayName,
                
        [Parameter(ParameterSetName = "ByEmailAndRedirectUrl", Mandatory = $true)]
        [System.String] $InviteRedirectUrl,
                
        [Parameter(ParameterSetName = "ByEmailAndRedirectUrl")]
        [Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo] $InvitedUserMessageInfo,
                
        [Parameter(ParameterSetName = "ByEmailAndRedirectUrl")]
        [Microsoft.Open.MSGraph.Model.User] $InvitedUser,
                
        [Parameter(ParameterSetName = "ByEmailAndRedirectUrl")]
        [System.Nullable`1[System.Boolean]] $SendInvitationMessage,
                
        [Parameter(ParameterSetName = "ByEmailAndRedirectUrl")]
        [System.String] $InvitedUserType,

        [Parameter(ParameterSetName = "ByEmailAndRedirectUrl")]
        [switch] $ResetRedemption
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.Invite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand        
        if ($null -ne $PSBoundParameters["InvitedUser"]) {
            $TmpValue = $PSBoundParameters["InvitedUser"]
            $Temp = @{}
            foreach ($property in $TmpValue.PSObject.Properties) {
                $Temp[$property.Name] = $property.Value
            }
            $params["InvitedUser"] = $Temp
        }
        if ($null -ne $PSBoundParameters["InvitedUserMessageInfo"]) {
            $TmpValue = $PSBoundParameters["InvitedUserMessageInfo"]
            $Temp = @{}
            $Temp["CustomizedMessageBody"] = $TmpValue.CustomizedMessageBody
            $Temp["MessageLanguage"] = $TmpValue.MessageLanguage
            $Temp["CcRecipients"] = $TmpValue.CcRecipients
            $Value = $Temp
            $params["InvitedUserMessageInfo"] = $Value
        }
        if ($null -ne $PSBoundParameters["InvitedUserType"]) {
            $params["InvitedUserType"] = $PSBoundParameters["InvitedUserType"]
        }
        if ($null -ne $PSBoundParameters["SendInvitationMessage"]) {
            $params["SendInvitationMessage"] = $PSBoundParameters["SendInvitationMessage"]
        }
        if ($null -ne $PSBoundParameters["InvitedUserEmailAddress"]) {
            $params["InvitedUserEmailAddress"] = $PSBoundParameters["InvitedUserEmailAddress"]
        }
        if ($null -ne $PSBoundParameters["InvitedUserDisplayName"]) {
            $params["InvitedUserDisplayName"] = $PSBoundParameters["InvitedUserDisplayName"]
        }
        if ($null -ne $PSBoundParameters["InviteRedirectUrl"]) {
            $params["InviteRedirectUrl"] = $PSBoundParameters["InviteRedirectUrl"]
        }
        if ($PSBoundParameters["ResetRedemption"]) {
            $params["ResetRedemption"] = $PSBoundParameters["ResetRedemption"]
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = New-MgInvitation @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $response
    }    
}

