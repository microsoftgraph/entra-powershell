# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.Beta.DirectoryManagement       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    

    Mock -CommandName Remove-MgBetaDirectoryAdministrativeUnitMemberByRef -MockWith {} -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('AdministrativeUnit.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Remove-EntraBetaAdministrativeUnitMember" {
    Context "Test for Remove-EntraBetaAdministrativeUnitMember" {
        It "Should return empty object" {
            $result = Remove-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "dddddddd-9999-0000-1111-eeeeeeeeeeee"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaDirectoryAdministrativeUnitMemberByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should return empty object with alias" {
            $result = Remove-EntraBetaAdministrativeUnitMember -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "dddddddd-9999-0000-1111-eeeeeeeeeeee"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaDirectoryAdministrativeUnitMemberByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when AdministrativeUnitId is empty" {
            { Remove-EntraBetaAdministrativeUnitMember -AdministrativeUnitId  -MemberId "dddddddd-9999-0000-1111-eeeeeeeeeeee"   } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
        }
        It "Should fail when AdministrativeUnitId is invalid" {
            { Remove-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "" -MemberId "dddddddd-9999-0000-1111-eeeeeeeeeeee"} | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId' because it is an empty string."
        }
        It "Should fail when MemberId is empty" {
            { Remove-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId  } | Should -Throw "Missing an argument for parameter 'MemberId'*"
        }
        It "Should fail when MemberId is invalid" {
            { Remove-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId ""} | Should -Throw "Cannot bind argument to parameter 'MemberId' because it is an empty string."
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaAdministrativeUnitMember"

            Remove-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "dddddddd-9999-0000-1111-eeeeeeeeeeee"
           

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaAdministrativeUnitMember"
            Should -Invoke -CommandName Remove-MgBetaDirectoryAdministrativeUnitMemberByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -MemberId "dddddddd-9999-0000-1111-eeeeeeeeeeee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 

    }
}

