# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    # Update mock to return proper response structure with value property
    $scriptblock = {
        @{
            "value" = @(
                @{
                    "appDisplayName"         = "POWERAPPS_DEV"
                    "isMultiValued"          = $false
                    "isSyncedFromOnPremises" = $false
                    "targetObjects"          = @("User")
                    "id"                     = "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
                    "name"                   = "extension_12345_JobGroup"
                    "deletedDateTime"        = $null
                }
            )
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Directory.Read.All") } } -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "Tests for Get-EntraExtensionProperty" {
    It "Should throw when not connected and not invoke graph call" {
        Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
        { Get-EntraExtensionProperty -IsSyncedFromOnPremises $false } | Should -Throw "Not connected to Microsoft Graph*"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
    }

    It "Result should not be empty" {
        $result = Get-EntraExtensionProperty -IsSyncedFromOnPremises $false
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraExtensionProperty"
        $result = Get-EntraExtensionProperty -IsSyncedFromOnPremises $false
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
            { Get-EntraExtensionProperty -IsSyncedFromOnPremises $false } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference
            $DebugPreference = $originalDebugPreference
        }
    } 
}

