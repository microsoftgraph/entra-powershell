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
                "Parameters" = $args
            }
        )
    }    
    Mock -CommandName Get-MgDomainFederationConfiguration -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra

    Mock -CommandName Update-MgDomainFederationConfiguration -MockWith {} -ModuleName Microsoft.Graph.Entra
}
Describe "Set-EntraDomainFederationSettings" {
    Context "Test for Set-EntraDomainFederationSettings" {
        It "Should Updates settings for a federated domain." {
            $result =  Set-EntraDomainFederationSettings -DomainName "manan.lab.myworkspace.microsoft.com" -LogOffUri "https://adfs1.manan.lab/adfs/" -PassiveLogOnUri "https://adfs1.manan.lab/adfs/" -ActiveLogOnUri "https://adfs1.manan.lab/adfs/services/trust/2005/" -IssuerUri "http://adfs1.manan.lab/adfs/services/" -FederationBrandName "ADFS" -MetadataExchangeUri "https://adfs1.manan.lab/adfs/services/trust/" -PreferredAuthenticationProtocol "saml" -PromptLoginBehavior "nativeSupport"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Update-MgDomainFederationConfiguration -ModuleName Microsoft.Graph.Entra -Times 1
        }
        
        It "Should fail when DomainName is empty" {
             {Set-EntraDomainFederationSettings -DomainName} | Should -Throw "Missing an argument for parameter 'DomainName'. Specify a parameter*"
        }

        It "Should fail when DomainName is invalid" {
             {Set-EntraDomainFederationSettings -DomainName ""} | Should -Throw "Cannot bind argument to parameter 'DomainName' because it is an empty string.*"
        } 

        It "Should fail when parameter is empty" {
            {Set-EntraDomainFederationSettings -DomainName "manan.lab.myworkspace.microsoft.com" -LogOffUri  -PassiveLogOnUri  -ActiveLogOnUri -IssuerUri  -FederationBrandName  -MetadataExchangeUri  -PreferredAuthenticationProtocol  -PromptLoginBehavior } | Should -Throw "Missing an argument for parameter*"
        }
        It "Should fail when invalid paramter is passed"{
            {Set-EntraDomainFederationSettings -Demo } | Should -Throw "A parameter cannot be found that matches parameter name 'Demo'*"
        }   
        It "Should contain DomainId in parameters when DomainName to it" {
            Mock -CommandName Update-MgDomainFederationConfiguration -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            $result = Set-EntraDomainFederationSettings -DomainName "manan.lab.myworkspace.microsoft.com"
            $params = Get-Parameters -data $result
            $a= $params | ConvertTo-json | ConvertFrom-Json
            $a.DomainId | Should -Be "manan.lab.myworkspace.microsoft.com"         
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgDomainFederationConfiguration -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDomainFederationSettings"

            $result = Set-EntraDomainFederationSettings -DomainName "manan.lab.myworkspace.microsoft.com"
            $params = Get-Parameters -data $result
            $a= $params | ConvertTo-json | ConvertFrom-Json
            $a.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }   

    }
} 