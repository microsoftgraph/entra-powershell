# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null) {
        Import-Module Microsoft.Graph.Entra.Beta      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            @{
                "startDateTime"    = "11/24/2023 6:28:39 AM"
                "keyId" = "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr"
                "hint" = "123"
                "secretText"  = ""
                "endDateTime"       = "11/24/2024 6:28:39 AM"
                "CustomKeyIdentifier" = "dGVzdA=="
                "DisplayName" = "test"

            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
Describe "Get-EntraBetaApplicationPasswordCredential" {
    Context "Test for Get-EntraBetaApplicationPasswordCredential" {
        It "Should return specific Policy" {
            $result = Get-EntraBetaApplicationPasswordCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.keyId | Should -Be "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr"
            $result.DisplayName | Should -Be "test"
            $result.CustomKeyIdentifier.gettype().name | Should -Be 'Byte[]'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is invalObjectId" {
            { Get-EntraBetaApplicationPasswordCredential -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaApplicationPasswordCredential -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }            
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationPasswordCredential"

            $result = Get-EntraBetaApplicationPasswordCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaApplicationPasswordCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}