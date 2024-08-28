BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module .\test\module\Common-Functions.ps1 -Force

    Mock -CommandName Remove-MgGroupAppRoleAssignment -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraGroupAppRoleAssignment" {
    Context "Test for Remove-EntraGroupAppRoleAssignment" {
        It "Should return empty object" {
            $result = Remove-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8" -AppRoleAssignmentId "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgGroupAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraGroupAppRoleAssignment -ObjectId  -AppRoleAssignmentId "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU" } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }  
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraGroupAppRoleAssignment -ObjectId "" -AppRoleAssignmentId "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when AppRoleAssignmentId is empty" {
            { Remove-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8"  -AppRoleAssignmentId  } | Should -Throw "Missing an argument for parameter 'AppRoleAssignmentId'*"
        }  
        It "Should fail when AppRoleAssignmentId is invalid" {
            { Remove-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8" -AppRoleAssignmentId "" } | Should -Throw "Cannot bind argument to parameter 'AppRoleAssignmentId' because it is an empty string."
        }
        It "Should contain GroupId in parameters when passed ObjectId to it" { 
            Mock -CommandName Remove-MgGroupAppRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8" -AppRoleAssignmentId "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "524b5373-7121-4e66-9c3f-a363d11a08c8"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgGroupAppRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroupAppRoleAssignment"

            $result = Remove-EntraGroupAppRoleAssignment -ObjectId "524b5373-7121-4e66-9c3f-a363d11a08c8" -AppRoleAssignmentId "c1NLUiFxZk6cP6Nj0RoIyGV2homdrcZNnMeMGgMswmU"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}