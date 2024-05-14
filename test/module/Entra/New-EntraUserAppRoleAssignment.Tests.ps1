BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        #Write-Host "Mocking New-EntraUserAppRoleAssignment with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                Id                   = "0ekrQWAUYUCO7cyiA_yyFc3fMlopKE9Is5pDwB7UEeM"
                AppRoleId            = "e18f0405-fdec-4ae8-a8a0-d8edb98b061f"
                CreatedDateTime      = "08-05-2024 11:26:59"
                DeletedDateTime      = $null
                PrincipalDisplayName = "Test One Updated"
                PrincipalId          = "bbf5d921-bb52-434b-96a0-95888e44faf5"
                PrincipalType        = "User"
                ResourceDisplayName  = "Box"
                ResourceId           = "cc7fcc82-ac1b-4785-af47-2ca3b7052886"
                AdditionalProperties = @(
                    @{
                        Name  = "@odata.context"
                        Value = "https://graph.microsoft.com/v1.0/$metadata#users('412be9d1-1460-4061-8eed-cca203fcb215')/appRoleAssignments/$entity"
                    }
                )
            }
        )
    }
    
    Mock -CommandName New-MgUserAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraUserAppRoleAssignment" {
    Context "Test for New-EntraUserAppRoleAssignment" {
        It "Should return created Group" {
            $expectedResult = @{
                Id                   = "0ekrQWAUYUCO7cyiA_yyFc3fMlopKE9Is5pDwB7UEeM"
                AppRoleId            = "e18f0405-fdec-4ae8-a8a0-d8edb98b061f"
                CreatedDateTime      = "08-05-2024 11:26:59"
                DeletedDateTime      = $null
                PrincipalDisplayName = "Test One Updated"
                PrincipalId          = "bbf5d921-bb52-434b-96a0-95888e44faf5"
                PrincipalType        = "User"
                ResourceDisplayName  = "Box"
                ResourceId           = "cc7fcc82-ac1b-4785-af47-2ca3b7052886"
                AdditionalProperties = @(
                    @{
                        Name  = "@odata.context"
                        Value = "https://graph.microsoft.com/v1.0/$metadata#users('412be9d1-1460-4061-8eed-cca203fcb215')/appRoleAssignments/$entity"
                    }
                )
            }

            $result = New-EntraUserAppRoleAssignment -ObjectId 'bbf5d921-bb52-434b-96a0-95888e44faf5' -PrincipalId 'bbf5d921-bb52-434b-96a0-95888e44faf5' -ResourceId 'cc7fcc82-ac1b-4785-af47-2ca3b7052886' -Id 'e18f0405-fdec-4ae8-a8a0-d8edb98b061f'
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be $expectedResult.Id
            $result.AppRoleId | Should -Be $expectedResult.AppRoleId
            $result.CreatedDateTime | Should -Be $expectedResult.CreatedDateTime
            $result.DeletedDateTime | Should -Be $expectedResult.DeletedDateTime
            $result.PrincipalDisplayName | Should -Be $expectedResult.PrincipalDisplayName
            $result.PrincipalId | Should -Be $expectedResult.PrincipalId
            $result.PrincipalType | Should -Be $expectedResult.PrincipalType
            $result.ResourceDisplayName | Should -Be $expectedResult.ResourceDisplayName
            $result.ResourceId | Should -Be $expectedResult.ResourceId

            Should -Invoke -CommandName New-MgUserAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when parameters are empty" {
            { New-EntraUserAppRoleAssignment -ObjectId  -PrincipalId  } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when parameters are Invalid values" {
            { New-EntraUserAppRoleAssignment -ObjectId ""  -PrincipalId ""  } | Should -Throw "Cannot bind argument to parameter*"
        }

        It "Should contain UserId in parameters" {
            Mock -CommandName New-MgUserAppRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraUserAppRoleAssignment"
            $result = New-EntraUserAppRoleAssignment -ObjectId 'bbf5d921-bb52-434b-96a0-95888e44faf5' -PrincipalId 'bbf5d921-bb52-434b-96a0-95888e44faf5' -ResourceId 'cc7fcc82-ac1b-4785-af47-2ca3b7052886' -Id 'e18f0405-fdec-4ae8-a8a0-d8edb98b061f'
            $params = Get-Parameters -data $result

            $params.UserId | Should -Match "bbf5d921-bb52-434b-96a0-95888e44faf5"
        }
        
        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgUserAppRoleAssignment -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraUserAppRoleAssignment"
            $result = New-EntraUserAppRoleAssignment -ObjectId 'bbf5d921-bb52-434b-96a0-95888e44faf5' -PrincipalId 'bbf5d921-bb52-434b-96a0-95888e44faf5' -ResourceId 'cc7fcc82-ac1b-4785-af47-2ca3b7052886' -Id 'e18f0405-fdec-4ae8-a8a0-d8edb98b061f'
            
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   

    }
}