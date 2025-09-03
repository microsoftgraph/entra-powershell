# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.SignIns) -eq $null){
        Import-Module Microsoft.Entra.SignIns      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    
    $tenantObj = {
        return @(
            [PSCustomObject]@{
                TenantId = "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            }
        )

    }

    Mock -CommandName Get-MgContext -MockWith $tenantObj -ModuleName Microsoft.Entra.SignIns
    
    $scriptblock = {
        return @(
            @{
                Id                         = '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
                "@odata.context" = $args
                certificateAuthorities = @{ 
                    IsRootAuthority              = "RootAuthority"
                    CertificateRevocationListUrl       = "https://example.crl"
                    DeltaCertificateRevocationListUrl = ""
                    Certificate        = @(70, 57, 66, 65, 57, 49, 69, 55, 54, 68, 57, 51, 49, 48, 51, 49, 55, 49, 55, 49, 50, 54, 69, 55, 68, 52, 70, 56, 70, 54, 57, 70, 55, 52, 51, 52, 57, 56, 53, 51)
                    Issuer             = "CN=mscmdlet"
                    IssuerSki          = "66aa66aa-bb77-cc88-dd99-00ee00ee00ee" 
                }
                Parameters                 = $args
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.SignIns

    $scriptblock2 = {
        return @(
            [PSCustomObject]@{
                CertificateAuthorities = @{ 
                IsRootAuthority              = "RootAuthority"
                CertificateRevocationListUrl       = "https://example.crl"
                DeltaCertificateRevocationListUrl = ""
                Certificate        = @(70, 57, 66, 65, 57, 49, 69, 55, 54, 68, 57, 51, 49, 48, 51, 49, 55, 49, 55, 49, 50, 54, 69, 55, 68, 52, 70, 56, 70, 54, 57, 70, 55, 52, 51, 52, 57, 56, 53, 51)
                Issuer             = "CN=mscmdlet"
                IssuerSki          = "66aa66aa-bb77-cc88-dd99-00ee00ee00ee"
            }
            }
        )

    }

    Mock -CommandName Get-MgOrganizationCertificateBasedAuthConfiguration -MockWith $scriptblock2 -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @('Organization.ReadWrite.All') } } -ModuleName Microsoft.Entra.SignIns
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
            $result.Id | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.certificateAuthorities.TrustedIssuer| Should -Be "CN=mscmdlet"
            $result.certificateAuthorities.CrlDistributionPoint| Should -Be "https://example.crl"
            $result.certificateAuthorities.AuthorityType| Should -Be "RootAuthority"
            $result.certificateAuthorities.TrustedIssuerSki| Should -Be "66aa66aa-bb77-cc88-dd99-00ee00ee00ee"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.SignIns -Times 1
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
            
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraTrustedCertificateAuthority"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
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

            $params.uri | Should -Match "aaaabbbb-0000-cccc-1111-dddd2222eeee" 
        }   

        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $byteData = @(70, 57, 66, 65, 57, 49, 69, 55, 54, 68, 57, 51, 49, 48, 51, 49, 55, 49, 55, 49, 50, 54, 69, 55, 68, 52, 70, 56, 70, 54, 57, 70, 55, 52, 51, 52, 57, 56, 53, 51)
            $new_ca=New-Object -TypeName Microsoft.Open.AzureAD.Model.CertificateAuthorityInformation
            $new_ca.AuthorityType=0
            $new_ca.TrustedCertificate= $byteData
            $new_ca.crlDistributionPoint="https://example.crl"
            $new_ca.DeltaCrlDistributionPoint="https://test.crl"

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                {New-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $new_ca -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

