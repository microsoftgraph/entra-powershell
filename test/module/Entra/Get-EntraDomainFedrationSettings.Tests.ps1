BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
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
    Mock -CommandName Get-MgDomainFederationConfiguration -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraDomainFedrationSettings" {
    Context "Test for Get-EntraDomainFedrationSettings" {
        It "Should return federation settings" {
            $result = Get-EntraDomainFedrationSettings -DomainName "test.com"
            $result | Should -Not -BeNullOrEmpty
            $result.FederationBrandName | Should -Be "Contoso"
            $result.ActiveLogOnUri | Should -Be "https://sts.deverett.info/adfs/services/trust/2005/usernamemixed"
            Should -Invoke -CommandName Get-MgDomainFederationConfiguration -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when TenantId is null" {
            { Get-EntraDomainFedrationSettings -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is empty" {
            { Get-EntraDomainFedrationSettings -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
        }
        It "Should fail when DomainName is null" {
            { Get-EntraDomainFedrationSettings -DomainName } | Should -Throw "Missing an argument for parameter 'DomainName'*"
        }
        It "Should fail when DomainName is empty" {
            { Get-EntraDomainFedrationSettings -DomainName "" } | Should -Throw "Cannot bind argument to parameter 'DomainName'*"
        }
        It "Should fail when invalid paramter is passed"{
            { Get-EntraDomainFedrationSettings -Demo } | Should -Throw "A parameter cannot be found that matches parameter name 'Demo'*"
        }
    }
}