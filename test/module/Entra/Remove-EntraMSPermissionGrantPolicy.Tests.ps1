BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module .\test\module\Common-Functions.ps1 -Force

    Mock -CommandName Remove-MgPolicyPermissionGrantPolicy -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraMSPermissionGrantPolicy" {
    Context "Test for Remove-EntraMSPermissionGrantPolicy" {
        It "Should return empty object" {
            $result = Remove-EntraMSPermissionGrantPolicy -Id "0f0125ee-d1b7-4285-9124-657009f38219"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgPolicyPermissionGrantPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Remove-EntraMSPermissionGrantPolicy -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        } 
        It "Should fail when Id is invalid" {
            { Remove-EntraMSPermissionGrantPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string*"
        }
        It "Should contain PermissionGrantPolicyId in parameters when passed Id to it" {
            Mock -CommandName Remove-MgPolicyPermissionGrantPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraMSPermissionGrantPolicy -Id "0f0125ee-d1b7-4285-9124-657009f38219"
            $params = Get-Parameters -data $result
            $params.PermissionGrantPolicyId | Should -Be "0f0125ee-d1b7-4285-9124-657009f38219"
        }   
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Remove-MgPolicyPermissionGrantPolicy -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraMSPermissionGrantPolicy"

            $result = Remove-EntraMSPermissionGrantPolicy -Id "0f0125ee-d1b7-4285-9124-657009f38219"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}