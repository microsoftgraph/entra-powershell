# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "CustomKeyIdentifier" = $null
                "DisplayName"         = "mypassword"
                "EndDateTime"         = "10/23/2024 11:36:56 AM"
                "KeyId"               = "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
                "StartDateTime"       = "11/22/2023 11:35:16 AM"
                "Hint"                = "123"
                "SecretText"          = "wbBNW8kCuiPjNRg9NX98W_EaU6cqG"
                "Parameters"          = $args          
            }
        )
    }

    Mock -CommandName Add-MgApplicationPassword -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "New-EntraApplicationPassword"{
    It "Should return created password credential"{
        $result = New-EntraApplicationPassword -ObjectID "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PasswordCredential @{ displayname = "mypassword" } | ConvertTo-Json | ConvertFrom-Json
        $result | Should -Not -BeNullOrEmpty
        $result.KeyId | should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
        $result.SecretText | Should -Be "wbBNW8kCuiPjNRg9NX98W_EaU6cqG"
        Should -Invoke -CommandName Add-MgApplicationPassword -ModuleName Microsoft.Graph.Entra -Times 1
    }
    It "Should fail when ObjectId is empty" {
        { New-EntraApplicationPassword -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId'*"
    }
    It "Should fail when ObjectId is null" {
        { New-EntraApplicationPassword -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
    }
    It "Should fail when PasswordCredential is null" {
        { New-EntraApplicationPassword -PasswordCredential } | Should -Throw "Missing an argument for parameter 'PasswordCredential'*"
    }
    It "Should fail when StartDate is empty" {
        { New-EntraApplicationPassword -ObjectID "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PasswordCredential @{ StartDateTime = "" } } | Should -Throw "Cannot process argument transformation on parameter 'PasswordCredential'*"
    }
    It "Should fail when EndDate is empty" {
        { New-EntraApplicationPassword -ObjectID "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PasswordCredential @{ EndDateTime = "" } } | Should -Throw "Cannot process argument transformation on parameter 'PasswordCredential'*"
    }
    It "Should fail when invalid parameter is passed" {
        { New-EntraApplicationPassword -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'."
    }
    It "Should contain ApplicationId in parameters when passed ObjectId to it" {    
        $result = New-EntraApplicationPassword -ObjectID "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PasswordCredential @{ displayname = "mypassword" }
        $params = Get-Parameters -data $result.Parameters
        $params.ApplicationId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
    }
    It "should contain password credential parameters in body parameter when passed PasswordCredential to it"{
        $result = New-EntraApplicationPassword -ObjectID "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PasswordCredential @{ DisplayName = "mypassword"; Hint = "123"; StartDateTime=(get-date).AddYears(0); EndDateTime=(get-date).AddYears(2) }
        $params = Get-Parameters -data $result.Parameters
        $a = $params.PasswordCredential | ConvertTo-json | ConvertFrom-Json
        $a.DisplayName | Should -Be "mypassword"
        $a.Hint | Should -Be "123"
        $a.StartDateTime | Should -Not -BeNullOrEmpty
        $a.EndDateTime | Should -Not -BeNullOrEmpty
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraApplicationPassword"
        $result = New-EntraApplicationPassword -ObjectID "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PasswordCredential @{ displayname = "mypassword" } | ConvertTo-Json | ConvertFrom-Json
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraApplicationPassword"
        Should -Invoke -CommandName Add-MgApplicationPassword -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
            { New-EntraApplicationPassword -ObjectID "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PasswordCredential @{ displayname = "mypassword" } | ConvertTo-Json | ConvertFrom-Json -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}