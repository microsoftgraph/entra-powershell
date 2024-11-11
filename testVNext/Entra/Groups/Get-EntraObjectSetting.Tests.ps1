# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra.Groups) -eq $null) {
        Import-Module Microsoft.Graph.Entra.Groups        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\build\Common-Functions.ps1") -Force

    $scriptblock = {
        # Write-Host "Mocking Get-EntraObjectSetting with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                id    = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                displayName       = 'Group.Unified.Guest'
                values     = @{value=$false; name="AllowToAddGuests"}
                templateId   = "bbbbbbbb-1111-2222-3333-cccccccccaaa"
            }
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Groups
}

Describe "Get-EntraObjectSetting" {
    Context "Test for Get-EntraObjectSetting" {
        It "Should return specific Object Setting" {
            $result = Get-EntraObjectSetting -TargetType "Groups" -TargetObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccccc'
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Groups -Times 1
        }        
        It "Should fail when TargetType is empty" {
            { Get-EntraObjectSetting -TargetType } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }               
        It "Should fail when Top is empty" {
            { Get-EntraObjectSetting -TargetType "Groups" -TargetObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraObjectSetting -TargetType "Groups" -TargetObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return all Object Setting" {
            $result = Get-EntraObjectSetting -TargetType "Groups" -TargetObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -All 
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Groups -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraObjectSetting -TargetType "Groups" -TargetObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }
        It "Should return top Object Setting" {
            $result = @(Get-EntraObjectSetting -TargetType "Groups" -TargetObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Top 1)
            $result | Should -Not -BeNullOrEmpty
            $result | Should -HaveCount 1
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Groups -Times 1
        }
        It "Should contain ID in parameters when passed TargetType TargetObjectId to it" {
            $result = Get-EntraObjectSetting -TargetType "Groups" -TargetObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraObjectSetting"
            $result = Get-EntraObjectSetting -TargetType "Groups" -TargetObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraObjectSetting"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Groups -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraObjectSetting -TargetType "Groups" -TargetObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
        It "Should contain property when passed property to it" {
            $result = Get-EntraObjectSetting -TargetType "Groups" -TargetObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Property DisplayName
            $result.displayName | Should -Not -BeNullOrEmpty
        }
    }
}