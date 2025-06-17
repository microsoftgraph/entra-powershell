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
        [Obsolete("This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID. It should not be used for any other purpose.")]
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

            $TenantID = (Get-EntraContext).TenantId
        }
        Invoke-MgGraphRequest -Headers $customHeaders -Method PATCH -Uri "/v1.0/organization/$TenantID/partnerInformation" -Body $body
    }
}

