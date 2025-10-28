# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        $valueObject = [PSCustomObject]@{
            "DisplayName"                      = "Mock-User"
            "AccountEnabled"                   = $true
            "Mail"                             = "User@aaabbbcccc.OnMicrosoft.com"
            "userPrincipalName"                = "User@aaabbbcccc.OnMicrosoft.com"
            "DeletedDateTime"                  = $null
            "CreatedDateTime"                  = $null
            "EmployeeId"                       = $null
            "Id"                               = "bbbbbbbb-1111-2222-3333-cccccccccccc"
            "Surname"                          = $null
            "MailNickName"                     = "User"
            "OnPremisesDistinguishedName"      = $null
            "OnPremisesSecurityIdentifier"     = $null
            "OnPremisesUserPrincipalName"      = $null
            "OnPremisesSyncEnabled"            = $false
            "onPremisesImmutableId"            = $null
            "OnPremisesLastSyncDateTime"       = $null
            "JobTitle"                         = $null
            "CompanyName"                      = $null
            "Department"                       = $null
            "Country"                          = $null
            "BusinessPhones"                   = @{}
            "OnPremisesProvisioningErrors"     = @{}
            "ImAddresses"                      = @{}
            "ExternalUserState"                = $null
            "ExternalUserStateChangeDateTime"  = $null
            "MobilePhone"                      = $null
        }

        $response = @{
            '@odata.context'        = 'Users()'
            Value                   = $valueObject
        }

        return @(
            $response
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Users
}
  
