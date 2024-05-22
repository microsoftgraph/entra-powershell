BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking New-MgServicePrincipalAppRoleAssignment with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{                
                "DeletedDateTime"              = $null
                "Id"                           = "gsx_zBushUevRyyjtwUohm_RMYjcGsJIjXwKOVMr3ww"
                "PrincipalDisplayName"         = "Mock-App"
                "AppRoleId"                    = "e18f0405-fdec-4ae8-a8a0-d8edb98b061f"
                "CreatedDateTime"              = "3/12/2024 11:05:29 AM"
                "PrincipalId"                  = "d2d0a585-0c52-4bab-8c64-a096b98b061f"
                "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgServicePrincipalAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraServiceAppRoleAssignment"{
    Context "Test for New-EntraServiceAppRoleAssignment" {
        It "Should return EntraServiceAppRoleAssignment"{
            $result = New-EntraServiceAppRoleAssignment -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -ResourceId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -Id "e18f0405-fdec-4ae8-a8a0-d8edb98b061f" -PrincipalId "d2d0a585-0c52-4bab-8c64-a096b98b061f"
            $result | Should -Not -BeNullOrEmpty
            $result.PrincipalDisplayName | should -Be "Mock-App"
            $result.PrincipalId | should -Be "d2d0a585-0c52-4bab-8c64-a096b98b061f"

            Should -Invoke -CommandName New-MgServicePrincipalAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { New-EntraServiceAppRoleAssignment -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is null" {
            { New-EntraServiceAppRoleAssignment -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ResourceId is empty" {
            { New-EntraServiceAppRoleAssignment -ResourceId "" } | Should -Throw "Cannot bind argument to parameter 'ResourceId'*"
        }
        It "Should fail when ResourceId is null" {
            { New-EntraServiceAppRoleAssignment -ResourceId } | Should -Throw "Missing an argument for parameter 'ResourceId'*"
        }
        It "Should fail when Id is empty" {
            { New-EntraServiceAppRoleAssignment -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
        }
        It "Should fail when Id is null" {
            { New-EntraServiceAppRoleAssignment -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when PrincipalId is empty" {
            { New-EntraServiceAppRoleAssignment -PrincipalId "" } | Should -Throw "Cannot bind argument to parameter 'PrincipalId'*"
        }
        It "Should fail when PrincipalId is null" {
            { New-EntraServiceAppRoleAssignment -PrincipalId } | Should -Throw "Missing an argument for parameter 'PrincipalId'*"
        }
        It "Should fail when invalid parameter is passed" {
            { New-EntraServiceAppRoleAssignment -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'."
        }
        It "Should contain AppRoleId in parameters when passed Id to it" {    
            $result = New-EntraServiceAppRoleAssignment -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -ResourceId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -Id "e18f0405-fdec-4ae8-a8a0-d8edb98b061f" -PrincipalId "d2d0a585-0c52-4bab-8c64-a096b98b061f"
            $params = Get-Parameters -data $result.Parameters
            $params.AppRoleId | Should -Be "e18f0405-fdec-4ae8-a8a0-d8edb98b061f"
        }
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {    
            $result = New-EntraServiceAppRoleAssignment -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -ResourceId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -Id "e18f0405-fdec-4ae8-a8a0-d8edb98b061f" -PrincipalId "d2d0a585-0c52-4bab-8c64-a096b98b061f"
            $params = Get-Parameters -data $result.Parameters
            $params.ServicePrincipalId | Should -Be "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraServiceAppRoleAssignment"
            $result = New-EntraServiceAppRoleAssignment -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -ResourceId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -Id "e18f0405-fdec-4ae8-a8a0-d8edb98b061f" -PrincipalId "d2d0a585-0c52-4bab-8c64-a096b98b061f"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}