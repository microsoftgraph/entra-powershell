# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                Id                         = '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
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
                IssuerSki          = "66aa66aa-bb77-cc88-dd99-00ee00ee00ee"
            }
               
            }
        )

    }

    Mock -CommandName Get-MgOrganizationCertificateBasedAuthConfiguration -MockWith $scriptblock2 -ModuleName Microsoft.Graph.Entra

    $scriptblock3 = {
        return @(
            [PSCustomObject]@{
                TenantId = "aaaabbbb-0000-cccc-1111-dddd2222eeee"
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
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraTrustedCertificateAuthority"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $cer = Get-EntraTrustedCertificateAuthority 

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Remove-EntraTrustedCertificateAuthority -CertificateAuthorityInformation $cer[0] -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}