Describe "Get-EntraUser" {
    Context "Test for Get-EntraUser" {
        It "should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
            { Get-EntraUser -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 0
        }

        It "Should return specific user" {
            $result = Get-EntraUser -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            Write-Verbose "Result : {$result}" -Verbose
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('bbbbbbbb-1111-2222-3333-cccccccccccc')

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should execute successfully with Alias" {
            $result = Get-EntraUser -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            Write-Verbose "Result : {$result}" -Verbose
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('bbbbbbbb-1111-2222-3333-cccccccccccc')

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUser"

            $result = Get-EntraUser -Top 1
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUser"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It "Should fail when ObjectId is empty string value" {
            { Get-EntraUser -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraUser -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should return all contact" {
            $result = Get-EntraUser -All
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraUser -All $true} | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }

        It "Should return top user" {
            $result = Get-EntraUser -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when top is empty" {
            { Get-EntraUser -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }

        It "Should fail when top is invalid" {
            { Get-EntraUser -Top HH } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Should fail when Top is less than 1" {
            { Get-EntraUser -Top 0 } | Should -Throw "Cannot validate argument on parameter 'Top'*"
        }

        It "Should fail when pagesize is empty" {
            { Get-EntraUser -PageSize } | Should -Throw "Missing an argument for parameter 'PageSize'*"
        }

        It "Should fail when pagesize is invalid" {
            { Get-EntraUser -PageSize HH } | Should -Throw "Cannot process argument transformation on parameter 'PageSize'*"
        }

        It "Should fail when pagesize is less than 1" {
            { Get-EntraUser -PageSize 0 } | Should -Throw "Cannot validate argument on parameter 'PageSize'*"
        }

        It "Should fail when pagesize is greater than 999" {
            { Get-EntraUser -PageSize 1000 } | Should -Throw "Cannot validate argument on parameter 'PageSize'*"
        }

        It "Should return user when pageSize is applied with all" {
            $result = Get-EntraUser -All -PageSize 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should return user when pageSize is applied" {
            $result = Get-EntraUser -PageSize 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should return specific user by filter" {
            $result = Get-EntraUser -Filter "DisplayName eq 'Mock-User'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-User'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should return specific user by search string" {
            $result = Get-EntraUser -SearchString "Mock-User"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-User'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Users -Times 1

        }

        It "Should fail when search string is empty" {
            { Get-EntraUser -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'.*"
        }

        It "Should fail when Missing an argument for parameter Filter" {
            { Get-EntraUser -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }

        It "Property parameter should work" {
            $result = Get-EntraUser -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-User'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraUser -Property } | Should -Throw "Missing an argument for parameter 'Property'.*"
        }

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { 
                    Get-EntraUser -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug 
                } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }

        It "Should include accountEnabled eq true in filter when EnabledFilter EnabledOnly is used" {
            # Re-mock to capture URI
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -MockWith {
                param($Method, $Uri)
                # Return minimal mock response
                return @{ value = @(@{ Id = 'bbbbbbbb-1111-2222-3333-cccccccccccc'; AccountEnabled = $true }) }
            } -Verifiable

            $result = Get-EntraUser -EnabledFilter EnabledOnly -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
                # Assert that the generated URI contains the expected filter segment
                $Uri | Should -Match '\$filter=accountEnabled eq true'
                $true
            }
        }

        It "Should include accountEnabled eq false in filter when EnabledFilter DisabledOnly is used" {
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -MockWith {
                param($Method, $Uri)
                return @{ value = @(@{ Id = 'cccccccc-1111-2222-3333-bbbbbbbbbbbb'; AccountEnabled = $false }) }
            } -Verifiable

            $result = Get-EntraUser -EnabledFilter DisabledOnly -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
                $Uri | Should -Match '\$filter=accountEnabled eq false'
                $true
            }
        }

        It "Should include onPremisesSyncEnabled eq true in filter when Synchronized switch is used" {
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -MockWith {
                param($Method, $Uri)
                return @{ value = @(@{ Id = 'dddddddd-1111-2222-3333-aaaaaaaaaaaa'; OnPremisesSyncEnabled = $true }) }
            } -Verifiable

            $result = Get-EntraUser -Synchronized -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
                $Uri | Should -Match 'onPremisesSyncEnabled eq true'
                $true
            }
        }

        It "Should combine EnabledFilter and Synchronized filters" {
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -MockWith {
                param($Method, $Uri)
                return @{ value = @(@{ Id = 'eeeeeeee-1111-2222-3333-aaaaaaaaaaaa'; AccountEnabled = $false; OnPremisesSyncEnabled = $true }) }
            } -Verifiable

            $result = Get-EntraUser -EnabledFilter DisabledOnly -Synchronized -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
                $Uri | Should -Match 'accountEnabled eq false.*onPremisesSyncEnabled eq true'
                $true
            }
        }

        It "Should return only users with ServiceProvisioningErrors when HasErrorsOnly is used" {
            $userWithErrors = [PSCustomObject]@{ Id = '11111111-1111-2222-3333-aaaaaaaaaaaa'; ServiceProvisioningErrors = @([PSCustomObject]@{ errorDetail = 'Generic error occurred' }) }
            $userWithoutErrors = [PSCustomObject]@{ Id = '22222222-1111-2222-3333-bbbbbbbbbbbb'; ServiceProvisioningErrors = @() }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -MockWith {
                return @{ value = @($userWithErrors, $userWithoutErrors) }
            } -Verifiable

            $result = Get-EntraUser -HasErrorsOnly -Top 10
            $result | Should -Not -BeNullOrEmpty
            ($result.Id) | Should -Contain '11111111-1111-2222-3333-aaaaaaaaaaaa'
            ($result.Id) | Should -Not -Contain '22222222-1111-2222-3333-bbbbbbbbbbbb'
        }

        It "Should return only users needing license reconciliation when LicenseReconciliationNeededOnly is used" {
            $licenseErrorUser = [PSCustomObject]@{ Id = '33333333-1111-2222-3333-cccccccccccc'; ServiceProvisioningErrors = @([PSCustomObject]@{ errorDetail = 'insufficient licenses for service plan X' }) }
            $nonLicenseErrorUser = [PSCustomObject]@{ Id = '44444444-1111-2222-3333-dddddddddddd'; ServiceProvisioningErrors = @([PSCustomObject]@{ errorDetail = 'Generic non license error' }) }
            $noErrorsUser = [PSCustomObject]@{ Id = '55555555-1111-2222-3333-eeeeeeeeeeee'; ServiceProvisioningErrors = @() }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -MockWith {
                return @{ value = @($licenseErrorUser, $nonLicenseErrorUser, $noErrorsUser) }
            } -Verifiable

            $result = Get-EntraUser -LicenseReconciliationNeededOnly -Top 10
            $result | Should -Not -BeNullOrEmpty
            ($result.Id) | Should -Contain '33333333-1111-2222-3333-cccccccccccc'
            ($result.Id) | Should -Not -Contain '44444444-1111-2222-3333-dddddddddddd'
            ($result.Id) | Should -Not -Contain '55555555-1111-2222-3333-eeeeeeeeeeee'
        }

        It "Should return empty when no users need license reconciliation" {
            $genericErrorUser = [PSCustomObject]@{ Id = '66666666-1111-2222-3333-ffffffffffff'; ServiceProvisioningErrors = @([PSCustomObject]@{ errorDetail = 'Generic provisioning error' }) }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -MockWith {
                return @{ value = @($genericErrorUser) }
            } -Verifiable

            $result = Get-EntraUser -LicenseReconciliationNeededOnly -Top 10
            $result | Should -BeNullOrEmpty
        }

        It "Should return only unlicensed users when UnlicensedUsersOnly is used" {
            $unlicensedUser = [PSCustomObject]@{ Id = '77777777-1111-2222-3333-aaaaaaaaaaaa'; AssignedLicenses = @() }
            $licensedUser = [PSCustomObject]@{ Id = '88888888-1111-2222-3333-bbbbbbbbbbbb'; AssignedLicenses = @([PSCustomObject]@{ skuId = 'sample-sku' }) }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -MockWith {
                return @{ value = @($unlicensedUser, $licensedUser) }
            } -Verifiable

            $result = Get-EntraUser -UnlicensedUsersOnly -Top 10
            $result | Should -Not -BeNullOrEmpty
            ($result.Id) | Should -Contain '77777777-1111-2222-3333-aaaaaaaaaaaa'
            ($result.Id) | Should -Not -Contain '88888888-1111-2222-3333-bbbbbbbbbbbb'
        }
    }
}

