BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Set-MgBetaUserManagerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaUserManager"{
    Context "Test for Set-EntraBetaUserManager" {
        It "Should return empty object"{
            $result = Set-EntraBetaUserManager -ObjectId '056b2531-005e-4f3e-be78-01a71ea30a04' -RefObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf"
            $result | Should -BeNullOrEmpty 
            Should -Invoke -CommandName Set-MgBetaUserManagerByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraBetaUserManager -ObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when invalid parameter is passed" {
            { Set-EntraBetaUserManager -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }
        It "Should contain UserId in parameters when passed ObjectId to it" {
            Mock -CommandName Set-MgBetaUserManagerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Set-EntraBetaUserManager -ObjectId '056b2531-005e-4f3e-be78-01a71ea30a04' -RefObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf"
            $params = Get-Parameters -data $result
            $params.UserId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Set-MgBetaUserManagerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUserManager"
            $result = Set-EntraBetaUserManager -ObjectId '056b2531-005e-4f3e-be78-01a71ea30a04' -RefObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}