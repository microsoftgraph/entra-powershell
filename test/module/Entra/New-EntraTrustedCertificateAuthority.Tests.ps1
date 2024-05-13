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
                    DeltaCertificateRevocationListUrl = ""
                    Certificate        = @(70, 57, 66, 65, 57, 49, 69, 55, 54, 68, 57, 51, 49, 48, 51, 49, 55, 49, 55, 49, 50, 54, 69, 55, 68, 52, 70, 56, 70, 54, 57, 70, 55, 52, 51, 52, 57, 56, 53, 51)
                    Issuer             = "CN=mscmdlet"
                    IssuerSki          = "23C98A95721291E474455243BDDB5651FE7BCDE8" 
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
                DeltaCertificateRevocationListUrl = ""
                Certificate        = @(70, 57, 66, 65, 57, 49, 69, 55, 54, 68, 57, 51, 49, 48, 51, 49, 55, 49, 55, 49, 50, 54, 69, 55, 68, 52, 70, 56, 70, 54, 57, 70, 55, 52, 51, 52, 57, 56, 53, 51)
                Issuer             = "CN=mscmdlet"
                IssuerSki          = "23C98A95721291E474455243BDDB5651FE7BCDE8"
            }
            }
        )

    }

    Mock -CommandName Get-MgOrganizationCertificateBasedAuthConfiguration -MockWith $scriptblock2 -ModuleName Microsoft.Graph.Entra

}
  
Describe "New-EntraTrustedCertificateAuthority" {
    Context "Test for New-EntraTrustedCertificateAuthority" {
        It "Should return created one" {
            $byteData = @(70, 57, 66, 65, 57, 49, 69, 55, 54, 68, 57, 51, 49, 48, 51, 49, 55, 49, 55, 49, 50, 54, 69, 55, 68, 52, 70, 56, 70, 54, 57, 70, 55, 52, 51, 52, 57, 56, 53, 51)
            $new_ca=New-Object -TypeName Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation
            $new_ca.AuthorityType=0
            $new_ca.TrustedCertificate= $byteData
            $new_ca.crlDistributionPoint="https://example.crl"
            $new_ca.DeltaCrlDistributionPoint="https://test.crl"

            $result = New-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $new_ca

            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "29728ade-6ae4-4ee9-9103-412912537da5"
            $result.certificateAuthorities.TrustedIssuer| Should -Be "CN=mscmdlet"
            $result.certificateAuthorities.CrlDistributionPoint| Should -Be "https://example.crl"
            $result.certificateAuthorities.AuthorityType| Should -Be "RootAuthority"
            $result.certificateAuthorities.TrustedIssuerSki| Should -Be "23C98A95721291E474455243BDDB5651FE7BCDE8"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when parameters are empty" {
            { New-EntraTrustedCertificateAuthority -CertificateAuthorityInformation  } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when parameters are Invalid values" {
            { New-EntraTrustedCertificateAuthority -CertificateAuthorityInformation ""  } | Should -Throw "Cannot process argument transformation on parameter 'CertificateAuthorityInformation'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraTrustedCertificateAuthority"

            $byteData = @(70, 57, 66, 65, 57, 49, 69, 55, 54, 68, 57, 51, 49, 48, 51, 49, 55, 49, 55, 49, 50, 54, 69, 55, 68, 52, 70, 56, 70, 54, 57, 70, 55, 52, 51, 52, 57, 56, 53, 51)
            $new_ca=New-Object -TypeName Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation
            $new_ca.AuthorityType=0
            $new_ca.TrustedCertificate= $byteData
            $new_ca.crlDistributionPoint="https://example.crl"
            $new_ca.DeltaCrlDistributionPoint="https://test.crl"

            $result = New-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $new_ca

            $params = Get-Parameters -data $result."@odata.context"

            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   

        It "Should contain 'TenantId' " {
            $byteData = @(70, 57, 66, 65, 57, 49, 69, 55, 54, 68, 57, 51, 49, 48, 51, 49, 55, 49, 55, 49, 50, 54, 69, 55, 68, 52, 70, 56, 70, 54, 57, 70, 55, 52, 51, 52, 57, 56, 53, 51)
            $new_ca=New-Object -TypeName Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation
            $new_ca.AuthorityType=0
            $new_ca.TrustedCertificate= $byteData
            $new_ca.crlDistributionPoint="https://example.crl"
            $new_ca.DeltaCrlDistributionPoint="https://test.crl"

            $result = New-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $new_ca

            $params = Get-Parameters -data $result."@odata.context"

            $params.uri | Should -Match "d5aec55f-2d12-4442-8d2f-ccca95d4390e" 
        }   

    }
}