# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaPartnerInformation {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", ValueFromPipelineByPropertyName = $true)]
        [Obsolete("This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID. It should not be used for any other purpose.")]
        [System.Guid] $TenantId
    )

    PROCESS {
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["TenantId"]) {
            $params["TenantID"] = $PSBoundParameters["TenantId"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        if ([string]::IsNullOrWhiteSpace($TenantId)) {
            $TenantID = (Get-EntraContext).TenantId
        }
        $response = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri "/beta/organization/$TenantID/partnerInformation"
        # Create a custom table
        $customTable = [PSCustomObject]@{
            "PartnerCompanyName"       = $response.companyName
            "companyType"              = $response.companyType
            "PartnerSupportTelephones" = $response.supportTelephones
            "PartnerSupportEmails"     = $response.supportEmails
            "PartnerHelpUrl"           = $response.helpUrl
            "PartnerCommerceUrl"       = $response.commerceUrl
            "PartnerSupportUrl"        = $response.supportUrl
            "ObjectID"                 = $response.partnerTenantId
        }
        $customTable
    }
}
