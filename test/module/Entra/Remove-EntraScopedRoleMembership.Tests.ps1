BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Test for Remove-EntraScopedRoleMembership" {
    It "Should return empty object" {
        $result = Remove-EntraScopedRoleMembership -ObjectId bbbbbbbb-1111-1111-1111-cccccccccccc -ScopedRoleMembershipId bbbbbbbb-2222-2222-2222-cccccccccccc
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Remove-EntraScopedRoleMembership -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is null" {
        { Remove-EntraScopedRoleMembership -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    It "Should fail when ScopedRoleMembershipId is empty" {
        { Remove-EntraScopedRoleMembership -ScopedRoleMembershipId "" } | Should -Throw "Cannot bind argument to parameter 'ScopedRoleMembershipId'*"
    }
    It "Should fail when ScopedRoleMembershipId is null" {
        { Remove-EntraScopedRoleMembership -ScopedRoleMembershipId } | Should -Throw "Missing an argument for parameter 'ScopedRoleMembershipId'*"
    }   
    It "Should fail when invalid parameter is passed" {
        { Remove-EntraScopedRoleMembership -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraScopedRoleMembership"
        $result = Remove-EntraScopedRoleMembership -ObjectId bbbbbbbb-1111-1111-1111-cccccccccccc -ScopedRoleMembershipId bbbbbbbb-2222-2222-2222-cccccccccccc
        $params = Get-Parameters -data $result
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    } 
}