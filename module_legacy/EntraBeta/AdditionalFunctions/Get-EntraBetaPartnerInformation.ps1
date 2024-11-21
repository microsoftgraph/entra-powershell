# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraBetaPartnerInformation {
        [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
        param (
            [Parameter(ParameterSetName = "GetById", ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId
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
                "PartnerSupportUrl"        = $response.supportUrl
                "ObjectID"                 = $response.partnerTenantId
            }
            $customTable
        }
    }