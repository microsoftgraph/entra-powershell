# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgDeviceRegisteredUserByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Add-EntraDeviceRegisteredUser" {
    Context "Test for Add-EntraDeviceRegisteredUser" {
        It "Should return empty object" {
            $result = Add-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgDeviceRegisteredUserByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when DeviceId is empty" {
            { Add-EntraDeviceRegisteredUser -DeviceId  -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"  } | Should -Throw "Missing an argument for parameter 'DeviceId'.*"
        }
        It "Should fail when DeviceId is invalid" {
            { Add-EntraDeviceRegisteredUser -DeviceId "" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"  } | Should -Throw "Cannot bind argument to parameter 'DeviceId' because it is an empty string."
        }
        It "Should fail when RefObjectId is empty" {
            { Add-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId   } | Should -Throw "Missing an argument for parameter 'RefObjectId'.*"
        }
        It "Should fail when RefObjectId is invalid" {
            { Add-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }
        It "Should execute successfully with Alias" {
            $result = Add-EntraDeviceRegisteredUser -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgDeviceRegisteredUserByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should contain DeviceId in parameters when passed DeviceId to it" {
            Mock -CommandName New-MgDeviceRegisteredUserByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Add-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result
            $params.DeviceId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain BodyParameter in parameters when passed RefObjectId to it" {
            Mock -CommandName New-MgDeviceRegisteredUserByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            Add-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
             $value = @{
                "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/bbbbbbbb-1111-2222-3333-cccccccccccc"}
            Should -Invoke -CommandName New-MgDeviceRegisteredUserByRef -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $BodyParameter.AdditionalProperties.'@odata.id' | Should -Be $value.'@odata.id'
                Write-Host $BodyParameter.AdditionalProperties.'@odata.id'
                $true
            }    
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraDeviceRegisteredUser"

            Add-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraDeviceRegisteredUser"

            Should -Invoke -CommandName New-MgDeviceRegisteredUserByRef -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Add-EntraDeviceRegisteredUser -DeviceId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -RefObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  

    }

}        