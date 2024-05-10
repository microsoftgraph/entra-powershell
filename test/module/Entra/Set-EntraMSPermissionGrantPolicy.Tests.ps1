BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    Mock -CommandName Update-MgPolicyPermissionGrantPolicy -MockWith {} -ModuleName Microsoft.Graph.Entra
}
  
Describe "Set-EntraMSPermissionGrantPolicy" {
    Context "Test for Set-EntraMSPermissionGrantPolicy" {
        It "Should return updated PermissionGrantPolicy" {
            $result = Set-EntraMSPermissionGrantPolicy -Id "permission_grant_policy" -Description "test" -DisplayName "Test" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgPolicyPermissionGrantPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Set-EntraMSPermissionGrantPolicy -Id  -Description "test" -DisplayName "Test"  } | Should -Throw "Missing an argument for parameter 'Id'.*"
        }
        It "Should fail when Id is invalid" {
            { Set-EntraMSPermissionGrantPolicy -Id "" -Description "test" -DisplayName "Test"  } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        } 
        It "Should fail when Description is empty" {
            { Set-EntraMSPermissionGrantPolicy -Id "permission_grant_policy" -Description -DisplayName "Test"  } | Should -Throw "Missing an argument for parameter 'Description'.*"
        }
        It "Should fail when DisplayName is empty" {
            { Set-EntraMSPermissionGrantPolicy -Id "permission_grant_policy" -Description "test" -DisplayName  } | Should -Throw "Missing an argument for parameter 'DisplayName'.*"
        } 
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgPolicyPermissionGrantPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraMSPermissionGrantPolicy"

            $result = Set-EntraMSPermissionGrantPolicy -Id "permission_grant_policy" -Description "test" -DisplayName "Test" 
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}