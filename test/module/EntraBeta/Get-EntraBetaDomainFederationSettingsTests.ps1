BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta     
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "ActiveSignInUri"                       = "https://sts.deverett.info/adfs/services/trust/2005/usernamemixed"
                "DisplayName"                           = "Contoso" 
                "FederatedIdpMfaBehavior"               = "rejectMfaByFederatedIdp" 
                "Id"                                    = "2a8ce608-bb34-473f-9e0f-f373ee4cbc5a" 
                "IsSignedAuthenticationRequestRequired" = ""
                "IssuerUri"                             = "http://contoso.com/adfs/services/trust/"
                "MetadataExchangeUri"                   = "https://sts.contoso.com/adfs/services/trust/mex" 
                "NextSigningCertificate"                = "MIIC3jCCAcagAwIBAgIQEt0T0G5GPZ9"
                "PassiveSignInUri"                      = "https://sts.contoso.com/adfs/ls/" 
                "PreferredAuthenticationProtocol"       = "wsFed" 
                "PromptLoginBehavior"                   =  ""
                "SignOutUri"                            = "https://sts.deverett.info/adfs/ls/" 
                "SigningCertificate"                    = "MIIC3jCCAcagAwIBAgIQFsO0R8deG4h" 
                "SigningCertificateUpdateStatus"        = @{
                    "CertificateUpdateResult" = "success";
                } 
            }
        )
    }    
    Mock -CommandName Get-MgBetaDomainFederationConfiguration -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaDomainFederationSettings" {
    Context "Test for Get-EntraBetaDomainFederationSettings" {
        It "Should return federation settings" {
            $result = Get-EntraBetaDomainFederationSettings -DomainName "test.com"
            $result | Should -Not -BeNullOrEmpty
            $result.FederationBrandName | Should -Be "Contoso"
            $result.ActiveLogOnUri | Should -Be "https://sts.deverett.info/adfs/services/trust/2005/usernamemixed"
            Should -Invoke -CommandName Get-MgBetaDomainFederationConfiguration -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when TenantId is empty" {
            { Get-EntraBetaDomainFederationSettings -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is invalid" {
            { Get-EntraBetaDomainFederationSettings -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
        }
        It "Should fail when DomainName is empty" {
            { Get-EntraBetaDomainFederationSettings -DomainName } | Should -Throw "Missing an argument for parameter 'DomainName'*"
        }
        It "Should fail when DomainName is inavlid" {
            { Get-EntraBetaDomainFederationSettings -DomainName "" } | Should -Throw "Cannot bind argument to parameter 'DomainName'*"
        }
        
    }
}