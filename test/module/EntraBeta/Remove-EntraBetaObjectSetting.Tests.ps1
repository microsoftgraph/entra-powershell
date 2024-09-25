# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}
Describe "Remove-EntraBetaObjectSetting" {
    Context "Test for Remove-EntraBetaObjectSetting" {
        It "Should return empty object" {
            $result = Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" 
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when TargetType is empty" {
            { Remove-EntraBetaObjectSetting -TargetType  -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetType is invalid" {
            { Remove-EntraBetaObjectSetting -TargetType  -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'TargetType'*"
        }
        It "Should fail when TargetObjectId is empty" {
            { Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when TargetObjectId is invalid" {
            { Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId -Id "dddddddd-7902-4be2-a25b-dddddddddddd" } | Should -Throw "Missing an argument for parameter 'TargetObjectId'*"
        }
        It "Should fail when Id is empty" {
            { Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaAdministrativeUnit"
            
            Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "Remove-EntraBetaObjectSetting" 
           

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaObjectSetting"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaObjectSetting -TargetType "Groups" -TargetObjectId "aaaaaaaa-5a8c-4f5a-a368-cccccccccccc" -Id "dddddddd-7902-4be2-a25b-dddddddddddd" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}    