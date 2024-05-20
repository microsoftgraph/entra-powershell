BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Parameters"      = $args
            }
        )
    }  
    Mock -CommandName Remove-MgDirectoryDeletedItem -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraDeletedApplication" {
    Context "Test for Remove-EntraDeletedApplication" {
        It "Should return empty object" {
            $result = Remove-EntraDeletedApplication -ObjectId "c28ccec8-4c7e-43b8-a4a1-558d93eda04e"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDirectoryDeletedItem -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraDeletedApplication -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   

        It "Should fail when ObjectId is invalid" {
            { Remove-EntraDeletedApplication -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should contain DirectoryObjectId in parameters when passed ObjectId to it" {
            $result = Remove-EntraDeletedApplication -ObjectId "c28ccec8-4c7e-43b8-a4a1-558d93eda04e"
            $params = Get-Parameters -data $result.Parameters
            $params.DirectoryObjectId | Should -Be "c28ccec8-4c7e-43b8-a4a1-558d93eda04e"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDeletedApplication"

            $result = Remove-EntraDeletedApplication -ObjectId "c28ccec8-4c7e-43b8-a4a1-558d93eda04e"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}