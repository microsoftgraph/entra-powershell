# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        @{
            "skuPartNumber"          = "POWERAPPS_DEV"
            "commerceSubscriptionId" = "bbbbbbbb-1111-2222-3333-aaaaaaaaaaaa"
            "totalLicenses"          = 10000
            "id"                     = "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
            "createdDateTime"        = "2021-07-01T00:00:00Z"
            "nextLifecycleDateTime"  = $null
            "skuId"                  = "cccccccc-1111-2222-3333-aaaaaaaaaaaa"
            "status"                 = "Enabled"
            "serviceStatus"          = "{EXCHANGE_S_FOUNDATION, DYN365_CDS_DEV_VIRAL, FLOW_DEV_VIRAL, POWERAPPS_DEV_VIRAL}"
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Organization.Read.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}
Describe "Tests for Get-EntraSubscription" {
    It "Result should not be empty" {
        $result = Get-EntraSubscription -CommerceSubscriptionId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }

    It "Should fail when CommerceSubscriptionId is empty" {
        { Get-EntraSubscription -CommerceSubscriptionId "" } | Should -Throw "Cannot bind argument to parameter 'CommerceSubscriptionId'*"
    }
    It "Should fail when CommerceSubscriptionId is null" {
        { Get-EntraSubscription -CommerceSubscriptionId } | Should -Throw "Missing an argument for parameter 'CommerceSubscriptionId'*"
    }    
    It "Should fail when All has an argument" {
        { Get-EntraSubscription -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
    }
    It "Should fail when filter is empty" {
        { Get-EntraSubscription -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
    }
    It "Should fail when Top is empty" {
        { Get-EntraSubscription -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
    }
    It "Should fail when Top is invalid" {
        { Get-EntraSubscription -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
    }         
    It "Should fail when invalid parameter is passed" {
        { Get-EntraSubscription -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
 
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraSubscription"
        $result = Get-EntraSubscription -CommerceSubscriptionId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
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
            { Get-EntraSubscription -CommerceSubscriptionId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference
            $DebugPreference = $originalDebugPreference
        }
    } 
}

