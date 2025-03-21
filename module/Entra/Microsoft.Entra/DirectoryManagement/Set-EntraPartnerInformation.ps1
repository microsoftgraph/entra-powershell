# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraPartnerInformation {    
    [CmdletBinding(DefaultParameterSetName = 'SetPartnerInformation')]
    param (
        [Parameter(ParameterSetName = 'SetPartnerInformation', ValueFromPipelineByPropertyName = $true)]
        [string] $CompanyType,
        [Parameter(ParameterSetName = 'SetPartnerInformation', ValueFromPipelineByPropertyName = $true)]
        [string] $PartnerCommerceUrl,
        [Parameter(ParameterSetName = 'SetPartnerInformation', ValueFromPipelineByPropertyName = $true)]
        [string] $PartnerCompanyName,
        [Parameter(ParameterSetName = 'SetPartnerInformation', ValueFromPipelineByPropertyName = $true)]
        [string] $PartnerHelpUrl,
        [Parameter(ParameterSetName = 'SetPartnerInformation', ValueFromPipelineByPropertyName = $true)]
        [string[]] $PartnerSupportEmails,
        [Parameter(ParameterSetName = 'SetPartnerInformation', ValueFromPipelineByPropertyName = $true)]
        [string[]] $PartnerSupportTelephones,
        [Parameter(ParameterSetName = 'SetPartnerInformation', ValueFromPipelineByPropertyName = $true)]
        [string] $PartnerSupportUrl,
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [System.Guid] $TenantId
    )


    PROCESS {    
        $params = @{}
        $body = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand        
        if ($null -ne $PSBoundParameters["TenantId"]) {
            $body["partnerTenantId"] = $PSBoundParameters["TenantId"]
        }
        if ($null -ne $PSBoundParameters["CompanyType"]) {
            $body["companyType"] = $PSBoundParameters["CompanyType"]
        }
        if ($null -ne $PSBoundParameters["PartnerCommerceUrl"]) {
            $body["commerceUrl"] = $PSBoundParameters["PartnerCommerceUrl"]
        }
        if ($null -ne $PSBoundParameters["PartnerCompanyName"]) {
            $body["companyName"] = $PSBoundParameters["PartnerCompanyName"]
        }
        if ($null -ne $PSBoundParameters["PartnerHelpUrl"]) {
            $body["helpUrl"] = $PSBoundParameters["PartnerHelpUrl"]
        }
        if ($null -ne $PSBoundParameters["PartnerSupportEmails"]) {
            $body["supportEmails"] = @($PSBoundParameters["PartnerSupportEmails"])
        }
        if ($null -ne $PSBoundParameters["PartnerSupportTelephones"]) {
            $body["supportTelephones"] = @($PSBoundParameters["PartnerSupportTelephones"] -as [string[]])
        }        
        if ($null -ne $PSBoundParameters["PartnerSupportUrl"]) {
            $body["supportUrl"] = $PSBoundParameters["PartnerSupportUrl"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        if ([string]::IsNullOrWhiteSpace($TenantId)) {
            $TenantID = ((Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/organization").value).Id
        }
        Invoke-MgGraphRequest -Headers $customHeaders -Method PATCH -Uri "https://graph.microsoft.com/v1.0/organization/$TenantID/partnerInformation" -Body $body
    }
}

