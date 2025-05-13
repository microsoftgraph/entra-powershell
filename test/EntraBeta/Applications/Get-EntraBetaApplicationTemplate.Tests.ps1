# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $response = @{
        "id"                         = "aaaaaaaa-1111-2222-3333-cccccccccccc"
        "supportedSingleSignOnModes" = @{}
        "publisher"                  = "test publisher"
        "displayName"                = "test name"
        "homePageUrl"                = "samplehomePageUrl"
        "logoUrl"                    = "samplelogourl"
        "categories"                 = @{}
        "description"                = ""
        "supportedProvisioningTypes" = @{}
    }

    Mock -CommandName Invoke-GraphRequest -MockWith { $response } -ModuleName Microsoft.Entra.Beta.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Beta.Applications
}
Describe "Get-EntraBetaApplicationTemplate tests" {
    It "Should return specific application" {
        $result = Get-EntraBetaApplicationTemplate -Id "aaaaaaaa-1111-2222-3333-cccccccccccc"
        $result | Should -Not -BeNullOrEmpty
        $result.Id | should -Be @('aaaaaaaa-1111-2222-3333-cccccccccccc')
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }
    It "Should fail when Id is empty" {
        { Get-EntraBetaApplicationTemplate -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
    }
    It "Should fail when Id is null" {
        { Get-EntraBetaApplicationTemplate -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Get-EntraBetaApplicationTemplate -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should return all application templates" {
        $result = Get-EntraBetaApplicationTemplate
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }
    It "Should execute successfully without throwing an error " {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Get-EntraBetaApplicationTemplate -Id "aaaaaaaa-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
    It "Should return top ApplicationTemplate" {
        $result = Get-EntraBetaApplicationTemplate -Top 1
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }
    It "Should fail when Top is invalid" {
        { Get-EntraBetaApplicationTemplate -Id "aaaaaaaa-1111-2222-3333-cccccccccccc" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
    }
    It "Should return all templates" {
        $result = Get-EntraBetaApplicationTemplate -All 
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }
    It "Should fail when All has an argument" {
        { Get-EntraBetaApplicationTemplate -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
    }
    It "Should contain property when passed property to it" {
        $result = Get-EntraBetaApplicationTemplate -Property DisplayName
        $result.displayName | Should -Not -BeNullOrEmpty
    }
    It "Should fail when Property is empty" {
        { Get-EntraBetaApplicationTemplate -Property } | Should -Throw "Missing an argument for parameter 'Property'.*"
    }
    It "Should return specific template by filter" {
        $result = Get-EntraBetaApplicationTemplate -Filter "DisplayName eq 'test name'"
        $result | Should -Not -BeNullOrEmpty
        $result.DisplayName | should -Be 'test name'
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
    }
}

