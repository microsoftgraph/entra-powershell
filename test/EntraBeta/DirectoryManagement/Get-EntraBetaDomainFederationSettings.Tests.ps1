# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.Beta.DirectoryManagement     
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "ActiveSignInUri"                       = "https://sts.deverett.info/adfs/services/trust/2005/usernamemixed"
                "DisplayName"                           = "Contoso" 
                "FederatedIdpMfaBehavior"               = "rejectMfaByFederatedIdp" 
                "Id"                                    = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" 
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
    Mock -CommandName Get-MgBetaDomainFederationConfiguration -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Domain.Read.All')
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Get-EntraBetaDomainFederationSettings" {
    Context "Test for Get-EntraBetaDomainFederationSettings" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
            { Get-EntraBetaDomainFederationSettings -DomainName "test.com" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgBetaDomainFederationConfiguration -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 0
        }
        
        It "Should return federation settings" {
            $result = Get-EntraBetaDomainFederationSettings -DomainName "test.com"
            $result | Should -Not -BeNullOrEmpty
            $result.FederationBrandName | Should -Be "Contoso"
            $result.ActiveLogOnUri | Should -Be "https://sts.deverett.info/adfs/services/trust/2005/usernamemixed"
            Should -Invoke -CommandName Get-MgBetaDomainFederationConfiguration -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Returns federation settings" {
            $result = Get-EntraBetaDomainFederationSettings -DomainName "test.com" -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaDomainFederationConfiguration -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when TenantId is empty" {
            { Get-EntraBetaDomainFederationSettings -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is invalid" {
            { Get-EntraBetaDomainFederationSettings -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
        }
        It "Should fail when DomainName is empty" {
            { Get-EntraBetaDomainFederationSettings -DomainName } | Should -Throw "Missing an argument for parameter 'DomainName'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDomainFederationSettings"

            $result = Get-EntraBetaDomainFederationSettings -DomainName "test.com"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDomainFederationSettings"

            Should -Invoke -CommandName Get-MgBetaDomainFederationConfiguration -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaDomainFederationSettings -DomainName "test.com" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }      
    }
}

