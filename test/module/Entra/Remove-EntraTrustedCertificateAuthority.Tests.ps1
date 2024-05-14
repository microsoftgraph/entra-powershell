BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                Id                         = '29728ade-6ae4-4ee9-9103-412912537da5'
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
                Certificate        = @(48, 130, 3, 0)
                Issuer             = "CN=mscmdlet"
                IssuerSki          = "23C98A95721291E474455243BDDB5651FE7BCDE8"
            }
               
            }
        )

    }

    Mock -CommandName Get-MgOrganizationCertificateBasedAuthConfiguration -MockWith $scriptblock2 -ModuleName Microsoft.Graph.Entra

    $scriptblock3 = {
        return @(
            [PSCustomObject]@{
                TenantId = "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
            }
        )

    }

    Mock -CommandName Get-MgContext -MockWith $scriptblock3 -ModuleName Microsoft.Graph.Entra

}

Describe "Remove-EntraTrustedCertificateAuthority" {
    Context "Test for Remove-EntraTrustedCertificateAuthority" {
        It "Should return object" {
            $cer = Get-EntraTrustedCertificateAuthority 
            $result = Remove-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $cer[0]

            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        
        It "Should fail when CertificateAuthorityInformation is empty" {
            { Remove-EntraTrustedCertificateAuthority -CertificateAuthorityInformation} | Should -Throw "Missing an argument for parameter 'CertificateAuthorityInformation'.*"
        }   
        It "Should fail when ObjectId is empty string" {
            { Remove-EntraTrustedCertificateAuthority -CertificateAuthorityInformation "" } | Should -Throw "Cannot process argument transformation on parameter 'CertificateAuthorityInformation'.*"
        }  

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraTrustedCertificateAuthority"

            $cer = Get-EntraTrustedCertificateAuthority 
            $result = Remove-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $cer[0]
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }  
    }
}