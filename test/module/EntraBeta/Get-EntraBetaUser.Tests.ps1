# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null) {
        Import-Module Microsoft.Graph.Entra.Beta      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
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

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}
  
Describe "Get-EntraBetaUser" {
    Context "Test for Get-EntraBetaUser" {
        It "Should return specific user" {
            $result = Get-EntraBetaUser -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            Write-Verbose "Result : {$result}" -Verbose
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('bbbbbbbb-1111-2222-3333-cccccccccccc')

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUser"
            $result = Get-EntraBetaUser -Top 1
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUser"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It "Should fail when ObjectId is empty string value" {
            { Get-EntraBetaUser -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaUser -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should return all contact" {
            $result = Get-EntraBetaUser -All
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraBetaUser -All $true} | Should -Throw "A positional parameter cannot be found that accepts argument 'True'."
        }

        It "Should return top user" {
            $result = Get-EntraBetaUser -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when top is empty" {
            { Get-EntraBetaUser -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }

        It "Should fail when top is invalid" {
            { Get-EntraBetaUser -Top HH } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Should return specific user by filter" {
            $result = Get-EntraBetaUser -Filter "DisplayName eq 'Mock-User'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-User'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should return specific user by search string" {
            $result = Get-EntraBetaUser -SearchString "Mock-User"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock-User'

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra.Beta -Times 1

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

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraBetaUser -Property } | Should -Throw "Missing an argument for parameter 'Property'.*"
        }

        It "Should contain UserId in parameters when passed ObjectId to it" {
            $result = Get-EntraBetaUser -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaUser -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}