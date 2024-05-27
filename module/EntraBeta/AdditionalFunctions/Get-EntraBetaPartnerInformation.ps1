# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraBetaPartnerInformation {
    <#
    .SYNOPSIS
    Retrieves company-level information for partners.
    
    .DESCRIPTION
    The Get-EntraBetaPartnerInformation cmdlet is used to retrieve partner-specific information. This cmdlet should only be used for partner tenants.
    
    .PARAMETER TenantId
        The unique ID of the tenant to perform the operation on. If this is not provided, then the value will default to the tenant of the current user. This parameter is only applicable to partner users.
    
    .PARAMETER <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).
    
    
    .OUTPUTS
    The cmdlet will return the following company level information:
    - CompanyType: The type of this company (can be partner or regular tenant)
    - DapEnabled: Flag to determine if the partner has delegated admin privileges.
    - PartnerCompanyName: The name of the company
    - PartnerSupportTelephones: Support Telephone numbers for the partner.
    - PartnerSupportEmails: Support E-Mail address for the partner.
    - PartnerCommerceUrl: URL for the partner's commerce web site.
    - PartnerSupportUrl: URL for the Partner's support website.
    - PartnerHelpUrl: URL for the partner's help web site.
        
    #>
        [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
        param (
            [Parameter(ParameterSetName = "GetById", ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId
        )
    
        PROCESS {    
            $params = @{}
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
            if ($PSBoundParameters.ContainsKey("Verbose")) {
                $params["Verbose"] = $Null
            }
            if ($null -ne $PSBoundParameters["TenantId"]) {
                $params["TenantID"] = $PSBoundParameters["TenantId"]
            }
            if ($PSBoundParameters.ContainsKey("Debug")) {
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
    
            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")
            if ([string]::IsNullOrWhiteSpace($TenantId)) {
                $TenantID = ((invoke-mggraphrequest -Method GET -Uri "https://graph.microsoft.com/beta/organization").value).id
            }
            $response = invoke-mggraphrequest -Headers $customHeaders -Method GET -Uri "https://graph.microsoft.com/beta/organization/$TenantID/partnerInformation"
            # Create a custom table
            $customTable = [PSCustomObject]@{
                "PartnerCompanyName"       = $response.companyName
                "companyType"              = $response.companyType
                "PartnerSupportTelephones" = $response.supportTelephones
                "PartnerSupportEmails"     = $response.supportEmails
                "PartnerHelpUrl"           = $response.helpUrl
                "PartnerCommerceUrl"       = $response.commerceUrl
                "ObjectID"                 = $response.partnerTenantId
            }
            $customTable 
        }
    }