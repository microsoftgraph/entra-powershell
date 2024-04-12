BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraMSGroup with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "DisplayName"     = "UPDISPLAY"
              "Id"              = "fc446647-e8ff-47f1-a489-cf31694c0d35"
              "MailEnabled"     = "True"
              "Description"     = "Upd1"
              "MailNickname"    = "Remoteliving"
              "SecurityEnabled" = "False"
              "Parameters"      = $args
        
            }
        )
    }

    Mock -CommandName Get-MgGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraMSGroup" {
    Context "Test for Get-EntraMSGroup" {
        It "Should return specific group" {
            $result = Get-EntraMSGroup -Id "fc446647-e8ff-47f1-a489-cf31694c0d35"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'fc446647-e8ff-47f1-a489-cf31694c0d35'

            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should not contain the invalid Id" {
            $result = Get-EntraMSGroup -Id "xyz"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Not -Be 'xyz'

            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraMSGroup -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."

         
        }
        It "Should return all group" {
            $result = Get-EntraMSGroup -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraMSGroup -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }           
        It "Should return specific group by searchstring" {
            $result = Get-EntraMSGroup -SearchString 'UPDISPLAY'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'UPDISPLAY'

            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        } 
        It "Should return specific group by filter" {
            $result = Get-EntraMSGroup -Filter "DisplayName -eq 'UPDISPLAY'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'UPDISPLAY'

            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should return top group" {
            $result = Get-EntraMSGroup -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraMSGroup -Id "fc446647-e8ff-47f1-a489-cf31694c0d35"
            $result.ObjectId | should -Be "fc446647-e8ff-47f1-a489-cf31694c0d35"
        } 
        It "Should contain GroupId in parameters when passed Id to it" {
            Mock -CommandName Get-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Get-EntraMSGroup -Id "fc446647-e8ff-47f1-a489-cf31694c0d35"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "fc446647-e8ff-47f1-a489-cf31694c0d35"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {
            Mock -CommandName Get-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Get-EntraMSGroup -SearchString 'UPDISPLAY'
            $params = Get-Parameters -data $result
            $params.Filter | Should -Match "UPDISPLAY"
        }
        It "Should contain 'User-Agent' header" {
        
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSGroup"
            $result = Get-EntraMSGroup -Id "fc446647-e8ff-47f1-a489-cf31694c0d35"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
        }    
    }
