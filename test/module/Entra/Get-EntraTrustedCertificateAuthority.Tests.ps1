# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        @{
            "CertificateAuthorities" = @(
                @{
                    "isRootAuthority" = $true
                    "certificateRevocationListUrl"= "https://example.crl"
                    "deltaCertificateRevocationListUrl"= "https://test.crl"
                    "certificate"=
                                "MIIDADCCAeigAwIBAgIQZUf+HS6ftbZKl+KtsZRsTDANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhtc2NtZGxldDAeFw0yNDAzMDYwNzIwMzhaFw0yNT
                                AzMDYwNzQwMzhaMBMxETAPBgNVBAMMCG1zY21kbGV0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApxIWxFGyuCi8kxmdjJI1WfY7zWqtgwvpk
                                wswBKrYmzN1/MzG2YX9yXsSLSd8Exh45P28ET3HpstVCXU1NnlQLW6c1ZEicRfj+Lv/h/z7Ckip8ccpJUNTaeyygC0pvqYjn+6zIVstMSOjNrWbQ8KrHTCh
                                lL3YvzD96PLbRHHHVcdT35fjezayWhMBSoc7rPO5Y0zgo9jKQt5rsIlEM72VssHy2H+dFkTCw2LbNy06oMoHpwXIDuQJSWXTu//G/DAuMIQ9hFDXh8hXJN5
                                NCuesPF0tPqF4MbcGLREV2k6+MC7WZGsu2zcnr44Us0GZEq7F/h+hRGUeVGa/1Ve2oJmFqQIDAQABo1AwTjAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0lBBYwFA
                                YIKwYBBQUHAwIGCCsGAQUFBwMBMB0GA1UdDgQWBBSgpCZWuICzX6fIkpoBGmIRMVD3iDANBgkqhkiG9w0BAQsFAAOCAQEAAYGPkNJMnBQ44FEIc7uWBI1dy
                                3qtSVX3oLIawt2qtRiy7QybJCrVFhh7L5P2wcJeQAKJCwc6kL+KzL1IUSrieNt2OK0FblcW6yqLE4RnJEaa30Uog5Cwji8EOXwo1SA6P6ltXMC3qULCNjsf
                                VivDE3urizDBDvA8qBnh7vaQooiIwwxA0i+lqeGjB4ySpIR4rjM7PNISOWctmdgoFydJkBsyjGfTilZWI2Y4duW+CULJtuIQtw/buY/Km+CcBbbLAbE+PGF
                                MpTynQ2Lh66QPFimLCldkgFBsy0ShM5zMHhd8zJP3iDZ46eO03Hw/NZK/GXya3gAzDxmzaEc6iiFSig=="
                    "issuer"= "CN=mscmdlet"
                    "issuerSki"= "A0A42656B880B35FA7C8929A011A62113150F788"
                    "Parameters"                        = $args
                }
            )            
        }
    }
    $tenantObj = {
        return @(
            [PSCustomObject]@{
                TenantId = "aaaabbbb-0000-cccc-1111-dddd2222eeee"
            }
        )

    }

    Mock -CommandName Get-MgContext -MockWith $tenantObj -ModuleName Microsoft.Graph.Entra

    Mock -CommandName Get-MgOrganizationCertificateBasedAuthConfiguration -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Get-EntraTrustedCertificateAuthority"{
    It "Result should not be empty when no parameter passed" {
        $result = Get-EntraTrustedCertificateAuthority
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgOrganizationCertificateBasedAuthConfiguration -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Result should not be empty when parameters are empty" {
        $result = Get-EntraTrustedCertificateAuthority -TrustedIssuer '' -TrustedIssuerSki ''
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Get-MgOrganizationCertificateBasedAuthConfiguration -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Property parameter should work" {
        $result = Get-EntraTrustedCertificateAuthority -Property TrustedIssuerSki
        $result | Should -Not -BeNullOrEmpty
        $result.TrustedIssuerSki | Should -Be 'A0A42656B880B35FA7C8929A011A62113150F788'
    }
    It "Should fail when TrustedIssuer is null" {
        { Get-EntraTrustedCertificateAuthority -TrustedIssuer  } | Should -Throw "Missing an argument for parameter*"
    }
    It "Should fail when TrustedIssuerSki is null" {
        { Get-EntraTrustedCertificateAuthority -TrustedIssuerSki  } | Should -Throw "Missing an argument for parameter*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraTrustedCertificateAuthority"
        Get-EntraTrustedCertificateAuthority
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraTrustedCertificateAuthority"
        Should -Invoke -CommandName Get-MgOrganizationCertificateBasedAuthConfiguration -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
            $true
        }
    }
    It "Should execute successfully without throwing an error " {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Get-EntraTrustedCertificateAuthority -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}