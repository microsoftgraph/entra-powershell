BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        #Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-MgDirectoryAdministrativeUnit with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "DeletedDateTime"      = $null
                "Description"          = "Mock-Unit"
                "DisplayName"          = "Mock-Unit"
                "Extensions"           = $null
                "Id"                   = "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106"
                "Members"              = $null
                "ScopedRoleMembers"    = $null
                "Visibility"           = $null
                "AdditionalProperties" = {}
            }
        )
    }

    Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraMSAdministrativeUnit" {
    Context "Test for Get-EntraMSAdministrativeUnit" {
        It "Should return specific application" {
            $result = Get-EntraMSAdministrativeUnit -Id "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('09cb73a9-6d82-4d4d-a9f5-9e7ba0329106')

            Should -Invoke -CommandName Get-MgDirectoryAdministrativeUnit  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraMSAdministrativeUnit -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should return all administrative units" {
            $result = Get-EntraMSAdministrativeUnit -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgDirectoryAdministrativeUnit  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraMSAdministrativeUnit -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }
        It "Should return specific administrative unit by filter" {
            $result = Get-EntraMSAdministrativeUnit -Filter "DisplayName -eq 'Mock-Unit'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-Unit'

            Should -Invoke -CommandName Get-MgDirectoryAdministrativeUnit  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should return top administrative unit" {
            $result = Get-EntraMSAdministrativeUnit -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryAdministrativeUnit  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraMSAdministrativeUnit -Id "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106"
            $result.ObjectId | should -Be "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106"
        }     
        It "Should contain AdministrativeUnitId in parameters when passed ObjectId to it" {              
            Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Get-EntraMSAdministrativeUnit -Id "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106"
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106"
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Get-MgDirectoryAdministrativeUnit -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSAdministrativeUnit"

            $result = Get-EntraMSAdministrativeUnit -Id "09cb73a9-6d82-4d4d-a9f5-9e7ba0329106"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}