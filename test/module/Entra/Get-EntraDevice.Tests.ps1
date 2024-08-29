# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-MgDevice with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "ComplianceExpirationDateTime"  = $null
                "AccountEnabled"                = $true
                "ApproximateLastSignInDateTime" = $null                
                "DeletedDateTime"               = $null
                "DeviceCategory"                = $null
                "DeviceId"                      = "aaaaaaaa-1111-2222-3333-cccccccccccc"
                "DeviceMetadata"                = "MetaData"
                "DeviceOwnership"               = $null
                "DeviceVersion"                 = 2
                "DisplayName"                   = "Mock-Device"
                "EnrollmentProfileName"         = $null
                "Extensions"                    = $null
                "Id"                            = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "IsCompliant"                   = $False
                "IsManaged"                     = $True
                "MdmAppId"                      = $null
                "MemberOf"                      = $null
                "OnPremisesLastSyncDateTime"    = $null
                "OnPremisesSecurityIdentifier"  = $null
                "OnPremisesSyncEnabled"         = $false
                "OperatingSystem"               = "WINDOWS"
                "OperatingSystemVersion"        = "10.0.22621.1700"               
                "ProfileType"                   = $null
                "RegisteredOwners"              = $null
                "RegisteredUsers"               = $null
                "RegistrationDateTime"          = $null
                "TransitiveMemberOf"            = $null
                "TrustType"                     = $null
                "PhysicalIds"                   = @{}
                "Parameters"                    = $args
            }
        )
    }

    Mock -CommandName Get-MgDevice -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraDevice" {
    Context "Test for Get-EntraDevice" {
        It "Should return specific device" {
            $result = Get-EntraDevice -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('bbbbbbbb-1111-2222-3333-cccccccccccc')

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraDevice -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraDevice -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when searchstring is empty" {
            { Get-EntraDevice -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'*"
        } 
        It "Should fail when filter is empty" {
            { Get-EntraDevice -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should fail when Top is empty" {
            { Get-EntraDevice -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraDevice -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should return all devices" {
            $result = Get-EntraDevice -All
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraDevice -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }           
        It "Should return specific device by searchstring" {
            $result = Get-EntraDevice -SearchString 'Mock-Device'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-Device'

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        } 
        It "Should return specific device by filter" {
            $result = Get-EntraDevice -Filter "DisplayName -eq 'Mock-Device'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-Device'

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should return top device" {
            $result = @(Get-EntraDevice -Top 1)
            $result | Should -Not -BeNullOrEmpty
            $result | Should -HaveCount 1 

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraDevice -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }     
        It "Should contain DeviceId in parameters when passed ObjectId to it" {              
            $result = Get-EntraDevice -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.DeviceId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {               
            $result = Get-EntraDevice -SearchString 'Mock-Device'
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Mock-Device"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDevice"

            $result = Get-EntraDevice -SearchString 'Mock-Device'
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}