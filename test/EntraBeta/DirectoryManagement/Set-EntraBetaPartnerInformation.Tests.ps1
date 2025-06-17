# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.Beta.DirectoryManagement     
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -MockWith {
        return @{
            value = @(
                @{
                    Id        = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                    Parameters = $args
                }
            )
        }
    }
}

Describe "Set-EntraBetaPartnerInformation"{
    Context "Test for Set-EntraBetaPartnerInformation" {
        It "Should return empty object"{
            Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
            $result = Set-EntraBetaPartnerInformation -PartnerSupportUrl "http://www.test1.com" -PartnerCommerceUrl "http://www.test1.com" -PartnerHelpUrl "http://www.test1.com" -PartnerSupportEmails "contoso@example.com" -PartnerSupportTelephones "2342" -TenantId b73cc049-a025-4441-ba3a-8826d9a68ecc
            $result | Should -BeNullOrEmpty   
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when PartnerSupportUrl is empty" {
            { Set-EntraBetaPartnerInformation -PartnerSupportUrl } | Should -Throw "Missing an argument for parameter 'PartnerSupportUrl'*"
        }
        It "Should fail when PartnerCommerceUrl is empty" {
            { Set-EntraBetaPartnerInformation -PartnerCommerceUrl } | Should -Throw "Missing an argument for parameter 'PartnerCommerceUrl'*"
        }
        It "Should fail when PartnerHelpUrl is empty" {
            { Set-EntraBetaPartnerInformation -PartnerHelpUrl } | Should -Throw "Missing an argument for parameter 'PartnerHelpUrl'*"
        }
        It "Should fail when PartnerSupportEmails is empty" {
            { Set-EntraBetaPartnerInformation -PartnerSupportEmails } | Should -Throw "Missing an argument for parameter 'PartnerSupportEmails'*"
        }
        It "Should fail when PartnerSupportTelephones is empty" {
            { Set-EntraBetaPartnerInformation -PartnerSupportTelephones } | Should -Throw "Missing an argument for parameter 'PartnerSupportTelephones'*"
        }
        It "Should fail when TenantId is empty" {
            { Set-EntraBetaPartnerInformation -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is invlaid" {
            { Set-EntraBetaPartnerInformation -TenantId abc } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'*"
        }
        It "Should contain params" {
            $result = Set-EntraBetaPartnerInformation -PartnerSupportUrl "http://www.test1.com" -PartnerCommerceUrl "http://www.test1.com" -PartnerHelpUrl "http://www.test1.com" -PartnerSupportEmails "contoso@example.com" -PartnerSupportTelephones "2342" -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ff"
            $params = Get-Parameters -data $result.value.Parameters
            $params.Body.supportEmails | Should -Be @("contoso@example.com")
            $params.Body.supportUrl | Should -Be "http://www.test1.com"
            $params.Body.partnerTenantId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ff"
            $params.Body.helpUrl | Should -Be "http://www.test1.com"
            $params.Body.commerceUrl | Should -Be "http://www.test1.com"
            $params.Body.supportTelephones | Should -Be @("2342")
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaPartnerInformation"
            Set-EntraBetaPartnerInformation -PartnerSupportUrl "http://www.test1.com" -PartnerCommerceUrl "http://www.test1.com" -PartnerHelpUrl "http://www.test1.com" -PartnerSupportEmails "contoso@example.com" -PartnerSupportTelephones "2342" -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ff"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Set-EntraBetaPartnerInformation -PartnerSupportUrl "http://www.test1.com" -TenantId 'aaaaaaaa-1111-1111-1111-000000000000' } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

