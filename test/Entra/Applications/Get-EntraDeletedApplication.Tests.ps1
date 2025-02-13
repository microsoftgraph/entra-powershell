# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        @{
            "description"       = "test111"
            "id"                = "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
            "deletedDateTime"   = $null
            "displayName"       = "test111"
            "membershipType"    = $null
            "signInAudience"    = "AzureADMyOrg"
            "createdDateTime"   = "2025-02-12T11:07:07Z"
            "DeletionAgeInDays" = 0
            "publisherDomain"   = "contoso.com"
            "addIns"            = @()
            "appRoles"          = @()
            "appId"             = "00001111-aaaa-2222-bbbb-3333cccc4444"
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
}
Describe "Tests for Get-EntraDeletedApplication" {
    It "Result should not be empty" {
        $result = Get-EntraDeletedApplication -ApplicationId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
    }
    It "Result should not be empty objectid" {
        $result = Get-EntraDeletedApplication -ApplicationId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
    }    
  
    It "Should fail when All has an argument" {
        { Get-EntraDeletedApplication -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
    }
    It "Should fail when filter is empty" {
        { Get-EntraDeletedApplication -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
    }
    It "Should fail when Top is empty" {
        { Get-EntraDeletedApplication -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
    }
    It "Should fail when Top is invalid" {
        { Get-EntraDeletedApplication -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
    }         
    It "Should fail when invalid parameter is passed" {
        { Get-EntraDeletedApplication -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should return specific deleted applications by filter" {
        $result = Get-EntraDeletedApplication -Filter "displayName -eq 'test111'"
        $result | Should -Not -BeNullOrEmpty
        $result.DisplayName | should -Be 'test111'
        Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Applications -Times 1
    }  
    It "Should return top deleted applications" {
        $result = @(Get-EntraDeletedApplication -Top 1)
        $result | Should -Not -BeNullOrEmpty
        $result | Should -HaveCount 1 
        Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Applications -Times 1
    }  
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedApplication"
        $result = Get-EntraDeletedApplication -All
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedApplication"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
            { Get-EntraDeletedApplication -Top 1 -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}



