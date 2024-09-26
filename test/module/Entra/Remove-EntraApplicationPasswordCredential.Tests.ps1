# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgApplicationPassword -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraApplicationPasswordCredential"{
    It "Should return empty object" {
        $result = Remove-EntraApplicationPasswordCredential -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -KeyId "bbbbbbbb-cccc-dddd-2222-333333333333"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Remove-MgApplicationPassword -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Remove-EntraApplicationPasswordCredential -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is null" {
        { Remove-EntraApplicationPasswordCredential -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    It "Should fail when KeyId is empty" {
        { Remove-EntraApplicationPasswordCredential -KeyId "" } | Should -Throw "Cannot bind argument to parameter 'KeyId'*"
    }
    It "Should fail when KeyId is null" {
        { Remove-EntraApplicationPasswordCredential -KeyId } | Should -Throw "Missing an argument for parameter 'KeyId'*"
    }    
    It "Should fail when invalid parameter is passed" {
        { Remove-EntraApplicationPasswordCredential -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'."
    }
    It "Should contain ApplicationId in parameters when passed ObjectId to it" {
        Mock -CommandName Remove-MgApplicationPassword -MockWith {$args} -ModuleName Microsoft.Graph.Entra
        $result = Remove-EntraApplicationPasswordCredential -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -KeyId "bbbbbbbb-cccc-dddd-2222-333333333333"
        $params = Get-Parameters -data $result
        $params.ApplicationId | Should -Be "aaaaaaaa-bbbb-cccc-1111-222222222222"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraApplicationPasswordCredential"
        $result = Remove-EntraApplicationPasswordCredential -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -KeyId "bbbbbbbb-cccc-dddd-2222-333333333333"
        $result | Should  -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraApplicationPasswordCredential"
        Should -Invoke -CommandName Remove-MgApplicationPassword -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
            { Remove-EntraApplicationPasswordCredential -ObjectId "aaaaaaaa-bbbb-cccc-1111-222222222222" -KeyId "bbbbbbbb-cccc-dddd-2222-333333333333" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}