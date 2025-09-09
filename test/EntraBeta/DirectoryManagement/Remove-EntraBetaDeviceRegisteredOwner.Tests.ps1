# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.Beta.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgBetaDeviceRegisteredOwnerByRef -MockWith {} -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Directory.AccessAsUser.All')
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Remove-EntraBetaDeviceRegisteredOwner" {
    Context "Test for Remove-EntraBetaDeviceRegisteredOwner" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
            { Remove-EntraBetaDeviceRegisteredOwner -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Remove-MgBetaDeviceRegisteredOwnerByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 0
        }
        
        It "Should return empty object" {
            $result = Remove-EntraBetaDeviceRegisteredOwner -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaDeviceRegisteredOwnerByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Remove-EntraBetaDeviceRegisteredOwner -ObjectId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgBetaDeviceRegisteredOwnerByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when DeviceId is empty" {
            { Remove-EntraBetaDeviceRegisteredOwner -DeviceId   -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc" | Should -Throw "Missing an argument for parameter 'DeviceId'*" }
        }
        It "Should fail when DeviceId is invalid" {
            { Remove-EntraBetaDeviceRegisteredOwner -DeviceId  "" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc" | Should -Throw "Cannot bind argument to parameter 'DeviceId' because it is an empty string.*" }
        }
        It "Should fail when OwnerId is empty" {
            { Remove-EntraBetaDeviceRegisteredOwner -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -OwnerId  | Should -Throw "Missing an argument for parameter 'OwnerId'*" }
        }
        It "Should fail when OwnerId is invalid" {
            { Remove-EntraBetaDeviceRegisteredOwner -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -OwnerId "" | Should -Throw "Cannot bind argument to parameter 'OwnerId' because it is an empty string.*" }
        }  
        It "Should contain DeviceId in parameters when passed OwnerId to it" {
            Mock -CommandName Remove-MgBetaDeviceRegisteredOwnerByRef -MockWith {$args} -ModuleName Microsoft.Entra.Beta.DirectoryManagement

            $result = Remove-EntraBetaDeviceRegisteredOwner -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.DeviceId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        } 
        It "Should contain DirectoryObjectId in parameters when passed OwnerId to it" {
            Mock -CommandName Remove-MgBetaDeviceRegisteredOwnerByRef -MockWith {$args} -ModuleName Microsoft.Entra.Beta.DirectoryManagement

            $result = Remove-EntraBetaDeviceRegisteredOwner -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaDeviceRegisteredOwner"

            $result = Remove-EntraBetaDeviceRegisteredOwner -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraBetaDeviceRegisteredOwner"

            Should -Invoke -CommandName Remove-MgBetaDeviceRegisteredOwnerByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Remove-EntraBetaDeviceRegisteredOwner -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -OwnerId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}
