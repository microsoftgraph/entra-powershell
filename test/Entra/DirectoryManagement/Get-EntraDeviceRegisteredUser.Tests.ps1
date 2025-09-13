# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                               = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                    "onPremisesImmutableId"            = $null
                    "deletedDateTime"                  = $null
                    "onPremisesSyncEnabled"            = $null
                    "OnPremisesLastSyncDateTime"       = $null
                    "onPremisesProvisioningErrors"     = @{}
                    "mobilePhone"                      = "425-555-0100"
                    "BusinessPhones"                   = @("425-555-0100")
                    "ExternalUserState"                = $null
                    "ExternalUserStateChangeDateTime"  = $null
                    "Parameters"                       = $args
                }
            )
        }
    }
    

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Device.Read.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}



Describe "Get-EntraDeviceRegisteredUser" {
    Context "Test for Get-EntraDeviceRegisteredUser" {
        It "Should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Get-EntraDeviceRegisteredUser -DeviceId "8542ebd1-3d49-4073-9dce-30f197c67755" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }

        It "Should return specific device registered User" {
            $result = Get-EntraDeviceRegisteredUser -DeviceId "8542ebd1-3d49-4073-9dce-30f197c67755"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should return specific device registered User with alias" {
            $result = Get-EntraDeviceRegisteredUser -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when DeviceId is empty" {
            { Get-EntraDeviceRegisteredUser -DeviceId   } | Should -Throw "Missing an argument for parameter 'DeviceId'*"
        }
        It "Should fail when DeviceId is invalid" {
            { Get-EntraDeviceRegisteredUser -DeviceId "" } | Should -Throw "Cannot bind argument to parameter 'DeviceId' because it is an empty string.*"
        }
        It "Should return all device registered owner" {
            $result = Get-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
       
        It "Should return top device registered owner" {
            $result = Get-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when top is empty" {
            { Get-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when top is invalid" {
            { Get-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Result should contain Alias property" {
            $result = Get-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.DeletionTimestamp | should -Be $null
            $result.DirSyncEnabled | should -Be $null
            $result.ImmutableId | should -Be $null
            $result.LastDirSyncTime | should -Be $null
            $result.Mobile | should -Be "425-555-0100"
            $result.ProvisioningErrors | Should -BeNullOrEmpty
            $result.TelephoneNumber | should -Be "425-555-0100"
            $result.UserState | should -Be $null
            $result.UserStateChangedOn | should -Be $null

        }
        It "Should contain DeviceId in parameters when passed Name to it" { 

            $result = Get-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $Para= $params | ConvertTo-json | ConvertFrom-Json
            $para.URI  | Should -Match "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeviceRegisteredUser"

            $result = Get-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $a= $params | ConvertTo-json | ConvertFrom-Json
            $a.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeviceRegisteredUser"

            $result = Get-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeviceRegisteredUser"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It "Should fail when Property is empty" {
             { Get-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                {  Get-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  


    }

}

