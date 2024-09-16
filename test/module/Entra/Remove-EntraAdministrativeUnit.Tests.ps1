# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Test for Remove-EntraAdministrativeUnit" {
    It "Should return empty object" {
        $result = Remove-EntraAdministrativeUnit -ObjectId "bbbbbbbb-1111-1111-1111-cccccccccccc"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { Remove-EntraAdministrativeUnit -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is null" {
        { Remove-EntraAdministrativeUnit -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Remove-EntraAdministrativeUnit -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraAdministrativeUnit"

        Remove-EntraAdministrativeUnit -ObjectId "bbbbbbbb-1111-1111-1111-cccccccccccc"

        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraAdministrativeUnit"

        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
            { Remove-EntraAdministrativeUnit -ObjectId "bbbbbbbb-1111-1111-1111-cccccccccccc" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }   
}