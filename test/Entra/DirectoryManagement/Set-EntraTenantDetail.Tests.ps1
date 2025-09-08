# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.DirectoryManagement        
    }

    $scriptblock = {
    return @{
         "Id" = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
    }
}
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    Mock -CommandName Get-MgOrganization -MockWith {$scriptblock} -ModuleName Microsoft.Entra.DirectoryManagement
    Mock -CommandName Update-MgOrganization -MockWith {} -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Organization.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}
  
Describe "Set-EntraTenantDetail" {
    Context "Test for Set-EntraTenantDetail" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Set-EntraTenantDetail -MarketingNotificationEmails "amy@contoso.com","henry@contoso.com" -SecurityComplianceNotificationMails "john@contoso.com","mary@contoso.com" -SecurityComplianceNotificationPhones "1-555-625-9999", "1-555-233-5544" -TechnicalNotificationMails "peter@contoso.com" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Update-MgOrganization -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }
        
        It "Should return empty object" {
            $result = Set-EntraTenantDetail -MarketingNotificationEmails "amy@contoso.com","henry@contoso.com" -SecurityComplianceNotificationMails "john@contoso.com","mary@contoso.com" -SecurityComplianceNotificationPhones "1-555-625-9999", "1-555-233-5544" -TechnicalNotificationMails "peter@contoso.com"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Update-MgOrganization -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when MarketingNotificationEmails is empty" {
            { Set-EntraTenantDetail -MarketingNotificationEmails  } | Should -Throw "Missing an argument for parameter 'MarketingNotificationEmails'.*"
        } 
         It "Should fail when SecurityComplianceNotificationMails is empty" {
            { Set-EntraTenantDetail -SecurityComplianceNotificationMails   } | Should -Throw "Missing an argument for parameter 'SecurityComplianceNotificationMails'.*"
        }
        It "Should fail when SecurityComplianceNotificationPhones is empty" {
            { Set-EntraTenantDetail -SecurityComplianceNotificationPhones  } | Should -Throw "Missing an argument for parameter 'SecurityComplianceNotificationPhones'.*"
        } 
        It "Should fail when TechnicalNotificationMails is empty" {
            { Set-EntraTenantDetail -TechnicalNotificationMails  } | Should -Throw "Missing an argument for parameter 'TechnicalNotificationMails'.*"
        }  
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraTenantDetail"

            Set-EntraTenantDetail -MarketingNotificationEmails "amy@contoso.com","henry@contoso.com" -SecurityComplianceNotificationMails "john@contoso.com","mary@contoso.com" -SecurityComplianceNotificationPhones "1-555-625-9999", "1-555-233-5544" -TechnicalNotificationMails "peter@contoso.com"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraTenantDetail"

            Should -Invoke -CommandName Update-MgOrganization -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Set-EntraTenantDetail -MarketingNotificationEmails "amy@contoso.com","henry@contoso.com" -SecurityComplianceNotificationMails "john@contoso.com","mary@contoso.com" -SecurityComplianceNotificationPhones "1-555-625-9999", "1-555-233-5544" -TechnicalNotificationMails "peter@contoso.com" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

