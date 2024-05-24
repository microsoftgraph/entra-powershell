BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaTrustFrameworkPolicy -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaMSTrustFrameworkPolicy" {
    Context "Test for Remove-EntraBetaMSTrustFrameworkPolicy" {
        It "Should delete a trust framework policy in the directory" {
            $result = Remove-EntraBetaMSTrustFrameworkPolicy -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaTrustFrameworkPolicy -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Remove-EntraBetaMSTrustFrameworkPolicy -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }   

        It "Should fail when Id is invalid" {
            { Remove-EntraBetaMSTrustFrameworkPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }   

        It "Should contain TrustFrameworkPolicyId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgBetaTrustFrameworkPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaMSTrustFrameworkPolicy -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9"
            $params = Get-Parameters -data $result
            $params.TrustFrameworkPolicyId | Should -Be "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgBetaTrustFrameworkPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaMSTrustFrameworkPolicy"
            $result = Remove-EntraBetaMSTrustFrameworkPolicy -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}