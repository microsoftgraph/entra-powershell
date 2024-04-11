BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        # Write-Host "Mocking Get-MgDirectoryAdministrativeUnitScopedRoleMember with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{                
                "RoleMemberInfo"       = @{DisplayName="Raul Razo"; Id="97d57292-02b9-4360-afb9-058268b77754"; AdditionalProperties={}}
                "AdministrativeUnitId" = "c9ab56cc-e349-4237-856e-cab03157a91e"
                "Id"                   = "zTVcE8KFQ0W4bI9tvt6kz5G_C9Qom7tCpCzyrakzL7aSctWXuQJgQ6-5BYJot3dUU"
                "RoleId"               = "526b7173-5a6e-49dc-88ec-b677a9093709"
                "AdditionalProperties" = {}
            }
        )
    }

    Mock -CommandName Get-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraMSScopedRoleMembership" {
    Context "Test for Get-EntraMSScopedRoleMembership" { 
        It "Should not return empty object"{
            $result = Get-EntraMSScopedRoleMembership -Id "c9ab56cc-e349-4237-856e-cab03157a91e"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryAdministrativeUnitScopedRoleMember -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should return specific scoped role membership"{
            $result = Get-EntraMSScopedRoleMembership -Id "c9ab56cc-e349-4237-856e-cab03157a91e" -ScopedRoleMembershipId "526b7173-5a6e-49dc-88ec-b677a9093709"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "zTVcE8KFQ0W4bI9tvt6kz5G_C9Qom7tCpCzyrakzL7aSctWXuQJgQ6-5BYJot3dUU"

            Should -Invoke -CommandName Get-MgDirectoryAdministrativeUnitScopedRoleMember -ModuleName Microsoft.Graph.Entra -Times 1
        }       
        It "Should fail when parameters are empty" {
            { Get-EntraMSScopedRoleMembership -Id "" -ScopedRoleMembershipId "" } | Should -Throw "Cannot bind argument to parameter*"
        }
        # It "Should contain AdministrativeUnitId in parameters when passed Id to it" {              
        #     Mock -CommandName Get-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {$args} -ModuleName Microsoft.Graph.Entra

        #     $result = Get-EntraMSScopedRoleMembership -Id "c9ab56cc-e349-4237-856e-cab03157a91e" -ScopedRoleMembershipId "526b7173-5a6e-49dc-88ec-b677a9093709" -RoleMemberInfo $RoleMember
        #     $params = Get-Parameters -data $result
        #     $params.AdministrativeUnitId | Should -Be "c9ab56cc-e349-4237-856e-cab03157a91e"
        # }
        # It "Should contain 'User-Agent' header" {
        #     Mock -CommandName Get-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {$args} -ModuleName Microsoft.Graph.Entra

        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSScopedRoleMembership"

        #     $result = Get-EntraMSScopedRoleMembership -Id "c9ab56cc-e349-4237-856e-cab03157a91e" -ScopedRoleMembershipId "526b7173-5a6e-49dc-88ec-b677a9093709" -RoleMemberInfo $RoleMember
        #     $params = Get-Parameters -data $result
        #     $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        # }
    }
}