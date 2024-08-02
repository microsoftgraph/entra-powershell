
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgGroup -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraMSGroup" {
    Context "Test for Set-EntraMSGroup" {
        It "Should update a group" {
            $result = Set-EntraMSGroup -Id "9a9ab239-269c-4d91-9935-9f2cb16074fb" -Description "Update Group" -DisplayName "Update helpdesk" -IsAssignableToRole $true -MailEnabled $false -MailNickname "Update nickname" -SecurityEnabled $true -Visibility "Private" -GroupTypes "unified"
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Update-MgGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Id is empty" {
            { Set-EntraMSGroup -Id   } | Should -Throw "Missing an argument for parameter 'Id'*"
        } 

        It "Should fail when Id is invalid" {
            { Set-EntraMSGroup -Id ""  } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        } 

        It "Should fail when Description is empty" {
            { Set-EntraMSGroup -Id "9a9ab239-269c-4d91-9935-9f2cb16074fb" -Description  } | Should -Throw "Missing an argument for parameter 'Description'.*"
        } 

        It "Should fail when DisplayName is empty" {
            { Set-EntraMSGroup -Id "9a9ab239-269c-4d91-9935-9f2cb16074fb" -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        } 

        It "Should fail when IsAssignableToRole is empty" {
            { Set-EntraMSGroup -Id "9a9ab239-269c-4d91-9935-9f2cb16074fb" -IsAssignableToRole  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when IsAssignableToRole is invalid" {
            { Set-EntraMSGroup -Id "9a9ab239-269c-4d91-9935-9f2cb16074fb" -IsAssignableToRole "" } | Should -Throw "Cannot process argument transformation on parameter 'IsAssignableToRole'.*"
        } 

        It "Should fail when MailEnabled is empty" {
            { Set-EntraMSGroup -Id "9a9ab239-269c-4d91-9935-9f2cb16074fb" -MailEnabled  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when MailEnabled is invalid" {
            { Set-EntraMSGroup -Id "9a9ab239-269c-4d91-9935-9f2cb16074fb" -MailEnabled ""} | Should -Throw "Cannot process argument transformation on parameter 'MailEnabled'.*"
        } 

        It "Should fail when MailNickname is empty" {
            { Set-EntraMSGroup -Id "9a9ab239-269c-4d91-9935-9f2cb16074fb" -MailNickname  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when SecurityEnabled is empty" {
            { Set-EntraMSGroup -Id "9a9ab239-269c-4d91-9935-9f2cb16074fb" -SecurityEnabled  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when Visibility is empty" {
            { Set-EntraMSGroup -Id "9a9ab239-269c-4d91-9935-9f2cb16074fb" -Visibility  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when GroupTypes is empty" {
            { Set-EntraMSGroup -Id "9a9ab239-269c-4d91-9935-9f2cb16074fb" -GroupTypes  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should contain GroupId in parameters when passed Id to it" {
            Mock -CommandName Update-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraMSGroup -Id "9a9ab239-269c-4d91-9935-9f2cb16074fb"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "9a9ab239-269c-4d91-9935-9f2cb16074fb"
        }        
        
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSGroup"
            $result = Set-EntraMSGroup -Id "9a9ab239-269c-4d91-9935-9f2cb16074fb"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}