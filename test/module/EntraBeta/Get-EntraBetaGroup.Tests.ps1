BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "DisplayName"     = "demo"
              "Id"              = "056b2531-005e-4f3e-be78-01a71ea30a04"
              "MailEnabled"     = "False"
              "Description"     = "test"
              "MailNickname"    = "demoNickname"
              "SecurityEnabled" = "True"
              "Parameters"      = $args
            }
        )
    }
    Mock -CommandName Get-MgBetaGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "Get-EntraBetaGroup" {
    Context "Test for Get-EntraBetaGroup" {
        It "Should return specific group" {
            $result = Get-EntraBetaGroup -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '056b2531-005e-4f3e-be78-01a71ea30a04'

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaGroup -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is invalid" {
            { Get-EntraBetaGroup -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should return all group" {
            $result = Get-EntraBetaGroup -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraBetaGroup -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }      

        It "Should fail when All is invalid" {
            { Get-EntraBetaGroup -All "" } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }      

        It "Should return specific group by searchstring" {
            $result = Get-EntraBetaGroup -SearchString 'demo'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'demo'

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        } 

        It "Should fail when SearchString is empty" {
            { Get-EntraBetaGroup -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }  

        It "Should return specific group by filter" {
            $result = Get-EntraBetaGroup -Filter "DisplayName -eq 'demo'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'demo'

            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when Filter is empty" {
            { Get-EntraBetaGroup -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }  

        It "Should return top group" {
            $result = Get-EntraBetaGroup -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgBetaGroup -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraBetaGroup -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraBetaGroup -Top y } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  
        
        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaGroup -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04"
            $result.ObjectId | should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        } 

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            $result = Get-EntraBetaGroup -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }

        It "Should contain Filter in parameters when passed SearchString to it" {
            $result = Get-EntraBetaGroup -SearchString 'demo'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "demo"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaGroup"

            $result = Get-EntraBetaGroup -SearchString 'demo'
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }    
    }
}