# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.Beta.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force    

    $scriptblock = {
        @{
            "deletedDateTime"               = $null
            "visibility"                    = $null
            "displayName"                   = "DummyName"            
            "id"                            = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            "@odata.context"                = " https://graph.microsoft.com/beta/`$metadata#directory/administrativeUnits/`$entity"
            "membershipType"                = $null
            "description"                   = $null
            "membershipRuleProcessingState" = $null
            "Parameters"                    = $args
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('AdministrativeUnit.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}
Describe "Tests for New-EntraBetaAdministrativeUnit" {
    It "Should throw when not connected and not invoke graph call" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
        { New-EntraBetaAdministrativeUnit -DisplayName "DummyName" } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 0
    }

    It "Result should not be empty" {
        $result = New-EntraBetaAdministrativeUnit -DisplayName "DummyName"
        $result | Should -Not -BeNullOrEmpty
        $result.id | should -Be @('aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb')
        $result.displayName | Should -Be "DummyName"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
    }
    It "Should fail when DisplayName is empty" {
        { New-EntraBetaAdministrativeUnit -DisplayName "" } | Should -Throw "Cannot bind argument to parameter 'DisplayName'*"
    }
    It "Should fail when DisplayName is null" {
        { New-EntraBetaAdministrativeUnit -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
    }    
    It "Should fail when invalid parameter is passed" {
        { New-EntraBetaAdministrativeUnit -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAdministrativeUnit"
        $result = New-EntraBetaAdministrativeUnit -DisplayName "DummyName"
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAdministrativeUnit"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
            { New-EntraBetaAdministrativeUnit -DisplayName "DummyName" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}