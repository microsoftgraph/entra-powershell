# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

    Mock -CommandName New-MgBetaAdministrativeUnitMemberByRef -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Add-EntraBetaAdministrativeUnitMember" {
    Context "Test for Add-EntraBetaAdministrativeUnitMember" {
        It "Should return empty object" {
            $result = Add-EntraBetaAdministrativeUnitMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaAdministrativeUnitMemberByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Add-EntraBetaAdministrativeUnitMember -ObjectId  -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff"   } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Add-EntraBetaAdministrativeUnitMember -ObjectId "" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff"} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when RefObjectId is empty" {
            { Add-EntraBetaAdministrativeUnitMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId  } | Should -Throw "Missing an argument for parameter 'RefObjectId'*"
        }
        It "Should fail when RefObjectId is invalid" {
            { Add-EntraBetaAdministrativeUnitMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId ""} | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }
        It "Should contain AdministrativeUnitId in parameters when passed ObjectId to it" {    
            Mock -CommandName New-MgBetaAdministrativeUnitMemberByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
            $result = Add-EntraBetaAdministrativeUnitMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff"
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaAdministrativeUnitMember"

            Add-EntraBetaAdministrativeUnitMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaAdministrativeUnitMember"

            Should -Invoke -CommandName New-MgBetaAdministrativeUnitMemberByRef -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Add-EntraBetaAdministrativeUnitMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 


    }
}