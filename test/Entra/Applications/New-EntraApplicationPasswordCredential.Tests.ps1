# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "CustomKeyIdentifier" = $null
                "DisplayName"         = ""
                "EndDateTime"         = "10/23/2024 11:36:56 AM"
                "KeyId"               = "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
                "StartDateTime"       = "11/22/2023 11:35:16 AM"
                "Hint"                = "123"
                "SecretText"          = "wbBNW8kCuiPjNRg9NX98W_EaU6cqG"
                "Parameters"          = $args          
            }
        )
    }

    Mock -CommandName Add-MgApplicationPassword -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
}
Describe "New-EntraApplicationPasswordCredential" {
    It "Should return created password credential" {
        $result = New-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        $result.KeyId | should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
        $result.SecretText | Should -Be "wbBNW8kCuiPjNRg9NX98W_EaU6cqG"
        Should -Invoke -CommandName Add-MgApplicationPassword -ModuleName Microsoft.Entra.Applications -Times 1
    }
    It "Should fail when ApplicationId is empty" {
        { New-EntraApplicationPasswordCredential -ApplicationId "" } | Should -Throw "Cannot validate argument on parameter 'ApplicationId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
    }
    It "Should fail when ApplicationId is null" {
        { New-EntraApplicationPasswordCredential -ApplicationId } | Should -Throw "Missing an argument for parameter 'ApplicationId'*"
    }
    It "Should fail when StartDate is empty" {
        { New-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -StartDate "" } | Should -Throw "Cannot process argument transformation on parameter 'StartDate'*"
    }
    It "Should fail when StartDate is null" {
        { New-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -StartDate } | Should -Throw "Missing an argument for parameter 'StartDate'*"
    }
    It "Should fail when EndDate is empty" {
        { New-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -EndDate "" } | Should -Throw "Cannot process argument transformation on parameter 'EndDate'*"
    }
    It "Should fail when EndDate is null" {
        { New-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -EndDate } | Should -Throw "Missing an argument for parameter 'EndDate'*"
    }
    It "Should fail when invalid parameter is passed" {
        { New-EntraApplicationPasswordCredential -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'."
    }
    It "Should contain ApplicationId in parameters when passed ApplicationId to it" {    
        $result = New-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $params = Get-Parameters -data $result.Parameters
        $params.ApplicationId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
    }
    It "should contain startDateTime in body parameter when passed StartDate to it" {
        $result = New-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -StartDate (get-date).AddYears(0)
        $params = Get-Parameters -data $result.Parameters
        $a = $params.PasswordCredential | ConvertTo-json | ConvertFrom-Json
        $a.startDateTime | Should -Not -BeNullOrEmpty
    }
    It "should contain endDateTime in body parameter when passed EndDate to it" {
        $result = New-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -EndDate (get-date).AddYears(0)
        $params = Get-Parameters -data $result.Parameters
        $a = $params.PasswordCredential | ConvertTo-json | ConvertFrom-Json
        $a.endDateTime | Should -Not -BeNullOrEmpty
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraApplicationPasswordCredential"
        $result = New-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraApplicationPasswordCredential"
        Should -Invoke -CommandName Add-MgApplicationPassword -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
            { New-EntraApplicationPasswordCredential -ApplicationId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}

