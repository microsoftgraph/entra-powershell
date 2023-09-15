function Get-EntraBetaPartnerInformation {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById")][System.String] $TenantId
    )

    PROCESS {    
        $params = @{}
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($null -ne $PSBoundParameters["TenantId"]) {
            $params["TenantID"] = $PSBoundParameters["TenantId"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        if ([string]::IsNullOrWhiteSpace($TenantId)) {
            $TenantID = ((invoke-mggraphrequest -Method GET -Uri "https://graph.microsoft.com/beta/organization").value).id
        }
        $response = invoke-mggraphrequest -Method GET -Uri "https://graph.microsoft.com/beta/organization/$TenantID/partnerInformation"
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