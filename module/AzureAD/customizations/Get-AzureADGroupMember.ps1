# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADGroupMember"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'
    PROCESS {    
        $params = @{}
        $keysChanged = @{ObjectId = "Id"}
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["GroupId"] = $PSBoundParameters["ObjectId"]
        }
        if($null -ne $PSBoundParameters["All"])
        {
            if($PSBoundParameters["All"])
            {
                $params["All"] = $Null
            }
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $Null
        }
        if($null -ne $PSBoundParameters["Top"])
        {
            $params["Top"] = $PSBoundParameters["Top"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Get-MgGroupMember @params | Select-Object -Property Id, DeletedDateTime,
        @{
            Name = 'accountEnabled'
            Expression = {$_.AdditionalProperties.accountEnabled}
        },
        @{
            Name = 'assignedLicenses'
            Expression = {$_.AdditionalProperties.assignedLicenses}
        },
        @{
            Name = 'assignedPlans'
            Expression = {$_.AdditionalProperties.assignedPlans}
        },
        @{
            Name = 'country'
            Expression = {$_.AdditionalProperties.country}
        },
        @{
            Name = 'displayName'
            Expression = {$_.AdditionalProperties.displayName}
        },
        @{
            Name = 'givenName'
            Expression = {$_.AdditionalProperties.givenName}
        },
        @{
            Name = 'mail'
            Expression = {$_.AdditionalProperties.mail}
        },
        @{
            Name = 'mailNickname'
            Expression = {$_.AdditionalProperties.mailNickname}
        },
        @{
            Name = 'mobilePhone'
            Expression = {$_.AdditionalProperties.mobilePhone}
        },
        @{
            Name = 'otherMails'
            Expression = {$_.AdditionalProperties.otherMails}
        },
        @{
            Name = 'preferredLanguage'
            Expression = {$_.AdditionalProperties.preferredLanguage}
        },
        @{
            Name = 'provisionedPlans'
            Expression = {$_.AdditionalProperties.provisionedPlans}
        },
        @{
            Name = 'onPremisesProvisioningErrors'
            Expression = {$_.AdditionalProperties.onPremisesProvisioningErrors}
        },
        @{
            Name = 'proxyAddresses'
            Expression = {$_.AdditionalProperties.proxyAddresses}
        },
        @{
            Name = 'refreshTokensValidFromDateTime'
            Expression = {$_.AdditionalProperties.refreshTokensValidFromDateTime}
        },
        @{
            Name = 'surname'
            Expression = {$_.AdditionalProperties.surname}
        },
        @{
            Name = 'businessPhones'
            Expression = {$_.AdditionalProperties.businessPhones}
        },
        @{
            Name = 'userType'
            Expression = {$_.AdditionalProperties.userType}
        },
        @{
            Name = 'userPrincipalName'
            Expression = {$_.AdditionalProperties.userPrincipalName}
        }
    
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        $response
        }
'@
}