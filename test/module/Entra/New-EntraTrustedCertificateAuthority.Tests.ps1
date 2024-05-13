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
                "@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#certificateBasedAuthConfiguration/$entity"
                certificateAuthorities = @{ 
                    IsRootAuthority              = "RootAuthority"
                    CertificateRevocationListUrl       = "https://example.crl"
                    DeltaCertificateRevocationListUrl = ""
                    Certificate        = @(70, 57, 66, 65, 57, 49, 69, 55, 54, 68, 57, 51, 49, 48, 51, 49, 55, 49, 55, 49, 50, 54, 69, 55, 68, 52, 70, 56, 70, 54, 57, 70, 55, 52, 51, 52, 57, 56, 53, 51)
                    Issuer             = "CN=mscmdlet"
                    IssuerSki          = "23C98A95721291E474455243BDDB5651FE7BCDE8"
                    Parameters                 = $args
                }
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
        It "Should return created Group" {

            $byteData = @(70, 57, 66, 65, 57, 49, 69, 55, 54, 68, 57, 51, 49, 48, 51, 49, 55, 49, 55, 49, 50, 54, 69, 55, 68, 52, 70, 56, 70, 54, 57, 70, 55, 52, 51, 52, 57, 56, 53, 51)
            $new_ca=New-Object -TypeName Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation
            $new_ca.AuthorityType=0
            $new_ca.TrustedCertificate= $byteData
            $new_ca.crlDistributionPoint="https://example.crl"
            $new_ca.DeltaCrlDistributionPoint="https://test.crl"

            $result = New-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $new_ca

            write-host ">>>>>>>>>>>." $result
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }


    }
}