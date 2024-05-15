BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Parameters"      = $args
            }
        )
    }  
    Mock -CommandName Remove-MgBetaGroupOwnerByRef -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaGroupOwner" {
    Context "Test for Remove-EntraBetaGroupOwner" {
        It "Should return empty object" {
            $result = Remove-EntraBetaGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -OwnerId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroupOwnerByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraBetaGroupOwner -ObjectId -OwnerId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   

        It "Should fail when ObjectId is invalid" {
            { Remove-EntraBetaGroupOwner -ObjectId "" -OwnerId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should fail when OwnerId is empty" {
            { Remove-EntraBetaGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -OwnerId } | Should -Throw "Missing an argument for parameter 'OwnerId'*"
        }   

        It "Should fail when OwnerId is invalid" {
            { Remove-EntraBetaGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -OwnerId ""} | Should -Throw "Cannot bind argument to parameter 'OwnerId' because it is an empty string."
        }   

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            $result = Remove-EntraBetaGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -OwnerId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupId | Should -Be "fe4619d9-9ce7-4141-a367-ec10f3fb8af4"
        }

        It "Should contain DirectoryObjectId in parameters when passed OwnerId to it" {
            $result = Remove-EntraBetaGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -OwnerId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result.Parameters
            $params.DirectoryObjectId | Should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaGroupOwner"
            $result = Remove-EntraBetaGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -OwnerId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}