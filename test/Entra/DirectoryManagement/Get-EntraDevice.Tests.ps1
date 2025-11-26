# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-MgDevice with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "ComplianceExpirationDateTime"  = $null
                "AccountEnabled"                = $true
                "ApproximateLastSignInDateTime" = $null                
                "DeletedDateTime"               = $null
                "DeviceCategory"                = $null
                "DeviceId"                      = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                "DeviceMetadata"                = "MetaData"
                "DeviceOwnership"               = $null
                "DeviceVersion"                 = 2
                "DisplayName"                   = "Mock-Device"
                "EnrollmentProfileName"         = $null
                "Extensions"                    = $null
                "Id"                            = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
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

    Mock -CommandName Get-MgDevice -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Device.Read.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}
  
Describe "Get-EntraDevice" {
    Context "Test for Get-EntraDevice" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Get-EntraDevice -DeviceId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }
        
        It "Should return specific device" {
            $result = Get-EntraDevice -DeviceId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb')

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should return specific device with Alias" {
            $result = Get-EntraDevice -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when DeviceId is invalid" {
            { Get-EntraDevice -DeviceId "" } | Should -Throw "Cannot bind argument to parameter 'DeviceId' because it is an empty string."
        }
        It "Should fail when DeviceId is empty" {
            { Get-EntraDevice -DeviceId } | Should -Throw "Missing an argument for parameter 'DeviceId'*"
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
            
            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when All has an argument" {
            { Get-EntraDevice -All $true} | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }       
        It "Should return specific device by searchstring" {
            $result = Get-EntraDevice -SearchString 'Mock-Device'
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-Device'

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        } 
        It "Should return specific device by filter" {
            $result = Get-EntraDevice -Filter "DisplayName -eq 'Mock-Device'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-Device'

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }  
        It "Should return top device" {
            $result = Get-EntraDevice -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }  
        It "Property parameter should work" {
            $result = Get-EntraDevice -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-Device'

            Should -Invoke -CommandName Get-MgDevice  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraDevice -Property DisplayName -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Result should Contain ObjectId" {
            $result = Get-EntraDevice -DeviceId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ObjectId | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }     
        It "Should contain DeviceId in parameters when passed ObjectId to it" {              
            $result = Get-EntraDevice -DeviceId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.DeviceId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDevice"
            $result = Get-EntraDevice -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDevice"
            Should -Invoke -CommandName Get-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraDevice -SearchString 'Mock-Device' -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

        It "Should filter devices by LogonTimeBefore parameter" {
            $logonDate = (Get-Date).AddDays(-30)
            $result = Get-EntraDevice -LogonTimeBefore $logonDate
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Filter -like "*approximateLastSignInDateTime le*"
            }
        }

        It "Should filter stale devices (older than 2 months)" {
            $result = Get-EntraDevice -Stale
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Filter -like "*approximateLastSignInDateTime le*"
            }
        }

        It "Should filter non-compliant devices" {
            $result = Get-EntraDevice -NonCompliant
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Filter -like "*isCompliant eq false*"
            }
        }

        It "Should filter managed devices when IsManaged is true" {
            $result = Get-EntraDevice -IsManaged $true
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Filter -like "*isManaged eq True*"
            }
        }

        It "Should filter unmanaged devices when IsManaged is false" {
            $result = Get-EntraDevice -IsManaged $false
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Filter -like "*isManaged eq False*"
            }
        }

        It "Should filter Microsoft Entra Joined devices" {
            $result = Get-EntraDevice -JoinType "MicrosoftEntraJoined"
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Filter -like "*trustType eq 'AzureAd'*"
            }
        }

        It "Should filter Microsoft Entra Hybrid Joined devices" {
            $result = Get-EntraDevice -JoinType "MicrosoftEntraHybridJoined"
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Filter -like "*trustType eq 'ServerAd'*"
            }
        }

        It "Should filter Microsoft Entra Registered devices" {
            $result = Get-EntraDevice -JoinType "MicrosoftEntraRegistered"
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Filter -like "*trustType eq 'Workplace'*"
            }
        }

        It "Should fail when JoinType has invalid value" {
            { Get-EntraDevice -JoinType "InvalidType" } | Should -Throw "*Cannot validate argument on parameter 'JoinType'*"
        }

        It "Should combine multiple filter parameters correctly" {
            $logonDate = (Get-Date).AddDays(-30)
            $result = Get-EntraDevice -LogonTimeBefore $logonDate -NonCompliant -IsManaged $true
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Filter -like "*approximateLastSignInDateTime le*" -and
                $Filter -like "*isCompliant eq false*" -and
                $Filter -like "*isManaged eq True*"
            }
        }

        It "Should combine filter parameter with existing Filter parameter" {
            $result = Get-EntraDevice -Filter "DisplayName eq 'Mock-Device'" -Stale
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgDevice -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Filter -like "*DisplayName eq 'Mock-Device'*" -and
                $Filter -like "*approximateLastSignInDateTime le*"
            }
        }

        It "Should fail when LogonTimeBefore is empty" {
            { Get-EntraDevice -LogonTimeBefore } | Should -Throw "Missing an argument for parameter 'LogonTimeBefore'*"
        }

        It "Should fail when LogonTimeBefore has invalid format" {
            { Get-EntraDevice -LogonTimeBefore "invalid-date" } | Should -Throw "Cannot process argument transformation on parameter 'LogonTimeBefore'*"
        }

        It "Should fail when IsManaged is empty" {
            { Get-EntraDevice -IsManaged } | Should -Throw "Missing an argument for parameter 'IsManaged'*"
        }

        It "Should fail when JoinType is empty" {
            { Get-EntraDevice -JoinType } | Should -Throw "Missing an argument for parameter 'JoinType'*"
        }
    }
}

