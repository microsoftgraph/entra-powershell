BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgDevice -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraDevice"{
    Context "Test for Set-EntraDevice" {
        It "Should return empty object"{
            $result = Set-EntraDevice -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04 -DisplayName "Mock-App" -AccountEnabled $true
            $result | Should -BeNullOrEmpty           

            Should -Invoke -CommandName Update-MgDevice -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is invalid" {
            { Set-EntraDevice -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ObjectId is empty" {
            { Set-EntraDevice -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should contain DeviceId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgDevice -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraDevice -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $params = Get-Parameters -data $result
            $params.DeviceId | Should -Be "056b2531-005e-4f3e-be78-01a71ea30a04"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgDevice -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraDevice"

            $result = Set-EntraDevice -ObjectId 056b2531-005e-4f3e-be78-01a71ea30a04
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}