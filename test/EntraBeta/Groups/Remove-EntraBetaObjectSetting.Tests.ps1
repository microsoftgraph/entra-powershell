# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Groups) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Groups       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Groups
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.Read.All") } } -ModuleName Microsoft.Entra.Beta.Groups
}
Describe "Remove-EntraBetaObjectSetting" {
    Context "Test for Remove-EntraBetaObjectSetting" {
        It "Should return empty object" {
            $result = Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Groups -Times 1
        }
        It "Should fail when TargetType is empty" {
            { Remove-EntraBetaObjectSetting -TargetType -TargetObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetType is invalid" {
            { Remove-EntraBetaObjectSetting -TargetType -TargetObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetObjectId is empty" {
            { Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when TargetObjectId is invalid" {
            { Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when Id is empty" {
            { Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaAdministrativeUnit"
            
            Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Id "Remove-EntraBetaObjectSetting" 
           

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaObjectSetting"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Groups -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}    

