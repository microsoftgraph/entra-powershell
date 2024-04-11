BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force


    $scriptblock = {
        # Write-Host "Mocking New-MgDirectoryAdministrativeUnitScopedRoleMember with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "Id"                    = "412be9d1-1460-4061-8eed-cca203fcb215"
                "AdministrativeUnitId"  = "c9ab56cc-e349-4237-856e-cab03157a91e"
                "RoleId"                = "526b7173-5a6e-49dc-88ec-b677a9093709"
            }
        )
    }

    Mock -CommandName New-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra

    $RoleMember = New-Object -TypeName Microsoft.Open.MSGraph.Model.MsRolememberinfo
    $RoleMember.Id = "96d4258f-9187-4e6c-b031-724e789b9323"
}
  
Describe "Add-EntraMSScopedRoleMembership" {
    Context "Test for Add-EntraMSScopedRoleMembership" { 
        It "Should not return empty object"{
            $result = Add-EntraMSScopedRoleMembership -Id "c9ab56cc-e349-4237-856e-cab03157a91e" -RoleId "526b7173-5a6e-49dc-88ec-b677a9093709" -RoleMemberInfo $RoleMember
            $result | Should -Not -BeNullOrEmpty 
            $result.Id | should -Be @('412be9d1-1460-4061-8eed-cca203fcb215')          

            Should -Invoke -CommandName New-MgDirectoryAdministrativeUnitScopedRoleMember -ModuleName Microsoft.Graph.Entra -Times 1
        }       
        It "Should fail when parameters are empty" {
            { Add-EntraMSScopedRoleMembership -Id "" -RoleId "" } | Should -Throw "Cannot bind argument to parameter*"
        }
        It "Should contain AdministrativeUnitId in parameters when passed Id to it" {              
            Mock -CommandName New-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Add-EntraMSScopedRoleMembership -Id "c9ab56cc-e349-4237-856e-cab03157a91e" -RoleId "526b7173-5a6e-49dc-88ec-b677a9093709" -RoleMemberInfo $RoleMember
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "c9ab56cc-e349-4237-856e-cab03157a91e"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgDirectoryAdministrativeUnitScopedRoleMember -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraMSScopedRoleMembership"

            $result = Add-EntraMSScopedRoleMembership -Id "c9ab56cc-e349-4237-856e-cab03157a91e" -RoleId "526b7173-5a6e-49dc-88ec-b677a9093709" -RoleMemberInfo $RoleMember
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}