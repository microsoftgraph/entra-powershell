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
    Mock -CommandName Remove-MgBetaGroupLifecyclePolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaMSGroupLifecyclePolicy" {
    Context "Test for Remove-EntraBetaMSGroupLifecyclePolicy" {
        It "Should return empty Id" {
            $result = Remove-EntraBetaMSGroupLifecyclePolicy -Id "a47d4510-08c8-4437-99e9-71ca88e7af0f"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaGroupLifecyclePolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaMSGroupLifecyclePolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaMSGroupLifecyclePolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }  

        It "Should contain GroupLifecyclePolicyId in parameters when passed Id to it" {
            $result = Remove-EntraBetaMSGroupLifecyclePolicy -Id "a47d4510-08c8-4437-99e9-71ca88e7af0f"
            $params = Get-Parameters -data $result.Parameters
            $params.GroupLifecyclePolicyId | Should -Be "a47d4510-08c8-4437-99e9-71ca88e7af0f"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaMSGroupLifecyclePolicy"

            $result = Remove-EntraBetaMSGroupLifecyclePolicy -Id "a47d4510-08c8-4437-99e9-71ca88e7af0f"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}