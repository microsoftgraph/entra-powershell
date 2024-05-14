BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    
    $tenantObj = {
        return @(
            [PSCustomObject]@{
                TenantId = "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            }
        )

    }

    Mock -CommandName Get-MgContext -MockWith $tenantObj -ModuleName Microsoft.Graph.Entra
    
    $scriptblock = {
        return @(
            @{
                Id                         = '29728ade-6ae4-4ee9-9103-412912537da5'
                "@odata.context" = $args
                certificateAuthorities = @{ 
                    IsRootAuthority              = "RootAuthority"
                    CertificateRevocationListUrl       = "https://example.crl"
                    DeltaCertificateRevocationListUrl = "https://example2.crl"
                    Certificate        = @(70, 57, 66, 65, 57, 49, 69, 55, 54, 68, 57, 51, 49, 48, 51, 49, 55, 49, 55, 49, 50, 54, 69, 55, 68, 52, 70, 56, 70, 54, 57, 70, 55, 52, 51, 52, 57, 56, 53, 51)
                    Issuer             = "CN=ms-cmdlett"
                    IssuerSki          = "E48DBC5D4AF447E9D9D4A5440D4096C70AF5352A" 
                }
                Parameters                 = $args
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra

    $scriptblock2 = {
        return @(
            [PSCustomObject]@{
                CertificateAuthorities = @{ 
                IsRootAuthority              = "RootAuthority"
                CertificateRevocationListUrl       = "https://example.crl"
                DeltaCertificateRevocationListUrl = "https://example2.crl"
                Certificate        = @(70, 57, 66, 65, 57, 49, 69, 55, 54, 68, 57, 51, 49, 48, 51, 49, 55, 49, 55, 49, 50, 54, 69, 55, 68, 52, 70, 56, 70, 54, 57, 70, 55, 52, 51, 52, 57, 56, 53, 51)
                Issuer             = "CN=ms-cmdlett"
                IssuerSki          = "E48DBC5D4AF447E9D9D4A5440D4096C70AF5352A"
            }
            }
        )

    }

    Mock -CommandName Get-MgOrganizationCertificateBasedAuthConfiguration -MockWith $scriptblock2 -ModuleName Microsoft.Graph.Entra

}
  
Describe "Set-EntraTrustedCertificateAuthority" {
    Context "Test for Set-EntraTrustedCertificateAuthority" {
        It "Should return created one" {
            $cer = Get-EntraTrustedCertificateAuthority 
            $cer[0].CrlDistributionPoint = "https://example.crl"
            $cer[0].DeltaCrlDistributionPoint = "https://example2.crl"
            $cer[0].TrustedIssuer = "CN=ms-cmdlett"
            $cer[0].TrustedIssuerSki = "E48DBC5D4AF447E9D9D4A5440D4096C70AF5352A"

            $result = Set-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $cer

            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "29728ade-6ae4-4ee9-9103-412912537da5"
            $result.certificateAuthorities.TrustedIssuer| Should -Be "CN=ms-cmdlett"
            $result.certificateAuthorities.CrlDistributionPoint| Should -Be "https://example.crl"
            $result.certificateAuthorities.AuthorityType| Should -Be "RootAuthority"
            $result.certificateAuthorities.TrustedIssuerSki| Should -Be "E48DBC5D4AF447E9D9D4A5440D4096C70AF5352A"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when parameters are empty" {
            { Set-EntraTrustedCertificateAuthority -CertificateAuthorityInformation  } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when parameters are Invalid values" {
            { Set-EntraTrustedCertificateAuthority -CertificateAuthorityInformation ""  } | Should -Throw "Cannot process argument transformation on parameter 'CertificateAuthorityInformation'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraTrustedCertificateAuthority"

            $cer = Get-EntraTrustedCertificateAuthority 
            $cer[0].CrlDistributionPoint = "https://example.crl"
            $cer[0].DeltaCrlDistributionPoint = "https://example2.crl"
            $cer[0].TrustedIssuer = "CN=ms-cmdlett"
            $cer[0].TrustedIssuerSki = "E48DBC5D4AF447E9D9D4A5440D4096C70AF5352A"

            $result = Set-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $cer

            $params = Get-Parameters -data $result."@odata.context"

            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   

        It "Should contain 'TenantId' " {
            $cer = Get-EntraTrustedCertificateAuthority 
            $cer[0].CrlDistributionPoint = "https://example.crl"
            $cer[0].DeltaCrlDistributionPoint = "https://example2.crl"
            $cer[0].TrustedIssuer = "CN=ms-cmdlett"
            $cer[0].TrustedIssuerSki = "E48DBC5D4AF447E9D9D4A5440D4096C70AF5352A"

            $result = Set-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $cer

            $params = Get-Parameters -data $result."@odata.context"

            $params.uri | Should -Match "d5aec55f-2d12-4442-8d2f-ccca95d4390e" 
        }   

    }
}