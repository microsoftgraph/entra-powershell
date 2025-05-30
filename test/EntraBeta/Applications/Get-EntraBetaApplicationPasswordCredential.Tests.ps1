# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            @{
                "startDateTime"       = "11/24/2023 6:28:39 AM"
                "keyId"               = "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr"
                "hint"                = "123"
                "secretText"          = ""
                "endDateTime"         = "11/24/2024 6:28:39 AM"
                "CustomKeyIdentifier" = "dGVzdA=="
                "DisplayName"         = "test"

            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
}
Describe "Get-EntraBetaApplicationPasswordCredential" {
    Context "Test for Get-EntraBetaApplicationPasswordCredential" {
        It "Should return specific credential" {
            $result = Get-EntraBetaApplicationPasswordCredential -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.keyId | Should -Be "bbbbbbbb-1111-2222-3333-rrrrrrrrrrrr"
            $result.DisplayName | Should -Be "test"
            $result.CustomKeyIdentifier.gettype().name | Should -Be 'Byte[]'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should return specific credential with Alias" {
            $result = Get-EntraBetaApplicationPasswordCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should fail when ApplicationId is invalid" {
            { Get-EntraBetaApplicationPasswordCredential -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should fail when ApplicationId is empty" {
            { Get-EntraBetaApplicationPasswordCredential -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        }            
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationPasswordCredential"

            $result = Get-EntraBetaApplicationPasswordCredential -ApplicationId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
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
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

