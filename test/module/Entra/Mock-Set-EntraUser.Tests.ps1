BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgUser -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraUser" {
    Context "Test for Set-EntraUser" {
        It "Should return empty object" {
            $result = Set-EntraUser -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04 -DisplayName "demo002" -UserPrincipalName "demo001@M365x99297270.OnMicrosoft.com" -AccountEnabled $true -MailNickName "demo002NickName" -AgeGroup "adult" -PostalCode "10001"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgUser -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Set-EntraUser -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        } 

        It "Should fail when ObjectId is no value" {
            { Set-EntraUser -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        } 

        It "Should contain userId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgUser -MockWith { $args } -ModuleName Microsoft.Graph.Entra
            $result = Set-EntraUser -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04 -Mobile "1234567890"
            $params = Get-Parameters -data $result
            $params.userId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
            $params.MobilePhone | Should -Be "1234567890"

        }

        It "Should contain MobilePhone in parameters when passed Mobile to it" {
            Mock -CommandName Update-MgUser -MockWith { $args } -ModuleName Microsoft.Graph.Entra
            $result = Set-EntraUser -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04 -Mobile "1234567890"
            $params = Get-Parameters -data $result
            $params.MobilePhone | Should -Be "1234567890"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgUser -MockWith { $args } -ModuleName Microsoft.Graph.Entra
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUser"
            $result = Set-EntraUser -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
 
        
        It "Should contain ExternalUserState, OnPremisesImmutableId, ExternalUserStateChangeDateTime, BusinessPhones" {
            Mock -CommandName Update-MgUser -MockWith { $args } -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraUser -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04 `
                -UserState "PendingAcceptance" `
                -ImmutableId "djkjsajsa-e32j2-2i32" `
                -TelephoneNumber "1234567890"
            
            $params = Get-Parameters -data $result
            
            $params.BusinessPhones[0] | Should -Be "1234567890"

            $params.ExternalUserState | Should -Be "PendingAcceptance"

            $params.OnPremisesImmutableId | Should -Be "djkjsajsa-e32j2-2i32"

        }  
    }
        
}