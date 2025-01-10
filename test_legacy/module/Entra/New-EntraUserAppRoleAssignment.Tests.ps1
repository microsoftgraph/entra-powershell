# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        #Write-Host "Mocking New-EntraUserAppRoleAssignment with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                Id                   = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                AppRoleId            = "44445555-eeee-6666-ffff-7777aaaa8888"
                CreatedDateTime      = "08-05-2024 11:26:59"
                DeletedDateTime      = $null
                PrincipalDisplayName = "Test One Updated"
                PrincipalId          = "aaaaaaaa-bbbb-cccc-1111-222222222222"
                PrincipalType        = "User"
                ResourceDisplayName  = "Box"
                ResourceId           = "bbbbbbbb-cccc-dddd-2222-333333333333"
                AdditionalProperties = @(
                    @{
                        Name  = "@odata.context"
                        Value = "https://graph.microsoft.com/v1.0/$metadata#users('aaaa0000-bb11-2222-33cc-444444dddddd')/appRoleAssignments/$entity"
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
                Id                   = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                AppRoleId            = "44445555-eeee-6666-ffff-7777aaaa8888"
                CreatedDateTime      = "08-05-2024 11:26:59"
                DeletedDateTime      = $null
                PrincipalDisplayName = "Test One Updated"
                PrincipalId          = "aaaaaaaa-bbbb-cccc-1111-222222222222"
                PrincipalType        = "User"
                ResourceDisplayName  = "Box"
                ResourceId           = "bbbbbbbb-cccc-dddd-2222-333333333333"
                AdditionalProperties = @(
                    @{
                        Name  = "@odata.context"
                        Value = "https://graph.microsoft.com/v1.0/$metadata#users('aaaa0000-bb11-2222-33cc-444444dddddd')/appRoleAssignments/$entity"
                    }
                )
            }

            $result = New-EntraUserAppRoleAssignment -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -PrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222' -ResourceId 'bbbbbbbb-cccc-dddd-2222-333333333333' -Id '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
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

            $result =  New-EntraUserAppRoleAssignment -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -PrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222' -ResourceId 'bbbbbbbb-cccc-dddd-2222-333333333333' -Id '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $params = Get-Parameters -data $result

            $params.UserId | Should -Match "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraUserAppRoleAssignment"

            $result = New-EntraUserAppRoleAssignment -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -PrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222' -ResourceId 'bbbbbbbb-cccc-dddd-2222-333333333333' -Id '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraUserAppRoleAssignment"

            Should -Invoke -CommandName New-MgUserAppRoleAssignment -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 

        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                {  New-EntraUserAppRoleAssignment -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -PrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222' -ResourceId 'bbbbbbbb-cccc-dddd-2222-333333333333' -Id '00aa00aa-bb11-cc22-dd33-44ee44ee44ee' -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}