BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraMSDeletedDirectoryObject" {
    Context "Test for Remove-EntraMSDeletedDirectoryObject" {
        It "Should return empty id" {
            $result = Remove-EntraMSDeletedDirectoryObject -Id "c28ccec8-4c7e-43b8-a4a1-558d93eda04e"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraMSDeletedDirectoryObject -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraMSDeletedDirectoryObject -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Invoke-GraphRequest -MockWith { $args } -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSDeletedDirectoryObject"
            $result = Remove-EntraMSDeletedDirectoryObject -Id "c28ccec8-4c7e-43b8-a4a1-558d93eda04e"
            $params = Get-Parameters -data $result
            $userAgent= $params | ConvertTo-json | ConvertFrom-Json
            $userAgent.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }  
    }
}