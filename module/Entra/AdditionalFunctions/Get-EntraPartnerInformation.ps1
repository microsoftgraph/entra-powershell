# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraPartnerInformation {    
        [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
        param (
            [Parameter(ParameterSetName = "GetById", ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId
        )
    
        PROCESS {    
            $params = @{}
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
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
                $TenantID = ((invoke-mggraphrequest -Method GET -Uri "https://graph.microsoft.com/v1.0/organization").value).id
            }
            $response = invoke-mggraphrequest -Headers $customHeaders -Method GET -Uri "https://graph.microsoft.com/v1.0/organization/$TenantID/partnerInformation"
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