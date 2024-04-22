BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }

    $scriptblock = {
    return @{
         "Id" = "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
    }
}
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    Mock -CommandName Get-MgOrganization -MockWith {$scriptblock} -ModuleName Microsoft.Graph.Entra
    Mock -CommandName Update-MgOrganization -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraTenantDetail" {
    Context "Test for Set-EntraTenantDetail" {
        It "Should return empty object" {
            $result = Set-EntraTenantDetail -MarketingNotificationEmails "amy@contoso.com","henry@contoso.com" -SecurityComplianceNotificationMails "john@contoso.com","mary@contoso.com" -SecurityComplianceNotificationPhones "1-555-625-9999", "1-555-233-5544" -TechnicalNotificationMails "peter@contoso.com"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Update-MgOrganization -ModuleName Microsoft.Graph.Entra -Times 1
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
            Mock -CommandName Update-MgOrganization -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraTenantDetail"

            $result = Set-EntraTenantDetail -MarketingNotificationEmails "amy@contoso.com","henry@contoso.com" -SecurityComplianceNotificationMails "john@contoso.com","mary@contoso.com" -SecurityComplianceNotificationPhones "1-555-625-9999", "1-555-233-5544" -TechnicalNotificationMails "peter@contoso.com"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}