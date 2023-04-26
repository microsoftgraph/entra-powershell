# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADTrustedCertificateAuthority"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        
        `$params["OrganizationId"] = (Get-MgContext).TenantId
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
        if(`$null -ne `$PSBoundParameters["TrustedIssuerSki"])
        {
            `$trustedIssuerSki = `$PSBoundParameters["TrustedIssuerSki"]
        }
        if(`$null -ne `$PSBoundParameters["TrustedIssuer"])
        {
            `$trustedIssuer = `$PSBoundParameters["TrustedIssuer"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================``n")
        
        `$responseData = Get-MgOrganizationCertificateBasedAuthConfiguration @params
        `$response = `$responseData.CertificateAuthorities
        `$getType = {            
            if(`$this.IsRootAuthority){
                "RootAuthority"
            }
            else
            {
                "IntermediateAuthority"
            }            
        }
        `$response | ForEach-Object {
            Add-Member -InputObject `$_ -MemberType ScriptProperty -Name AuthorityType -Value `$getType
            Add-Member -InputObject `$_ -MemberType AliasProperty -Name TrustedCertificate -Value Certificate
            Add-Member -InputObject `$_ -MemberType AliasProperty -Name CrlDistributionPoint -Value CertificateRevocationListUrl
            Add-Member -InputObject `$_ -MemberType AliasProperty -Name DeltaCrlDistributionPoint -Value DeltaCertificateRevocationListUrl
            Add-Member -InputObject `$_ -MemberType AliasProperty -Name TrustedIssuer -Value Issuer
            Add-Member -InputObject `$_ -MemberType AliasProperty -Name TrustedIssuerSki -Value IssuerSki
        }
        `$response
        }
"@
}