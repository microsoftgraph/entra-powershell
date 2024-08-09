BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module .\test\module\Common-Functions.ps1 -Force

    Mock -CommandName Remove-MgIdentityConditionalAccessNamedLocation -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraMSNamedLocationPolicy" {
    Context "Test for Remove-EntraMSNamedLocationPolicy" {
        It "Should return empty object" {
            $result = Remove-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgIdentityConditionalAccessNamedLocation -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when PolicyId is empty" {
            { Remove-EntraMSNamedLocationPolicy -PolicyId  } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        } 
        It "Should fail when PolicyId is invalid" {
            { Remove-EntraMSNamedLocationPolicy -PolicyId "" } | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string*"
        }
        It "Should contain NamedLocationId in parameters when passed PolicyId to it" {
            Mock -CommandName Remove-MgIdentityConditionalAccessNamedLocation -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219"
            $params = Get-Parameters -data $result
            $params.NamedLocationId | Should -Be "0f0125ee-d1b7-4285-9124-657009f38219"
        }   
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgIdentityConditionalAccessNamedLocation -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSNamedLocationPolicy"

            $result = Remove-EntraMSNamedLocationPolicy -PolicyId "0f0125ee-d1b7-4285-9124-657009f38219"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}