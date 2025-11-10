# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Users      
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
            "ServiceProvisioningErrors"        = @()
            "AssignedLicenses"                 = @([PSCustomObject]@{ skuId = 'sample-sku' })
            "licenseAssignmentStates"          = @([PSCustomObject]@{ error = 'None' })
        }

       
        $response = @{
            '@odata.context'        = 'Users()'
            Value                   = $valueObject
        }

        return @(
            $response
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Beta.Users
}
  
Describe "Get-EntraBetaUser" {
    Context "Test for Get-EntraBetaUser" {
        It "Should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Users
            { Get-EntraBetaUser -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 0
        }

        It "Should return specific user" {
            $result = Get-EntraBetaUser -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            Write-Verbose "Result : {$result}" -Verbose
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('bbbbbbbb-1111-2222-3333-cccccccccccc')

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should return specific user using external user principal name" {
            $result = Get-EntraBetaUser -UserId "externaluser_externaldomain.com#EXT#@contoso.com"
            Write-Verbose "Result : {$result}" -Verbose
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('bbbbbbbb-1111-2222-3333-cccccccccccc')

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUser"
            $result = Get-EntraBetaUser -Top 1
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUser"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It "Should fail when UserId is empty string value" {
            { Get-EntraBetaUser -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }

        It "Should fail when UserId is empty" {
            { Get-EntraBetaUser -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should return all contact" {
            $result = Get-EntraBetaUser -All
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraBetaUser -All $true} | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }

        It "Should return top user" {
            $result = Get-EntraBetaUser -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should fail when top is empty" {
            { Get-EntraBetaUser -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }

        It "Should fail when top is invalid" {
            { Get-EntraBetaUser -Top HH } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Should fail when Top is less than 1" {
            { Get-EntraBetaUser -Top 0 } | Should -Throw "Cannot validate argument on parameter 'Top'*"
        }
        
        It "Should fail when pagesize is empty" {
            { Get-EntraBetaUser -PageSize } | Should -Throw "Missing an argument for parameter 'PageSize'*"
        }

        It "Should fail when pagesize is invalid" {
            { Get-EntraBetaUser -PageSize HH } | Should -Throw "Cannot process argument transformation on parameter 'PageSize'*"
        }

        It "Should fail when pagesize is less than 1" {
            { Get-EntraBetaUser -PageSize 0 } | Should -Throw "Cannot validate argument on parameter 'PageSize'*"
        }

        It "Should fail when pagesize is greater than 999" {
            { Get-EntraBetaUser -PageSize 1000 } | Should -Throw "Cannot validate argument on parameter 'PageSize'*"
        }

        It "Should return user when pageSize is applied with all" {
            $result = Get-EntraBetaUser -All -PageSize 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should return user when pageSize is applied" {
            $result = Get-EntraBetaUser -PageSize 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should return specific user by filter" {
            $result = Get-EntraBetaUser -Filter "DisplayName eq 'Mock-User'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-User'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should return specific user by search string" {
            $result = Get-EntraBetaUser -SearchString "Mock-User"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-User'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Beta.Users -Times 1

        }

        It "Should fail when search string is empty" {
            { Get-EntraBetaUser -SearchString } | Should -Throw "Missing an argument for parameter 'SearchString'.*"
        }

        It "Should fail when Missing an argument for parameter Filter" {
            { Get-EntraBetaUser -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }

        It "Property parameter should work" {
            $result = Get-EntraBetaUser -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-User'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraBetaUser -Property } | Should -Throw "Missing an argument for parameter 'Property'.*"
        }

        It "Should contain UserId in parameters when passed UserId to it" {
            $result = Get-EntraBetaUser -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $UserId | Should -Be $null
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaUser -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
        It "Should execute successfully with Alias" {
            $result = Get-EntraBetaUser -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            Write-Verbose "Result : {$result}" -Verbose
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('bbbbbbbb-1111-2222-3333-cccccccccccc')

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should include accountEnabled eq true in filter when EnabledFilter EnabledOnly is used" {
            $result = Get-EntraBetaUser -EnabledFilter EnabledOnly -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $Uri | Should -Match 'accountEnabled eq true'
                $true
            }
        }

        It "Should include accountEnabled eq false in filter when EnabledFilter DisabledOnly is used" {
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -MockWith {
                param($Method, $Uri)
                return @{ value = @(@{ Id = 'cccccccc-1111-2222-3333-bbbbbbbbbbbb'; AccountEnabled = $false }) }
            } -Verifiable

            $result = Get-EntraBetaUser -EnabledFilter DisabledOnly -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $Uri | Should -Match 'accountEnabled eq false'
                $true
            }
        }

        It "Should include onPremisesSyncEnabled eq true in filter when Synchronized switch is used" {
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -MockWith {
                param($Method, $Uri)
                return @{ value = @(@{ Id = 'dddddddd-1111-2222-3333-aaaaaaaaaaaa'; OnPremisesSyncEnabled = $true }) }
            } -Verifiable

            $result = Get-EntraBetaUser -Synchronized -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $Uri | Should -Match 'onPremisesSyncEnabled eq true'
                $true
            }
        }

        It "Should combine EnabledFilter and Synchronized filters" {
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -MockWith {
                param($Method, $Uri)
                return @{ value = @(@{ Id = 'eeeeeeee-1111-2222-3333-aaaaaaaaaaaa'; AccountEnabled = $false; OnPremisesSyncEnabled = $true }) }
            } -Verifiable

            $result = Get-EntraBetaUser -EnabledFilter DisabledOnly -Synchronized -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1
        }

        It "Should return only users with ServiceProvisioningErrors when HasErrorsOnly is used" {
            $userWithErrors = [PSCustomObject]@{ Id = '11111111-1111-2222-3333-aaaaaaaaaaaa'; ServiceProvisioningErrors = @([PSCustomObject]@{ errorDetail = 'Generic error occurred' }) }
            $userWithoutErrors = [PSCustomObject]@{ Id = '22222222-1111-2222-3333-bbbbbbbbbbbb'; ServiceProvisioningErrors = @() }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -MockWith {
                return @{ value = @($userWithErrors, $userWithoutErrors) }
            } -Verifiable

            $result = Get-EntraBetaUser -HasErrorsOnly -Top 10
            $result | Should -Not -BeNullOrEmpty
            ($result.Id) | Should -Contain '11111111-1111-2222-3333-aaaaaaaaaaaa'
            ($result.Id) | Should -Not -Contain '22222222-1111-2222-3333-bbbbbbbbbbbb'
        }

        It "Should return only users needing license reconciliation when LicenseReconciliationNeededOnly is used" {
            $licenseErrorUser = [PSCustomObject]@{ Id = '33333333-1111-2222-3333-cccccccccccc'; licenseAssignmentStates = @([PSCustomObject]@{ error = 'MutuallyExclusiveViolation' }) }
            $nonLicenseErrorUser = [PSCustomObject]@{ Id = '44444444-1111-2222-3333-dddddddddddd'; licenseAssignmentStates = @([PSCustomObject]@{ error = 'None' }) }
            $noErrorsUser = [PSCustomObject]@{ Id = '55555555-1111-2222-3333-eeeeeeeeeeee'; licenseAssignmentStates = @() }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -MockWith {
                return @{ value = @($licenseErrorUser, $nonLicenseErrorUser, $noErrorsUser) }
            } -Verifiable

            $result = Get-EntraBetaUser -LicenseReconciliationNeededOnly -Top 10
            $result | Should -Not -BeNullOrEmpty
            ($result.Id) | Should -Contain '33333333-1111-2222-3333-cccccccccccc'
            ($result.Id) | Should -Not -Contain '44444444-1111-2222-3333-dddddddddddd'
            ($result.Id) | Should -Not -Contain '55555555-1111-2222-3333-eeeeeeeeeeee'
        }

        It "Should return empty when no users need license reconciliation" {
            $genericErrorUser = [PSCustomObject]@{ Id = '66666666-1111-2222-3333-ffffffffffff';  licenseAssignmentStates = @([PSCustomObject]@{ error = $null }) }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -MockWith {
                return @{ value = @($genericErrorUser) }
            } -Verifiable

            $result = Get-EntraBetaUser -LicenseReconciliationNeededOnly -Top 10
            $result | Should -BeNullOrEmpty
        }

        It "Should return only unlicensed users when UnlicensedUsersOnly is used" {
            $unlicensedUser = [PSCustomObject]@{ Id = '77777777-1111-2222-3333-aaaaaaaaaaaa'; AssignedLicenses = @() }
            $licensedUser = [PSCustomObject]@{ Id = '88888888-1111-2222-3333-bbbbbbbbbbbb'; AssignedLicenses = @([PSCustomObject]@{ skuId = 'sample-sku' }) }
            Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -MockWith {
                return @{ value = @($unlicensedUser, $licensedUser) }
            } -Verifiable

            $result = Get-EntraBetaUser -UnlicensedUsersOnly -Top 10
            $result | Should -Not -BeNullOrEmpty
            ($result.Id) | Should -Contain '77777777-1111-2222-3333-aaaaaaaaaaaa'
            ($result.Id) | Should -Not -Contain '88888888-1111-2222-3333-bbbbbbbbbbbb'
        }
    }

    Context "Parameter Set Validation Tests" {
        It "Should allow EnabledFilter with other GetFiltered parameters ONE" {
            { Get-EntraBetaUser -EnabledFilter EnabledOnly -HasErrorsOnly -Top 1 } | Should -Not -Throw
            { Get-EntraBetaUser -EnabledFilter DisabledOnly -LicenseReconciliationNeededOnly -Top 1 } | Should -Not -Throw  
            { Get-EntraBetaUser -EnabledFilter EnabledOnly -Synchronized -Top 1 } | Should -Not -Throw
            { Get-EntraBetaUser -EnabledFilter DisabledOnly -UnlicensedUsersOnly -Top 1 } | Should -Not -Throw
        }

        It "Should allow HasErrorsOnly with other GetFiltered parameters" {
            { Get-EntraBetaUser -HasErrorsOnly -LicenseReconciliationNeededOnly -Top 1 } | Should -Not -Throw
            { Get-EntraBetaUser -HasErrorsOnly -Synchronized -Top 1 } | Should -Not -Throw
            { Get-EntraBetaUser -HasErrorsOnly -UnlicensedUsersOnly -Top 1 } | Should -Not -Throw
        }

        It "Should allow LicenseReconciliationNeededOnly with other GetFiltered parameters" {
            { Get-EntraBetaUser -LicenseReconciliationNeededOnly -Synchronized -Top 1 } | Should -Not -Throw
            { Get-EntraBetaUser -LicenseReconciliationNeededOnly -UnlicensedUsersOnly -Top 1 } | Should -Not -Throw
        }

        It "Should allow all GetFiltered parameters together" {
            { Get-EntraBetaUser -EnabledFilter EnabledOnly -HasErrorsOnly -LicenseReconciliationNeededOnly -Synchronized -UnlicensedUsersOnly -Top 1 } | Should -Not -Throw
        }

        It "Should allow GetFiltered parameters with Top" {
            { Get-EntraBetaUser -EnabledFilter EnabledOnly -Top 5 } | Should -Not -Throw
            { Get-EntraBetaUser -HasErrorsOnly -Top 10 } | Should -Not -Throw
            { Get-EntraBetaUser -LicenseReconciliationNeededOnly -Top 15 } | Should -Not -Throw
            { Get-EntraBetaUser -Synchronized -Top 20 } | Should -Not -Throw
            { Get-EntraBetaUser -UnlicensedUsersOnly -Top 25 } | Should -Not -Throw
        }

        It "Should allow GetFiltered parameters with All" {
            { Get-EntraBetaUser -EnabledFilter DisabledOnly -All } | Should -Not -Throw
            { Get-EntraBetaUser -HasErrorsOnly -All } | Should -Not -Throw
            { Get-EntraBetaUser -LicenseReconciliationNeededOnly -All } | Should -Not -Throw
            { Get-EntraBetaUser -Synchronized -All } | Should -Not -Throw
            { Get-EntraBetaUser -UnlicensedUsersOnly -All } | Should -Not -Throw
        }

        It "Should allow GetFiltered parameters with Property" {
            { Get-EntraBetaUser -EnabledFilter EnabledOnly -Property DisplayName, Mail -Top 1 } | Should -Not -Throw
            { Get-EntraBetaUser -HasErrorsOnly -Property Id, AccountEnabled -Top 1 } | Should -Not -Throw
            { Get-EntraBetaUser -LicenseReconciliationNeededOnly -Property UserPrincipalName -Top 1 } | Should -Not -Throw
            { Get-EntraBetaUser -Synchronized -Property DisplayName, OnPremisesSyncEnabled -Top 1 } | Should -Not -Throw
            { Get-EntraBetaUser -UnlicensedUsersOnly -Property Id, AssignedLicenses -Top 1 } | Should -Not -Throw
        }

        It "Should allow GetFiltered parameters with PageSize" {
            { Get-EntraBetaUser -EnabledFilter EnabledOnly -PageSize 50 } | Should -Not -Throw
            { Get-EntraBetaUser -HasErrorsOnly -PageSize 100 } | Should -Not -Throw
            { Get-EntraBetaUser -LicenseReconciliationNeededOnly -PageSize 25 } | Should -Not -Throw
            { Get-EntraBetaUser -Synchronized -PageSize 75 } | Should -Not -Throw
            { Get-EntraBetaUser -UnlicensedUsersOnly -PageSize 150 } | Should -Not -Throw
        }

        It "Should fail when GetFiltered parameters are used with Filter (GetQuery parameter set)" {
            { Get-EntraBetaUser -EnabledFilter EnabledOnly -Filter "DisplayName eq 'test'" } | Should -Throw
            { Get-EntraBetaUser -HasErrorsOnly -Filter "AccountEnabled eq true" } | Should -Throw
            { Get-EntraBetaUser -LicenseReconciliationNeededOnly -Filter "Mail ne null" } | Should -Throw
            { Get-EntraBetaUser -Synchronized -Filter "OnPremisesSyncEnabled eq true" } | Should -Throw
            { Get-EntraBetaUser -UnlicensedUsersOnly -Filter "AssignedLicenses ne null" } | Should -Throw
        }

        It "Should fail when GetFiltered parameters are used with SearchString (GetVague parameter set)" {
            { Get-EntraBetaUser -EnabledFilter EnabledOnly -SearchString "testuser" } | Should -Throw
            { Get-EntraBetaUser -HasErrorsOnly -SearchString "example" } | Should -Throw
            { Get-EntraBetaUser -LicenseReconciliationNeededOnly -SearchString "user" } | Should -Throw
            { Get-EntraBetaUser -Synchronized -SearchString "syncuser" } | Should -Throw
            { Get-EntraBetaUser -UnlicensedUsersOnly -SearchString "unlicensed" } | Should -Throw
        }

        It "Should fail when GetFiltered parameters are used with UserId (GetById parameter set)" {
            { Get-EntraBetaUser -EnabledFilter EnabledOnly -UserId "test-user-id" } | Should -Throw
            { Get-EntraBetaUser -HasErrorsOnly -UserId "test-user-id" } | Should -Throw
            { Get-EntraBetaUser -LicenseReconciliationNeededOnly -UserId "test-user-id" } | Should -Throw
            { Get-EntraBetaUser -Synchronized -UserId "test-user-id" } | Should -Throw
            { Get-EntraBetaUser -UnlicensedUsersOnly -UserId "test-user-id" } | Should -Throw
        }
    }
}

