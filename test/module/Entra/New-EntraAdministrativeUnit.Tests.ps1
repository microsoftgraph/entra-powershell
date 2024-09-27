# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll{
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force    

    $scriptblock = {
        @{
            "deletedDateTime" = $null
            "visibility" = $null
            "displayName" = "DummyName"            
            "id" = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            "@odata.context" = " https://graph.microsoft.com/v1.0/`$metadata#directory/administrativeUnits/`$entity"
            "membershipType" = $null
            "description" = $null
            "membershipRuleProcessingState" = $null
            "Parameters" = $args
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Tests for New-EntraAdministrativeUnit"{
    It "Result should not be empty"{
        $result = New-EntraAdministrativeUnit -DisplayName "DummyName"
        $result | Should -Not -BeNullOrEmpty
        $result.id | should -Be @('aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb')
        $result.displayName | Should -Be "DummyName"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when DisplayName is empty" {
        { New-EntraAdministrativeUnit -DisplayName "" } | Should -Throw "Cannot bind argument to parameter 'DisplayName'*"
    }
    It "Should fail when DisplayName is null" {
        { New-EntraAdministrativeUnit -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
    }    
    It "Should fail when invalid parameter is passed" {
        { New-EntraAdministrativeUnit -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraAdministrativeUnit"
        $result = New-EntraAdministrativeUnit -DisplayName "DummyName"
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraAdministrativeUnit"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
            { New-EntraAdministrativeUnit -DisplayName "DummyName" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}