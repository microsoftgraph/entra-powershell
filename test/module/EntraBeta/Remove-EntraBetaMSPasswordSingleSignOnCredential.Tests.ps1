BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaMSPasswordSingleSignOnCredential" {
    Context "Test for Remove-EntraBetaMSPasswordSingleSignOnCredential" {
        It "Should remove password single-sign-on credentials" {
            $result = Remove-EntraBetaMSPasswordSingleSignOnCredential -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886"  -PasswordSSOObjectId "bbf5d921-bb52-434b-96a0-95888e44faf5"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Remove-EntraBetaMSPasswordSingleSignOnCredential -ObjectId   -PasswordSSOObjectId bbf5d921-bb52-434b-96a0-95888e44faf5 } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   

        It "Should fail when ObjectId is invalid" {
            { Remove-EntraBetaMSPasswordSingleSignOnCredential -ObjectId ""  -PasswordSSOObjectId bbf5d921-bb52-434b-96a0-95888e44faf5 } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }   

        It "Should fail when PasswordSSOObjectId is empty" {
            { Remove-EntraBetaMSPasswordSingleSignOnCredential -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886"  -PasswordSSOObjectId   } | Should -Throw "Missing an argument for parameter 'PasswordSSOObjectId'*"
        }   

        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaMSPasswordSingleSignOnCredential -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886"  -PasswordSSOObjectId "bbf5d921-bb52-434b-96a0-95888e44faf5"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "cc7fcc82-ac1b-4785-af47-2ca3b7052886"
        }

        It "Should contain Id in parameters when passed PasswordSSOObjectId to it" {
            Mock -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Remove-EntraBetaMSPasswordSingleSignOnCredential -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886"  -PasswordSSOObjectId "bbf5d921-bb52-434b-96a0-95888e44faf5"
            $params = Get-Parameters -data $result
            $params.Id | Should -Be "bbf5d921-bb52-434b-96a0-95888e44faf5"
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaMSPasswordSingleSignOnCredential"
            $result = Remove-EntraBetaMSPasswordSingleSignOnCredential -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886"  -PasswordSSOObjectId "bbf5d921-bb52-434b-96a0-95888e44faf5"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}