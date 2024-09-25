# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
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

Describe "Get-EntraDomainFederationSettings" {
    Context "Test for Get-EntraDomainFederationSettings" {
        It "Should return federation settings" {
            $result = Get-EntraDomainFederationSettings -DomainName "test.com"
            $result | Should -Not -BeNullOrEmpty
            $result.FederationBrandName | Should -Be "Contoso"
            $result.ActiveLogOnUri | Should -Be "https://sts.deverett.info/adfs/services/trust/2005/usernamemixed"
            Should -Invoke -CommandName Get-MgDomainFederationConfiguration -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when TenantId is null" {
            { Get-EntraDomainFederationSettings -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is empty" {
            { Get-EntraDomainFederationSettings -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
        }
        It "Should fail when DomainName is null" {
            { Get-EntraDomainFederationSettings -DomainName } | Should -Throw "Missing an argument for parameter 'DomainName'*"
        }
        It "Should fail when DomainName is empty" {
            { Get-EntraDomainFederationSettings -DomainName "" } | Should -Throw "Cannot bind argument to parameter 'DomainName'*"
        }
        It "Should fail when invalid paramter is passed"{
            { Get-EntraDomainFederationSettings -Demo } | Should -Throw "A parameter cannot be found that matches parameter name 'Demo'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDomainFederationSettings"
            $result = Get-EntraDomainFederationSettings -DomainName "test.com"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDomainFederationSettings"
            Should -Invoke -CommandName Get-MgDomainFederationConfiguration -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraDomainFederationSettings -DomainName "test.com" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}