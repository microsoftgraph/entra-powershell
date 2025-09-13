# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -MockWith {
        return @{
            value = @(
                @{
                    Id         = "fd560167-ff1f-471a-8d74-3b0070abcea1"
                    Parameters = $args
                }
            )
        }
    }

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Organization.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "Set-EntraPartnerInformation" {
    Context "Test for Set-EntraPartnerInformation" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Set-EntraPartnerInformation -PartnerSupportUrl "http://www.test1.com" -PartnerCommerceUrl "http://www.test1.com" -PartnerHelpUrl "http://www.test1.com" -PartnerSupportEmails "contoso@example.com" -PartnerSupportTelephones "2342" -TenantId b73cc049-a025-4441-ba3a-8826d9a68ecc } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }
        
        It "Should return empty object" {
            Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Entra.DirectoryManagement
            $result = Set-EntraPartnerInformation -PartnerSupportUrl "http://www.test1.com" -PartnerCommerceUrl "http://www.test1.com" -PartnerHelpUrl "http://www.test1.com" -PartnerSupportEmails "contoso@example.com" -PartnerSupportTelephones "2342" -TenantId b73cc049-a025-4441-ba3a-8826d9a68ecc
            $result | Should -BeNullOrEmpty   
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when PartnerSupportUrl is empty" {
            { Set-EntraPartnerInformation -PartnerSupportUrl } | Should -Throw "Missing an argument for parameter 'PartnerSupportUrl'*"
        }
        It "Should fail when PartnerCommerceUrl is empty" {
            { Set-EntraPartnerInformation -PartnerCommerceUrl } | Should -Throw "Missing an argument for parameter 'PartnerCommerceUrl'*"
        }
        It "Should fail when PartnerHelpUrl is empty" {
            { Set-EntraPartnerInformation -PartnerHelpUrl } | Should -Throw "Missing an argument for parameter 'PartnerHelpUrl'*"
        }
        It "Should fail when PartnerSupportEmails is empty" {
            { Set-EntraPartnerInformation -PartnerSupportEmails } | Should -Throw "Missing an argument for parameter 'PartnerSupportEmails'*"
        }
        It "Should fail when PartnerSupportTelephones is empty" {
            { Set-EntraPartnerInformation -PartnerSupportTelephones } | Should -Throw "Missing an argument for parameter 'PartnerSupportTelephones'*"
        }
        It "Should fail when TenantId is empty" {
            { Set-EntraPartnerInformation -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is invalid" {
            { Set-EntraPartnerInformation -TenantId abc } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'*"
        }
        It "Should contain params" {
            $result = Set-EntraPartnerInformation -PartnerSupportUrl "http://www.test1.com" -PartnerCommerceUrl "http://www.test1.com" -PartnerHelpUrl "http://www.test1.com" -PartnerSupportEmails "contoso@example.com" -PartnerSupportTelephones "2342" -TenantId b73cc049-a025-4441-ba3a-8826d9a68ecc
            $params = Get-Parameters -data $result.value.Parameters
            $params.Body.supportEmails | Should -Be @("contoso@example.com")
            $params.Body.supportUrl | Should -Be "http://www.test1.com"
            $params.Body.partnerTenantId | Should -Be "b73cc049-a025-4441-ba3a-8826d9a68ecc"
            $params.Body.helpUrl | Should -Be "http://www.test1.com"
            $params.Body.commerceUrl | Should -Be "http://www.test1.com"
            $params.Body.supportTelephones | Should -Be @("2342")
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraPartnerInformation"

            Set-EntraPartnerInformation -PartnerSupportUrl "http://www.test1.com" -PartnerCommerceUrl "http://www.test1.com" -PartnerHelpUrl "http://www.test1.com" -PartnerSupportEmails "contoso@example.com" -PartnerSupportTelephones "2342" -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ff"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraPartnerInformation"

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Set-EntraPartnerInformation -PartnerSupportUrl "http://www.test1.com" -PartnerCommerceUrl "http://www.test1.com" -PartnerHelpUrl "http://www.test1.com" -PartnerSupportEmails "contoso@example.com" -PartnerSupportTelephones "2342" -TenantId "00aa00aa-bb11-cc22-dd33-44ee44ee44ff" } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}

