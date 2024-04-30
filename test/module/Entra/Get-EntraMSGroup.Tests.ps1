BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraMSGroup with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "DisplayName"     = "Demo Help Group"
              "Id"              = "0428af4d-9850-4c6c-88f1-4576dbf70281"
              "MailEnabled"     = "True"
              "Description"     = ""
              "MailNickname"    = "helpDeskAdminGroup"
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
            $result = Get-EntraMSGroup -Id "0428af4d-9850-4c6c-88f1-4576dbf70281"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "0428af4d-9850-4c6c-88f1-4576dbf70281"
            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is invalid" {
            { Get-EntraMSGroup -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when Id is empty" {
            { Get-EntraMSGroup -Id  } | Should -Throw "Missing an argument for parameter 'Id'.*"
        }
        It "Should return all group" {
            $result = Get-EntraMSGroup -All $true
            $result | Should -Not -BeNullOrEmpty            
            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraMSGroup -All "" } | Should -Throw "Cannot process argument transformation on parameter 'All'.*"
        }   
        It "Should fail when All is empty" {
            { Get-EntraMSGroup -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }           
        It "Should return specific group by searchstring" {
            $result = Get-EntraMSGroup -SearchString 'Demo Help Group'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Demo Help Group'
            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when searchstring is empty" {
            { Get-EntraMSGroup -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'.*"
        } 
        It "Should return specific group by filter" {
            $result = Get-EntraMSGroup -Filter "DisplayName -eq 'Demo Help Group'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Demo Help Group'
            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should fail when Filter is empty" {
            { Get-EntraMSGroup -Filter } | Should -Throw "Missing an argument for parameter 'Filter'.*"
        } 
        It "Should return top group" {
            $result = Get-EntraMSGroup -Top 1
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should fail when Top is invalid" {
            { Get-EntraMSGroup -Top "xyz" } | Should -Throw "Cannot process argument transformation on parameter 'Top'.*"
        }   
        It "Should fail when Top is empty" {
            { Get-EntraMSGroup -Top } | Should -Throw "Missing an argument for parameter 'Top'.*"
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraMSGroup -Id "0428af4d-9850-4c6c-88f1-4576dbf70281"
            $result.ObjectId | should -Be "0428af4d-9850-4c6c-88f1-4576dbf70281"
        } 
        It "Should contain GroupId in parameters when passed Id to it" {
            Mock -CommandName Get-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            $result = Get-EntraMSGroup -Id "0428af4d-9850-4c6c-88f1-4576dbf70281"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "0428af4d-9850-4c6c-88f1-4576dbf70281"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {
            Mock -CommandName Get-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            $result = Get-EntraMSGroup -SearchString 'Demo Help Group'
            $params = Get-Parameters -data $result
            $params.Filter | Should -Match "Demo Help Group"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSGroup"
            $result = Get-EntraMSGroup -Id "0428af4d-9850-4c6c-88f1-4576dbf70281"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }    
}