# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADTenantDetail"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {
        $params = @{}
        $customHeaders = New-CustomHeaders -Module Entra -Command $MyInvocation.MyCommand

        if($null -ne $PSBoundParameters["MarketingNotificationEmails"])
        {
            $params["MarketingNotificationEmails"] = $PSBoundParameters["MarketingNotificationEmails"]
        }

        if($null -ne $PSBoundParameters["SecurityComplianceNotificationMails"])
        {
            $params["SecurityComplianceNotificationMails"] = $PSBoundParameters["SecurityComplianceNotificationMails"]
        }

        if($null -ne $PSBoundParameters["SecurityComplianceNotificationPhones"])
        {
            $params["SecurityComplianceNotificationPhones"] = $PSBoundParameters["SecurityComplianceNotificationPhones"]
        }

        if($null -ne $PSBoundParameters["TechnicalNotificationMails"])
        {
            $params["TechnicalNotificationMails"] = $PSBoundParameters["TechnicalNotificationMails"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================")
        
        $params["OrganizationId"] = (Get-MgOrganization).Id
        Update-MgOrganization @params
    }
'@
}