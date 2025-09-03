# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
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
                        Value = "https://graph.microsoft.com/v1.0/`$metadata#users('aaaa0000-bb11-2222-33cc-444444dddddd')/appRoleAssignments/`$entity"
                    }
                )
            }
        )
    }
    
    Mock -CommandName New-MgUserAppRoleAssignment -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("AppRoleAssignment.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users
}
  
Describe "New-EntraUserAppRoleAssignment" {
    Context "Test for New-EntraUserAppRoleAssignment" {
        It "should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
            { New-EntraUserAppRoleAssignment -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -PrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222' -ResourceId 'bbbbbbbb-cccc-dddd-2222-333333333333' -AppRoleId '00aa00aa-bb11-cc22-dd33-44ee44ee44ee' } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName New-MgUserAppRoleAssignment -ModuleName Microsoft.Entra.Users -Times 0
        }

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
                        Value = "https://graph.microsoft.com/v1.0/`$metadata#users('aaaa0000-bb11-2222-33cc-444444dddddd')/appRoleAssignments/`$entity"
                    }
                )
            }

            $result = New-EntraUserAppRoleAssignment -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -PrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222' -ResourceId 'bbbbbbbb-cccc-dddd-2222-333333333333' -AppRoleId '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
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

            Should -Invoke -CommandName New-MgUserAppRoleAssignment -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when parameters are empty" {
            { New-EntraUserAppRoleAssignment -UserId -PrincipalId } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when parameters are Invalid values" {
            { New-EntraUserAppRoleAssignment -UserId "" -PrincipalId "" } | Should -Throw "Cannot process argument transformation on parameter 'UserId'. Cannot convert value*"
        }

        It "Should contain UserId in parameters" {
            Mock -CommandName New-MgUserAppRoleAssignment -MockWith { $args } -ModuleName Microsoft.Entra.Users

            $result = New-EntraUserAppRoleAssignment -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -PrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222' -ResourceId 'bbbbbbbb-cccc-dddd-2222-333333333333' -AppRoleId '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $params = Get-Parameters -data $result

            $params.UserId | Should -Match "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraUserAppRoleAssignment"

            $result = New-EntraUserAppRoleAssignment -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -PrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222' -ResourceId 'bbbbbbbb-cccc-dddd-2222-333333333333' -AppRoleId '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraUserAppRoleAssignment"

            Should -Invoke -CommandName New-MgUserAppRoleAssignment -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { New-EntraUserAppRoleAssignment -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -PrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222' -ResourceId 'bbbbbbbb-cccc-dddd-2222-333333333333' -AppRoleId '00aa00aa-bb11-cc22-dd33-44ee44ee44ee' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

