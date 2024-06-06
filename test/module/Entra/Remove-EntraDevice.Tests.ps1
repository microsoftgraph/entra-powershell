BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgDevice -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraDevice" {
    Context "Test for Remove-EntraDevice" {
        It "Should return empty object" {
            $result = Remove-EntraDevice -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDevice -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is invalid" {
            { Remove-EntraDevice -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ObjectId is empty" {
            { Remove-EntraDevice -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }   
        It "Should contain DeviceId in parameters when passed ObjectId to it" {
            Mock -CommandName Remove-MgDevice -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraDevice -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.DeviceId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgDevice -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDevice"

            $result = Remove-EntraDevice -ObjectId bbbbbbbb-1111-2222-3333-cccccccccccc
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}