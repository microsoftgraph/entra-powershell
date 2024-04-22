BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgRoleManagementDirectoryRoleDefinition -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraMSRoleDefinition" {
    Context "Test for Remove-EntraMSRoleDefinition" {
        It "Should return empty object" {
            $result = Remove-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgRoleManagementDirectoryRoleDefinition -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Remove-EntraMSRoleDefinition -Id   } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Remove-EntraMSRoleDefinition -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string*"
        }
        It "Should contain UnifiedRoleDefinitionId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgRoleManagementDirectoryRoleDefinition -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" 
            $params = Get-Parameters -data $result
            $params.UnifiedRoleDefinitionId | Should -Be "54d418b2-4cc0-47ee-9b39-e8f84ed8e073"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgRoleManagementDirectoryRoleDefinition -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSRoleDefinition"
            $result = Remove-EntraMSRoleDefinition -Id "54d418b2-4cc0-47ee-9b39-e8f84ed8e073" 
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}        