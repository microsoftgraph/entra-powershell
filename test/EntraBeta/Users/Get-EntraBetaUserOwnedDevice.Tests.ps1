# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null){
        Import-Module Microsoft.Entra.Beta.Users       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
              "DeletedDateTime"              = $null
              "AdditionalProperties"         = @{
                                                    "@odata.type"            = "#microsoft.graph.device"
                                                    "accountEnabled"         = $true
                                                    "deviceId"               = "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
                                                    "createdDateTime"        = "2024-01-18T08:50:28Z"
                                                    "deviceVersion"          = "2"
                                                    "displayName"            = "Mock-App"
                                                    "isCompliant"            = $false
                                                    "isManaged"              = $true
                                                    "operatingSystem"        = "WINDOWS"
                                                    "operatingSystemVersion" = "10.0.22621.1700"
                                                    "physicalIds"            = "[HWID]:h:6825786449406074"
                                                    "systemLabels"           = @{}
                                                    "extensionAttributes"    = $null
                                                 }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaUserOwnedDevice -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Users
}

Describe "Get-EntraBetaUserOwnedDevice" {
    Context "Test for Get-EntraBetaUserOwnedDevice" {
        It "Should return specific user registered device" {
            $result = Get-EntraBetaUserOwnedDevice -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result.AdditionalProperties.deviceId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgBetaUserOwnedDevice  -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when UserId is empty" {
            { Get-EntraBetaUserOwnedDevice -UserId    } | Should -Throw "Missing an argument for parameter 'UserId'*"
        }
        It "Should fail when UserId is invalid" {
            { Get-EntraBetaUserOwnedDevice -UserId  ""} | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }
        It "Should return All user registered devices" {
            $result = Get-EntraBetaUserOwnedDevice -UserId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -All
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaUserOwnedDevice  -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraBetaUserOwnedDevice -UserId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -All xyz } | Should -Throw "A positional parameter cannot be found that accepts argument 'xyz'.*"
        }
        It "Should return top 1 user registered device" {
            $result = Get-EntraBetaUserOwnedDevice -UserId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result.AdditionalProperties.deviceId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgBetaUserOwnedDevice  -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaUserOwnedDevice -UserId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraBetaUserOwnedDevice -UserId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should contain UserId in parameters when passed UserId to it" {              
            $result = Get-EntraBetaUserOwnedDevice -UserId  "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Property parameter should work" {
            $result =  Get-EntraBetaUserOwnedDevice -UserId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -Property Id
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be 'aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb'

            Should -Invoke -CommandName Get-MgBetaUserOwnedDevice -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }
        It "Should fail when Property is empty" {
             {  Get-EntraBetaUserOwnedDevice -UserId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserOwnedDevice"
            
            $result = Get-EntraBetaUserOwnedDevice -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserOwnedDevice"
            Should -Invoke -CommandName Get-MgBetaUserOwnedDevice -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
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
                { Get-EntraBetaUserOwnedDevice -UserId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}
 

