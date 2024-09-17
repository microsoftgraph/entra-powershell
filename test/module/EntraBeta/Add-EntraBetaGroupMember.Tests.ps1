# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgBetaGroupMember -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Add-EntraBetaGroupMember" {
    Context "Test for Add-EntraBetaGroupMember" {
        It "Should return empty object" {
            $result = Add-EntraBetaGroupMember -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaGroupMember -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Add-EntraBetaGroupMember -ObjectId  -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"  } | Should -Throw "Missing an argument for parameter 'ObjectId'.*"
        }

        It "Should fail when ObjectId is invalid" {
            { Add-EntraBetaGroupMember -ObjectId "" -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when RefObjectId is empty" {
            { Add-EntraBetaGroupMember -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId   } | Should -Throw "Missing an argument for parameter 'RefObjectId'.*"
        }

        It "Should fail when RefObjectId is invalid" {
            { Add-EntraBetaGroupMember -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName New-MgBetaGroupMember -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Add-EntraBetaGroupMember -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "aaaabbbb-0000-cccc-1111-dddd2222eeee"
        }

        It "Should contain DirectoryObjectId in parameters when passed RefObjectId to it" {
            Mock -CommandName New-MgBetaGroupMember -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $result = Add-EntraBetaGroupMember -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaGroupMember"
            Add-EntraBetaGroupMember -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaGroupMember"
            Should -Invoke -CommandName New-MgBetaGroupMember -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Add-EntraBetaGroupMember -ObjectId "aaaabbbb-0000-cccc-1111-dddd2222eeee" -RefObjectId "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}
