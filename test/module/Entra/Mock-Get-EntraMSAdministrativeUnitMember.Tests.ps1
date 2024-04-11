BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-MgDirectoryAdministrativeUnitMember with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "DeletedDateTime"      = $null
                "Id"                   = "d67d8b7b-57e1-486e-9361-26a1e2f0e8fe"
                "AdditionalProperties" = @{displayName="Tests1";givenName="Tests1"}
            }
        )
    }

    Mock -CommandName Get-MgDirectoryAdministrativeUnitMember -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraMSAdministrativeUnitMember" {
    Context "Test for Get-EntraMSAdministrativeUnitMember" {
        It "Should return administrative unit member" {
            $result = Get-EntraMSAdministrativeUnitMember -Id "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106"
            $result | Should -Not -BeNullOrEmpty            

            Should -Invoke -CommandName Get-MgDirectoryAdministrativeUnitMember  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraMSAdministrativeUnitMember -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should return all administrative units" {
            $result = Get-EntraMSAdministrativeUnitMember -Id "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106" -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgDirectoryAdministrativeUnitMember  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraMSAdministrativeUnitMember -Id "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106" -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }
        It "Should return top administrative unit" {
            $result = Get-EntraMSAdministrativeUnitMember -Id "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryAdministrativeUnitMember  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraMSAdministrativeUnitMember -Id "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106" -Top 1
            $result.ObjectId | should -Be "d67d8b7b-57e1-486e-9361-26a1e2f0e8fe"
        }     
        It "Should contain AdministrativeUnitId in parameters when passed ObjectId to it" {              
            Mock -CommandName Get-MgDirectoryAdministrativeUnitMember -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Get-EntraMSAdministrativeUnitMember -Id "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106"
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Get-MgDirectoryAdministrativeUnitMember -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSAdministrativeUnitMember"

            $result = Get-EntraMSAdministrativeUnitMember -Id "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}