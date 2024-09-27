# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
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

    Mock -CommandName Get-MgBetaUserOwnedDevice -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaUserOwnedDevice" {
    Context "Test for Get-EntraBetaUserOwnedDevice" {
        It "Should return specific user registered device" {
            $result = Get-EntraBetaUserOwnedDevice -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result.AdditionalProperties.deviceId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgBetaUserOwnedDevice  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaUserOwnedDevice -ObjectId    } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraBetaUserOwnedDevice -ObjectId  ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return All user registered devices" {
            $result = Get-EntraBetaUserOwnedDevice -ObjectId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -All
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaUserOwnedDevice  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraBetaUserOwnedDevice -ObjectId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -All xyz } | Should -Throw "A positional parameter cannot be found that accepts argument 'xyz'.*"
        }
        It "Should return top 1 user registered device" {
            $result = Get-EntraBetaUserOwnedDevice -ObjectId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result.AdditionalProperties.deviceId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgBetaUserOwnedDevice  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaUserOwnedDevice -ObjectId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraBetaUserOwnedDevice -ObjectId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should contain UserId in parameters when passed ObjectId to it" {              
            $result = Get-EntraBetaUserOwnedDevice -ObjectId  "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Property parameter should work" {
            $result =  Get-EntraBetaUserOwnedDevice -ObjectId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -Property Id
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be 'aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb'

            Should -Invoke -CommandName Get-MgBetaUserOwnedDevice -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Property is empty" {
             {  Get-EntraBetaUserOwnedDevice -ObjectId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserOwnedDevice"
            
            $result = Get-EntraBetaUserOwnedDevice -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserOwnedDevice"
            Should -Invoke -CommandName Get-MgBetaUserOwnedDevice -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaUserOwnedDevice -ObjectId  "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}
 