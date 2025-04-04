# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
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
                "Parameters" = $args
            }
        )
    }    
    Mock -CommandName Get-MgBetaDomainFederationConfiguration -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta

    Mock -CommandName Update-MgBetaDomainFederationConfiguration -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}
Describe "Set-EntraBetaDomainFederationSettings" {
    Context "Test for Set-EntraBetaDomainFederationSettings" {
        It "Should Updates settings for a federated domain." {
            $result =  Set-EntraBetaDomainFederationSettings -DomainName "manan.lab.myworkspace.microsoft.com" -LogOffUri "https://adfs1.manan.lab/adfs/" -PassiveLogOnUri "https://adfs1.manan.lab/adfs/" -ActiveLogOnUri "https://adfs1.manan.lab/adfs/services/trust/2005/" -IssuerUri "http://adfs1.manan.lab/adfs/services/" -FederationBrandName "ADFS" -MetadataExchangeUri "https://adfs1.manan.lab/adfs/services/trust/" -PreferredAuthenticationProtocol "saml" -PromptLoginBehavior "nativeSupport"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Update-MgBetaDomainFederationConfiguration -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        
        It "Should fail when DomainName is empty" {
             {Set-EntraBetaDomainFederationSettings -DomainName} | Should -Throw "Missing an argument for parameter 'DomainName'. Specify a parameter*"
        }

        It "Should fail when DomainName is invalid" {
             {Set-EntraBetaDomainFederationSettings -DomainName ""} | Should -Throw "Cannot bind argument to parameter 'DomainName' because it is an empty string.*"
        } 

        It "Should fail when parameter is empty" {
            {Set-EntraBetaDomainFederationSettings -DomainName "manan.lab.myworkspace.microsoft.com" -LogOffUri  -PassiveLogOnUri  -ActiveLogOnUri -IssuerUri  -FederationBrandName  -MetadataExchangeUri  -PreferredAuthenticationProtocol  -PromptLoginBehavior } | Should -Throw "Missing an argument for parameter*"
        }
        It "Should fail when invalid paramter is passed"{
            {Set-EntraBetaDomainFederationSettings -Demo } | Should -Throw "A parameter cannot be found that matches parameter name 'Demo'*"
        }   
        It "Should contain DomainId in parameters when DomainName to it" {
            Mock -CommandName Update-MgBetaDomainFederationConfiguration -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
            $result = Set-EntraBetaDomainFederationSettings -DomainName "manan.lab.myworkspace.microsoft.com"
            $params = Get-Parameters -data $result
            $a= $params | ConvertTo-json | ConvertFrom-Json
            $a.DomainId | Should -Be "manan.lab.myworkspace.microsoft.com"         
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaDomainFederationSettings"

            Set-EntraBetaDomainFederationSettings -DomainName "manan.lab.myworkspace.microsoft.com"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaDomainFederationSettings"

            Should -Invoke -CommandName Update-MgBetaDomainFederationConfiguration -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Set-EntraBetaDomainFederationSettings -DomainName "manan.lab.myworkspace.microsoft.com" -LogOffUri "https://adfs1.manan.lab/adfs/" -PassiveLogOnUri "https://adfs1.manan.lab/adfs/" -ActiveLogOnUri "https://adfs1.manan.lab/adfs/services/trust/2005/" -IssuerUri "http://adfs1.manan.lab/adfs/services/" -FederationBrandName "ADFS" -MetadataExchangeUri "https://adfs1.manan.lab/adfs/services/trust/" -PreferredAuthenticationProtocol "saml" -PromptLoginBehavior "nativeSupport" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 

    }
} 