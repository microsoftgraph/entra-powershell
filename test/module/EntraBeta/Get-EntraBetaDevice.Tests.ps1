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
              "Id"                            = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
              "OnPremisesSyncEnabled"         = $null
              "TrustType"                     = $null
              "OperatingSystemVersion"        = "10.0.22621.1700"
              "PhysicalIds"                   = "[HWID]:h:6825786449406074"
              "ComplianceExpirationDateTime"  = $null
              "DeviceVersion"                 = "2"
              "ApproximateLastSignInDateTime" = $null
              "OnPremisesLastSyncDateTime"    = $null
              "OperatingSystem"               = "WINDOWS"
              "DeletedDateTime"               = $null
              "DisplayName"                   = "Mock-Device"
              "Parameters"                    = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaDevice -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "Get-EntraBetaDevice" {
    Context "Test for Get-EntraBetaDevice" {
        It "Should return specific device" {
            $result = Get-EntraBetaDevice -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.DisplayName | should -Be "Mock-Device"

            Should -Invoke -CommandName Get-MgBetaDevice  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaDevice -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraBetaDevice -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return all applications" {
            $result = Get-EntraBetaDevice -All
            $result | Should -Not -BeNullOrEmpty  

            Should -Invoke -CommandName Get-MgBetaDevice  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        } 
        It "Should fail when All is invalid" {
            { Get-EntraBetaDevice -All xy } | Should -Throw "A positional parameter cannot be found that accepts argument 'xy'*"
        }

        It "Should fail when invalid parameter is passed" {
            { Get-EntraBetaDevice -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }       
        It "Should return specific application by searchstring" {
            $result = Get-EntraBetaDevice -SearchString 'Mock-Device'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-Device'

            Should -Invoke -CommandName Get-MgBetaDevice  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        } 
        It "Should fail when searchstring is empty" {
            { Get-EntraBetaDevice -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        }
        It "Should return specific application by filter" {
            $result = Get-EntraBetaDevice -Filter "DisplayName -eq 'Mock-Device'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-Device'

            Should -Invoke -CommandName Get-MgBetaDevice  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  
        It "Should fail when filter is empty" {
            { Get-EntraBetaDevice -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }

        It "Should return top application" {
            $result = Get-EntraBetaDevice -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDevice -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  
        It "Should fail when Top is empty" {
            { Get-EntraBetaDevice -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        } 
        It "Should fail when Top is invalid" {
            { Get-EntraBetaDevice -Top xy } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Result should Contain Alias properties" {
            $result = Get-EntraBetaDevice -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.ObjectId | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.DevicePhysicalIds | should -Be "[HWID]:h:6825786449406074"
            $result.DeviceObjectVersion | should -Be "2"
            $result.DeviceOSType | should -Be "WINDOWS"
            $result.DeviceOSVersion | should -Be "10.0.22621.1700"
            $result.DirSyncEnabled | should -BeNullOrEmpty
            $result.DeviceTrustType | should  -BeNullOrEmpty

        }     
        It "Should contain DeviceId in parameters when passed ObjectId to it" {              
            $result = Get-EntraBetaDevice -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.DeviceId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {               
            $result = Get-EntraBetaDevice -SearchString 'Mock-Device'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match 'Mock-Device'
        }
        It "Property parameter should work" {
            $result =  Get-EntraBetaDevice -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-Device'

            Should -Invoke -CommandName Get-MgBetaDevice -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraBetaDevice -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDevice"

            $result = Get-EntraBetaDevice -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDevice"

            Should -Invoke -CommandName Get-MgBetaDevice -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaDevice -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}