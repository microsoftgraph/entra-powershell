BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-EntraGroup with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "DisplayName"     = "demo"
              "Id"              = "056b2531-005e-4f3e-be78-01a71ea30a04"
              "MailEnabled"     = "False"
              "Description"     = "test"
              "MailNickname"    = "demoNickname"
              "SecurityEnabled" = "True"
            }
        )
    }

    Mock -CommandName Get-MgGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraGroup" {
    Context "Test for Get-EntraGroup" {
        It "Should return specific group" {
            $result = Get-EntraGroup -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '056b2531-005e-4f3e-be78-01a71ea30a04'

            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraGroup -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraGroup -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when searchstring is empty" {
            { Get-EntraGroup -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        } 
        It "Should fail when filter is empty" {
            { Get-EntraGroup -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should fail when filter is empty" {
            { Get-EntraGroup -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when filter is invalid" {
            { Get-EntraGroup -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return all group" {
            $result = Get-EntraGroup -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraGroup -All $true} | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }           
        It "Should return specific group by searchstring" {
            $result = Get-EntraGroup -SearchString 'demo'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'demo'

            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        } 
        It "Should return specific group by filter" {
            $result = Get-EntraGroup -Filter "DisplayName -eq 'demo'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'demo'

            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should return top group" {
            $result = @(Get-EntraGroup -Top 1)
            $result | Should -Not -BeNullOrEmpty
            $result | Should -HaveCount 1 

            Should -Invoke -CommandName Get-MgGroup  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraGroup -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04"
            $result.ObjectId | should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        } 
        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName Get-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Get-EntraGroup -ObjectId "056b2531-005e-4f3e-be78-01a71ea30a04"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {
            Mock -CommandName Get-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Get-EntraGroup -SearchString 'demo'
            $params = Get-Parameters -data $result
            $params.Filter | Should -Match "demo"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Get-MgGroup -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraGroup"

            $result = Get-EntraGroup -SearchString 'demo'
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }    
    }
}