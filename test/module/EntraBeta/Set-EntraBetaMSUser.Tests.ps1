BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaUser -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaMSUser" {
    Context "Test for Set-EntraBetaMSUser" {
        It "Should update a user" {
            $result = Set-EntraBetaMSUser -Id "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Displayname "dummy1"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Set-EntraBetaMSUser -Id   } | Should -Throw "Missing an argument for parameter 'Id'*"
        } 

        It "Should fail when Id is invalid" {
            { Set-EntraBetaMSUser -Id ""  } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        } 

        It "Should fail when DisplayName is empty" {
            { Set-EntraBetaMSUser -Id "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Displayname  } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        } 

        It "Should fail when CustomSecurityAttributes is empty" {
            { Set-EntraBetaMSUser -Id "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -CustomSecurityAttributes  } | Should -Throw "Missing an argument for parameter 'CustomSecurityAttributes'.*"
        } 

        It "Should fail when CustomSecurityAttributes is invalid" {
            { Set-EntraBetaMSUser -Id "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -CustomSecurityAttributes "" } | Should -Throw "Cannot process argument transformation on parameter 'CustomSecurityAttributes'.*"
        } 

        It "Should fail when UserPrincipalName is empty" {
            { Set-EntraBetaMSUser -Id "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -UserPrincipalName } | Should -Throw "Missing an argument for parameter 'UserPrincipalName'*"
        } 
        
        It "Should contain UserId in parameters when passed Id to it" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaMSUser -Id "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Displayname "dummy1"
            $params = Get-Parameters -data $result
            $params.UserId | Should -Be "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee"
        }        

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgBetaUser -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaMSUser"
            $result = Set-EntraBetaMSUser -Id "900f2cdd-7fd5-42c1-9b12-3e8511dd36ee" -Displayname "dummy1"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}