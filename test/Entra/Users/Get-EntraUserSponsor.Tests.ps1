# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Users) -eq $null){
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    $scriptblock = {
    return @{
        value = @(
            @{
                id         = "00aa00aa-bb11-cc22-dd33-44ee44ee44e"
                country    = "United States"
                '@odata.type' = "#microsoft.graph.user"
            }
        )
        '@odata.nextLink' = $null
    }
}

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
}

Describe "Get-EntraUserSponsor" {
    Context "Test for Get-EntraUserSponsor" {
        It "Should fail when UserId is empty string value" {
            { Get-EntraUserSponsor -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }
        It "Should fail when UserId is empty" {
            { Get-EntraUserSponsor -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }
        It "Should return specific User with alias" {
            $result = Get-EntraUserSponsor -UserId "00aa00aa-bb11-cc22-dd33-44ee44ee44e"
            
            $result | Should -Not -BeNullOrEmpty
            should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should return specific user and his sponsors" {
            $result = Get-EntraUserSponsor -UserId "00aa00aa-bb11-cc22-dd33-44ee44ee44e"
            $result | Should -Not -BeNullOrEmpty
            $result.id | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44e"
            $result.country | should -Be "United States"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }
        It "Should return top user" {
            $result = Get-EntraUserSponsor -UserId "00aa00aa-bb11-cc22-dd33-44ee44ee44e" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Users -Times 1
        }
        It 'should handle the Property parameter correctly' {
            $UserId = '00aa00aa-bb11-cc22-dd33-44ee44ee44e'
            $Property = @('id', 'displayName')
            $result = Get-EntraUserSponsor -UserId $UserId -Property $Property
            $result | Should -Not -BeNullOrEmpty
            $result | ForEach-Object {
                $_.PSObject.Properties.Name | Should -Contain 'id'
                $_.PSObject.Properties.Name | Should -Contain 'displayName'
            }
        }
    }
}