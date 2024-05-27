BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaGroup -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaGroup" {
    Context "Test for Set-EntraBetaGroup" {
        It "Should return empty object" {
            $result = Set-EntraBetaGroup -ObjectId "1a344543-ce01-4eee-a6bf-70ce848e08cb" -Description "Update Group" -DisplayName "Update My Test san" -MailEnabled $false -MailNickname "Update nickname" -SecurityEnabled $true
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Set-EntraBetaGroup -ObjectId   } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        } 

        It "Should fail when ObjectId is invalid" {
            { Set-EntraBetaGroup -ObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        } 

        It "Should fail when Description is empty" {
            { Set-EntraBetaGroup -ObjectId "1a344543-ce01-4eee-a6bf-70ce848e08cb" -Description  } | Should -Throw "Missing an argument for parameter 'Description'.*"
        } 

        It "Should fail when DisplayName is empty" {
            { Set-EntraBetaGroup -ObjectId "1a344543-ce01-4eee-a6bf-70ce848e08cb" -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        } 

        It "Should fail when MailEnabled is empty" {
            { Set-EntraBetaGroup -ObjectId "1a344543-ce01-4eee-a6bf-70ce848e08cb" -MailEnabled  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when MailEnabled is invalid" {
            { Set-EntraBetaGroup -ObjectId "1a344543-ce01-4eee-a6bf-70ce848e08cb" -MailEnabled ""} | Should -Throw "Cannot process argument transformation on parameter 'MailEnabled'.*"
        } 

        It "Should fail when MailNickname is empty" {
            { Set-EntraBetaGroup -ObjectId "1a344543-ce01-4eee-a6bf-70ce848e08cb" -MailNickname  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Should fail when SecurityEnabled is empty" {
            { Set-EntraBetaGroup -ObjectId "1a344543-ce01-4eee-a6bf-70ce848e08cb" -SecurityEnabled  } | Should -Throw "Missing an argument for parameter*"
        } 

        It "Result should Contain Id" {
            $result = Get-EntraBetaGroup -ObjectId "1a344543-ce01-4eee-a6bf-70ce848e08cb"
            $result.Id | should -Be "1a344543-ce01-4eee-a6bf-70ce848e08cb"
            $result.ObjectId | should -Be "1a344543-ce01-4eee-a6bf-70ce848e08cb"
        } 

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgBetaGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaGroup -ObjectId "1a344543-ce01-4eee-a6bf-70ce848e08cb"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "1a344543-ce01-4eee-a6bf-70ce848e08cb"
        }        

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgBetaGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaGroup"
            $result = Set-EntraBetaGroup -ObjectId "1a344543-ce01-4eee-a6bf-70ce848e08cb"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}