# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.Beta.DirectoryManagement        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @("Device.ReadWrite.All")
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
    Mock -CommandName Get-EntraEnvironment -MockWith {return @{
        GraphEndpoint = "https://graph.microsoft.com"
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
    Mock -CommandName New-MgBetaDeviceRegisteredUserByRef -MockWith {} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Add-EntraBetaDeviceRegisteredUser" {
    Context "Test for Add-EntraBetaDeviceRegisteredUser" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
            { Add-EntraBetaDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName New-MgBetaDeviceRegisteredUserByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 0
        }

        It "Should return empty object" {
            $result = Add-EntraBetaDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaDeviceRegisteredUserByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when DeviceId is empty" {
            { Add-EntraBetaDeviceRegisteredUser -DeviceId  -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Missing an argument for parameter 'DeviceId'.*"
        }
        It "Should fail when DeviceId is invalid" {
            { Add-EntraBetaDeviceRegisteredUser -DeviceId "" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Cannot bind argument to parameter 'DeviceId' because it is an empty string."
        }
        It "Should fail when UserId is empty" {
            { Add-EntraBetaDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId } | Should -Throw "Missing an argument for parameter 'UserId'.*"
        }
        It "Should fail when UserId is invalid" {
            { Add-EntraBetaDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }
        It "Should execute successfully with Alias" {
            $result = Add-EntraBetaDeviceRegisteredUser -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaDeviceRegisteredUserByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should contain DeviceId in parameters when passed DeviceId to it" {
            Mock -CommandName New-MgBetaDeviceRegisteredUserByRef -MockWith { $args } -ModuleName Microsoft.Entra.Beta.DirectoryManagement

            $result = Add-EntraBetaDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.DeviceId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain BodyParameter in parameters when passed UserId to it" {
            Mock -CommandName New-MgBetaDeviceRegisteredUserByRef -MockWith { $args } -ModuleName Microsoft.Entra.Beta.DirectoryManagement

            Add-EntraBetaDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $value = @{
                "@odata.id" = "https://graph.microsoft.com/beta/directoryObjects/bbbbbbbb-1111-2222-3333-cccccccccccc"
            }
            Should -Invoke -CommandName New-MgBetaDeviceRegisteredUserByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
                $BodyParameter.AdditionalProperties.'@odata.id' | Should -Be $value.'@odata.id'
                Write-Host $BodyParameter.AdditionalProperties.'@odata.id'
                $true
            }    
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaDeviceRegisteredUser"

            Add-EntraBetaDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetaDeviceRegisteredUser"

            Should -Invoke -CommandName New-MgBetaDeviceRegisteredUserByRef -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Add-EntraBetaDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }  

    }

}

