# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        #Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module .\test_legacy\module\Common-Functions.ps1 -Force

    Mock -CommandName Remove-MgDeviceRegisteredUserByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Remove-EntraDeviceRegisteredUser" {
    Context "Test for Remove-EntraDeviceRegisteredUser" {
        It "Should return empty object" {
            $result = Remove-EntraDeviceRegisteredUser -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDeviceRegisteredUserByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should execute successfully with Alias" {
            $result = Remove-EntraDeviceRegisteredUser -ObjectId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Remove-MgDeviceRegisteredUserByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when DeviceId is empty" {
            { Remove-EntraDeviceRegisteredUser -DeviceId   -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc" | Should -Throw "Missing an argument for parameter 'DeviceId'*" }
        }
        It "Should fail when DeviceId is invalid" {
            { Remove-EntraDeviceRegisteredUser -DeviceId  "" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc" | Should -Throw "Cannot bind argument to parameter 'DeviceId' because it is an empty string.*" }
        }
        It "Should fail when UserId is empty" {
            { Remove-EntraDeviceRegisteredUser -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId  | Should -Throw "Missing an argument for parameter 'UserId'*" }
        }
        It "Should fail when UserId is invalid" {
            { Remove-EntraDeviceRegisteredUser -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "" | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string.*" }
        }  
        It "Should contain DeviceId in parameters when passed UserId to it" {
            Mock -CommandName Remove-MgDeviceRegisteredUserByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraDeviceRegisteredUser -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.DeviceId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        } 
        It "Should contain DirectoryObjectId in parameters when passed UserId to it" {
            Mock -CommandName Remove-MgDeviceRegisteredUserByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Remove-EntraDeviceRegisteredUser -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.DirectoryObjectId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDeviceRegisteredUser"

            Remove-EntraDeviceRegisteredUser -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Remove-EntraDeviceRegisteredUser"

            Should -Invoke -CommandName Remove-MgDeviceRegisteredUserByRef -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Remove-EntraDeviceRegisteredUser -DeviceId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}