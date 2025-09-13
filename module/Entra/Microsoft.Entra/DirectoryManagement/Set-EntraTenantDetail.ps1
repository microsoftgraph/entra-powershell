# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraTenantDetail {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
                
    [Parameter(ParameterSetName = "Default")]
    [System.Collections.Generic.List`1[System.String]] $TechnicalNotificationMails,
                
    [Parameter(ParameterSetName = "Default")]
    [System.Collections.Generic.List`1[System.String]] $MarketingNotificationEmails,
                
    [Parameter(ParameterSetName = "Default")]
    [System.Collections.Generic.List`1[System.String]] $SecurityComplianceNotificationMails,
                
    [Parameter(ParameterSetName = "Default")]
    [System.Collections.Generic.List`1[System.String]] $SecurityComplianceNotificationPhones,
                
    [Parameter(ParameterSetName = "Default")]
    [Microsoft.Open.AzureAD.Model.PrivacyProfile] $PrivacyProfile
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Organization.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand

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
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $PSBoundParameters["Debug"]
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
        Write-Debug("=========================================================================")
        
        $params["OrganizationId"] = (Get-MgOrganization).Id
        Update-MgOrganization @params -Headers $customHeaders
    }    
}

