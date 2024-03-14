# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSGroup"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {
        $params = @{}
        $keysChanged = @{}

        if($null -ne $PSBoundParameters["Description"])
        {
            $params["Description"] = $PSBoundParameters["Description"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["DisplayName"])
        {
            $params["DisplayName"] = $PSBoundParameters["DisplayName"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["MembershipRuleProcessingState"])
        {
            $params["MembershipRuleProcessingState"] = $PSBoundParameters["MembershipRuleProcessingState"]
        }
        if($null -ne $PSBoundParameters["Id"])
        {
            $params["GroupId"] = $PSBoundParameters["Id"]
        }
        if($null -ne $PSBoundParameters["GroupTypes"])
        {
            $params["GroupTypes"] = $PSBoundParameters["GroupTypes"]
        }
        if($null -ne $PSBoundParameters["SecurityEnabled"])
        {
            $params["SecurityEnabled"] = $PSBoundParameters["SecurityEnabled"]
        }
        if($null -ne $PSBoundParameters["Visibility"])
        {
            $params["Visibility"] = $PSBoundParameters["Visibility"]
        }
        if($null -ne $PSBoundParameters["MailEnabled"])
        {
            $params["MailEnabled"] = $PSBoundParameters["MailEnabled"]
        }
        if($null -ne $PSBoundParameters["MailNickName"])
        {
            $params["MailNickName"] = $PSBoundParameters["MailNickName"]
        }
        if($null -ne $PSBoundParameters["MembershipRule"])
        {
            $params["MembershipRule"] = $PSBoundParameters["MembershipRule"]
        }
        if($null -ne $PSBoundParameters["IsAssignableToRole"])
        {
            $params["IsAssignableToRole"] = $PSBoundParameters["IsAssignableToRole"]
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")
        $response = Update-MgBetaGroup @params
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }

        $response
    }
'@
}


