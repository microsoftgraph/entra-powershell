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
            [PSCustomObject]@{
                "ApplicationId"       = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "CustomKeyIdentifier" = "EntraPowerShellKey"
                "Type"                = "Symmetric"
                "EndDate"             = "2025-03-21T14:14:14Z"
                "KeyId"               = "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
                "StartDate"           = "2024-03-21T14:14:14Z"
                "Usage"               = "Sign"
                "Value"               = "wbBNW8kCuiPjNRg9NX98W_EaU6cqG"
                "Parameters"          = $args          
            }
        )
    }

    Mock -CommandName Add-MgBetaApplicationKey -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
}
Describe "New-EntraBetaApplicationKeyCredential" {
        It "Should return created key credential" {
            $params = @{
                ApplicationId = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                CustomKeyIdentifier = 'EntraPowerShellKey'
                StartDate = '2024-03-21T14:14:14Z'
                EndDate = '2025-03-21T14:14:14Z'
                Type = 'Symmetric'
                Usage = 'Sign'
                Value = 'wbBNW8kCuiPjNRg9NX98W_EaU6cqG'
            }
            $result = New-EntraBetaApplicationKeyCredential @params
            $result | Should -Not -BeNullOrEmpty
            $result.KeyId | should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $result.Type | should -Be "Symmetric"
            $result.Value | Should -Be "wbBNW8kCuiPjNRg9NX98W_EaU6cqG"
            Should -Invoke -CommandName Add-MgBetaApplicationKey -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }
        It "Should fail when ApplicationId is empty" {
            { New-EntraBetaApplicationKeyCredential -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should fail when ApplicationId is null" {
            { New-EntraBetaApplicationKeyCredential -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
        }
        It "Should fail when StartDate is empty" {
            { New-EntraBetaApplicationKeyCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -StartDate "" } | Should -Throw "Cannot process argument transformation on parameter 'StartDate'*"
        }
        It "Should fail when StartDate is null" {
            { New-EntraBetaApplicationKeyCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -StartDate } | Should -Throw "Missing an argument for parameter 'StartDate'*"
        }
        It "Should fail when EndDate is empty" {
            { New-EntraBetaApplicationKeyCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -EndDate "" } | Should -Throw "Cannot process argument transformation on parameter 'EndDate'*"
        }
        It "Should fail when EndDate is null" {
            { New-EntraBetaApplicationKeyCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -EndDate } | Should -Throw "Missing an argument for parameter 'EndDate'*"
        }
        It "Should fail when invalid parameter is passed" {
            { New-EntraBetaApplicationKeyCredential -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'."
        }
        It "Should contain ApplicationId in parameters when passed ApplicationId to it" {
            $params = @{
                ApplicationId = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                CustomKeyIdentifier = 'EntraPowerShellKey'
                StartDate = '2024-03-21T14:14:14Z'
                EndDate = '2025-03-21T14:14:14Z'
                Type = 'Symmetric'
                Usage = 'Sign'
                Value = 'wbBNW8kCuiPjNRg9NX98W_EaU6cqG'
            }
            $result = New-EntraBetaApplicationKeyCredential @params
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "should contain startDateTime in body parameter when passed StartDate to it" {
            $params = @{
                ApplicationId = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                CustomKeyIdentifier = 'EntraPowerShellKey'
                StartDate = '2024-03-21T14:14:14Z'
                EndDate = '2025-03-21T14:14:14Z'
                Type = 'Symmetric'
                Usage = 'Sign'
                Value = 'wbBNW8kCuiPjNRg9NX98W_EaU6cqG'
            }
            $result = New-EntraBetaApplicationKeyCredential @params
            $params = Get-Parameters -data $result.Parameters
            $a = $params.KeyCredential | ConvertTo-json | ConvertFrom-Json
            $a.startDateTime | Should -Not -BeNullOrEmpty
        }
        It "should contain endDateTime in body parameter when passed EndDate to it" {
            $params = @{
                ApplicationId = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                CustomKeyIdentifier = 'EntraPowerShellKey'
                StartDate = '2024-03-21T14:14:14Z'
                EndDate = '2025-03-21T14:14:14Z'
                Type = 'Symmetric'
                Usage = 'Sign'
                Value = 'wbBNW8kCuiPjNRg9NX98W_EaU6cqG'
            }
            $result = New-EntraBetaApplicationKeyCredential @params
            $params = Get-Parameters -data $result.Parameters
            $a = $params.KeyCredential | ConvertTo-json | ConvertFrom-Json
            $a.endDateTime | Should -Not -BeNullOrEmpty
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaApplicationKeyCredential"
            $params = @{
                ApplicationId = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                CustomKeyIdentifier = 'EntraPowerShellKey'
                StartDate = '2024-03-21T14:14:14Z'
                EndDate = '2025-03-21T14:14:14Z'
                Type = 'Symmetric'
                Usage = 'Sign'
                Value = 'wbBNW8kCuiPjNRg9NX98W_EaU6cqG'
            }
            $result = New-EntraBetaApplicationKeyCredential @params
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaApplicationKeyCredential"
            Should -Invoke -CommandName Add-MgBetaApplicationKey -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
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
            $params = @{
                ApplicationId = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                CustomKeyIdentifier = 'EntraPowerShellKey'
                StartDate = '2024-03-21T14:14:14Z'
                EndDate = '2025-03-21T14:14:14Z'
                Type = 'Symmetric'
                Usage = 'Sign'
                Value = 'wbBNW8kCuiPjNRg9NX98W_EaU6cqG'
            }
            { New-EntraBetaApplicationKeyCredential @params -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}

