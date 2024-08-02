BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgGroupOwnerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraGroupOwner" {
    Context "Test for Remove-EntraGroupOwner" {
        It "Should remove an owner" {
            $result = Remove-EntraGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -OwnerId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgGroupOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraGroupOwner -ObjectId -OwnerId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   

        It "Should fail when ObjectId is invalid" {
            { Remove-EntraGroupOwner -ObjectId "" -OwnerId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should fail when OwnerId is empty" {
            { Remove-EntraGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -OwnerId } | Should -Throw "Missing an argument for parameter 'OwnerId'*"
        }   

        It "Should fail when OwnerId is invalid" {
            { Remove-EntraGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -OwnerId "" } | Should -Throw "Cannot bind argument to parameter 'OwnerId' because it is an empty string."
        }   

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgGroupOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -OwnerId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "fe4619d9-9ce7-4141-a367-ec10f3fb8af4"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgGroupOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraGroupOwner"
            $result = Remove-EntraGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -OwnerId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}