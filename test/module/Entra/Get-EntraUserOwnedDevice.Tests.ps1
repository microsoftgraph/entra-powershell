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
                "Id"                           = "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
                "DeletedDateTime"              = $null
                "AdditionalProperties"         = @{
                                                      "@odata.type"            = "#microsoft.graph.device"
                                                      "accountEnabled"         = $true
                                                      "createdDateTime"        = "2024-01-18T08:50:28Z"
                                                      "deviceId"               = "aaaaaaaa-3333-4444-5555-bbbbbbbbbbbb"
                                                      "deviceMetadata"         = "MetaData"
                                                      "deviceVersion"          = "2"
                                                      "displayName"            = "Sawyer Miller"
                                                      "isCompliant"            = $false
                                                      "isManaged"              = $true
                                                      "operatingSystem"        = "WINDOWS"
                                                      "operatingSystemVersion" = "10.0.22621.1700"
                                                      "physicalIds"            = @(
                                                                                    "[HWID]:h:6825786449406074"
                                                                                    "[USER-HWID]:7f08336b-29ed-4297-bb1f-60520d34577f:6825786449406074"
                                                                                    "[GID]:g:6966518641169130"
                                                                                  )
                                                      "systemLabels"           = @{}
                                                      "extensionAttributes"    = $null
                                                      "alternativeSecurityIds" = @(
                                                                                    @{
                                                                                        "type" = 2
                                                                                        "key"  = "dGVzdA=="
                                                                                    }
                                                                                  )
                                                   }
                "Parameters"                   = $args
            }
        )
    }    
    Mock -CommandName Get-MgUserOwnedDevice -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraUserOwnedDevice" {
Context "Test for Get-EntraUserOwnedDevice" {
        It "Should get devices owned by a user" {
            $result = Get-EntraUserOwnedDevice -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
            $result.AdditionalProperties.deviceId | Should -Be "aaaaaaaa-3333-4444-5555-bbbbbbbbbbbb"
            $result.AdditionalProperties.displayName | Should -Be "Sawyer Miller"

            Should -Invoke -CommandName Get-MgUserOwnedDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Property parameter should work" {
            $result = Get-EntraUserOwnedDevice -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Property DisplayName
            $result.Id | Should -Be 'aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb'
        }

        It "Should fail when ObjectlId is empty" {
            { Get-EntraUserOwnedDevice -ObjectId    } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectlId is invalid" {
            { Get-EntraUserOwnedDevice -ObjectId  ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should get all devices owned by a user" {
            $result = Get-EntraUserOwnedDevice -ObjectId  "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -All
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Contain "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"

            Should -Invoke -CommandName Get-MgUserOwnedDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraGroup -All $true} | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }

        It "Should get top one device owned by a user" {
            $result = Get-EntraUserOwnedDevice -ObjectId  "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
            $result.AdditionalProperties.deviceId | Should -Be "aaaaaaaa-3333-4444-5555-bbbbbbbbbbbb"
            $result.AdditionalProperties.displayName | Should -Be "Sawyer Miller"

            Should -Invoke -CommandName Get-MgUserOwnedDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Top is empty" {
            { Get-EntraUserOwnedDevice -ObjectId  "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }

        It "Should fail when Top is invalid" {
            { Get-EntraUserOwnedDevice -ObjectId  "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Top "XCX" } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Should contain UserId in parameters when passed ObjectId to it" {              
            $result = Get-EntraUserOwnedDevice -ObjectId  "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserOwnedDevice"
            $result = Get-EntraUserOwnedDevice -ObjectId  "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserOwnedDevice"
            Should -Invoke -CommandName Get-MgUserOwnedDevice -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraUserOwnedDevice -ObjectId  "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}