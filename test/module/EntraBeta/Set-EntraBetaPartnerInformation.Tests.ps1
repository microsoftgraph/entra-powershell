# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta     
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Graph.Entra.Beta -MockWith {
        return @{
            value = @(
                @{
                    Id        = "fd560167-ff1f-471a-8d74-3b0070abcea1"
                    Parameters = $args
                }
            )
        }
    }
}

Describe "Set-EntraBetaPartnerInformation"{
    Context "Test for Set-EntraBetaPartnerInformation" {
        It "Should return empty object"{
            Mock -CommandName Invoke-MgGraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
            $result = Set-EntraBetaPartnerInformation -PartnerSupportUrl "http://www.test1.com" -PartnerCommerceUrl "http://www.test1.com" -PartnerHelpUrl "http://www.test1.com" -PartnerSupportEmails "contoso@example.com" -PartnerSupportTelephones "2342" -TenantId b73cc049-a025-4441-ba3a-8826d9a68ecc
            $result | Should -BeNullOrEmpty   
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
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
            $result = Set-EntraBetaPartnerInformation -PartnerSupportUrl "http://www.test1.com" -PartnerCommerceUrl "http://www.test1.com" -PartnerHelpUrl "http://www.test1.com" -PartnerSupportEmails "contoso@example.com" -PartnerSupportTelephones "2342" -TenantId b73cc049-a025-4441-ba3a-8826d9a68ecc
            $params = Get-Parameters -data $result.value.Parameters
            $params.Body.supportEmails | Should -Be @("contoso@example.com")
            $params.Body.supportUrl | Should -Be "http://www.test1.com"
            $params.Body.partnerTenantId | Should -Be "b73cc049-a025-4441-ba3a-8826d9a68ecc"
            $params.Body.helpUrl | Should -Be "http://www.test1.com"
            $params.Body.commerceUrl | Should -Be "http://www.test1.com"
            $params.Body.supportTelephones | Should -Be @("2342")
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaPartnerInformation"

            $result = Set-EntraBetaPartnerInformation -PartnerSupportUrl "http://www.test1.com" 
            $params = Get-Parameters -data $result.value.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}