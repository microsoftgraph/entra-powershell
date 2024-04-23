BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgGroup -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraMSGroup" {
    Context "Test for Set-EntraMSGroup" {
        It "Should return empty object" {
            $result = Set-EntraMSGroup -Id "2c199eed-f77f-4cf4-9270-299071598fa7" -Description "NEW UPDATE1" -DisplayName "UPDATE helpdesk" -IsAssignableToRole $true -MailEnabled $false -MailNickname "update1" -SecurityEnabled $true -Visibility "Private"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Set-EntraMSGroup -Id ""  } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        } 
        It "Should fail when Description is empty" {
            { Set-EntraMSGroup -Id "2c199eed-f77f-4cf4-9270-299071598fa7" -Description  } | Should -Throw "Missing an argument for parameter 'Description'.*"
        } 
        } 
        It "Should fail when DisplayName is empty" {
            { Set-EntraMSGroup -Id "2c199eed-f77f-4cf4-9270-299071598fa7" -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        } 
        It "Should fail when IsAssignableToRole is empty" {
            { Set-EntraMSGroup -Id "2c199eed-f77f-4cf4-9270-299071598fa7" -IsAssignableToRole  } | Should -Throw "Missing an argument for parameter*"
        } 
        It "Should fail when MailEnabled is empty" {
            { Set-EntraMSGroup -Id "2c199eed-f77f-4cf4-9270-299071598fa7" -MailEnabled  } | Should -Throw "Missing an argument for parameter*"
        } 
        It "Should fail when MailNickname is empty" {
            { Set-EntraMSGroup -Id "2c199eed-f77f-4cf4-9270-299071598fa7" -MailNickname  } | Should -Throw "Missing an argument for parameter*"
        } 
        It "Should fail when SecurityEnabled is empty" {
            { Set-EntraMSGroup -Id "2c199eed-f77f-4cf4-9270-299071598fa7" -SecurityEnabled  } | Should -Throw "Missing an argument for parameter*"
        } 
        It "Should fail when Visibility is empty" {
            { Set-EntraMSGroup -Id "2c199eed-f77f-4cf4-9270-299071598fa7" -Visibility  } | Should -Throw "Missing an argument for parameter*"
        } 
        It "Should fail when MailEnabled is empty" {
            { Set-EntraMSGroup -Id "2c199eed-f77f-4cf4-9270-299071598fa7" -MailEnabled  } | Should -Throw "Missing an argument for parameter*"
        } 
        It "Should contain GroupId in parameters when passed Id to it" {
            Mock -CommandName Update-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraMSGroup -Id 2c199eed-f77f-4cf4-9270-299071598fa7
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "2c199eed-f77f-4cf4-9270-299071598fa7"
        }        
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSGroup"

            $result = Set-EntraMSGroup -Id 2c199eed-f77f-4cf4-9270-299071598fa7
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
