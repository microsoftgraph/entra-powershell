BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaUserManagerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Remove-EntraBetaUserManager" {
    Context "Test for Remove-EntraBetaUserManager" {
        It "Should return empty object" {
            $result = Remove-EntraBetaUserManager -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $result | Should -BeNullOrEmpty
            Should -Invoke -CommandName Remove-MgBetaUserManagerByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraBetaUserManager -ObjectId "" } | Should -Throw "Cannot bind argument to parameter*"
        }   
        It "Should fail when invalid parameter is passed" {
            { Remove-EntraBetaUserManager -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }
        It "Should contain UserId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgBetaUserManagerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
            
            $result = Remove-EntraBetaUserManager -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $params = Get-Parameters -data $result
            $params.UserId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgBetaUserManagerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaUserManager"
            $result = Remove-EntraBetaUserManager -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}