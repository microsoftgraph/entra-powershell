# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.Beta.DirectoryManagement       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    

    Mock -CommandName New-MgBetaAdministrativeUnitMemberByRef -MockWith {} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = "Global"
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
    Mock -CommandName Get-EntraEnvironment -MockWith {return @{
        GraphEndpoint = "https://graph.microsoft.com"
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Add-EntraBetaAdministrativeUnitMember" {
    Context "Test for Add-EntraBetaAdministrativeUnitMember" {
        It "Should return empty object" {
            $result = Add-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "eeeeeeee-4444-5555-6666-ffffffffffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaAdministrativeUnitMemberByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should return empty object with alias" {
            $result = Add-EntraBetaAdministrativeUnitMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "eeeeeeee-4444-5555-6666-ffffffffffff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaAdministrativeUnitMemberByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when AdministrativeUnitId is empty" {
            { Add-EntraBetaAdministrativeUnitMember -AdministrativeUnitId  -MemberId "eeeeeeee-4444-5555-6666-ffffffffffff" } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
        }
        It "Should fail when AdministrativeUnitId is invalid" {
            { Add-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "" -MemberId "eeeeeeee-4444-5555-6666-ffffffffffff" } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId' because it is an empty string."
        }
        It "Should fail when MemberId is empty" {
            { Add-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId } | Should -Throw "Missing an argument for parameter 'MemberId'*"
        }
        It "Should fail when MemberId is invalid" {
            { Add-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "" } | Should -Throw "Cannot bind argument to parameter 'MemberId' because it is an empty string."
        }
        It "Should contain AdministrativeUnitId in parameters when passed AdministrativeUnitId to it" {    
            Mock -CommandName New-MgBetaAdministrativeUnitMemberByRef -MockWith { $args } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
            $result = Add-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "eeeeeeee-4444-5555-6666-ffffffffffff"
            $params = Get-Parameters -data $result
            $params.AdministrativeUnitId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaAdministrativeUnitMember"

            Add-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "eeeeeeee-4444-5555-6666-ffffffffffff"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaAdministrativeUnitMember"

            Should -Invoke -CommandName New-MgBetaAdministrativeUnitMemberByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Add-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "eeeeeeee-4444-5555-6666-ffffffffffff" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 


    }
}

