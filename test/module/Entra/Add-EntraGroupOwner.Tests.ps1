# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgGroupOwnerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Add-EntraGroupOwner" {
    Context "Test for Add-EntraGroupOwner" {
        It "Should add an owner to a group" {
            $result = Add-EntraGroupOwner -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgGroupOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Add-EntraGroupOwner -ObjectId  -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"  } | Should -Throw "Missing an argument for parameter 'ObjectId'.*"
        }

        It "Should fail when ObjectId is invalid" {
            { Add-EntraGroupOwner -ObjectId "" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when RefObjectId is empty" {
            { Add-EntraGroupOwner -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId   } | Should -Throw "Missing an argument for parameter 'RefObjectId'.*"
        }

        It "Should fail when RefObjectId is invalid" {
            { Add-EntraGroupOwner -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName New-MgGroupOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Add-EntraGroupOwner -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "aaaaaaaa-1111-2222-3333-cccccccccccc"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraGroupOwner"
            Add-EntraGroupOwner -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraGroupOwner"
            Should -Invoke -CommandName New-MgGroupOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                {  Add-EntraGroupOwner -ObjectId "aaaaaaaa-1111-2222-3333-cccccccccccc" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}
