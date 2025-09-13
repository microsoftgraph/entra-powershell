
# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                               = "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
                    "onPremisesImmutableId"            = $null
                    "deletedDateTime"                  = $null
                    "onPremisesSyncEnabled"            = $null
                    "mobilePhone"                      = "425-555-0101"
                    "onPremisesProvisioningErrors"     = @{}
                    "businessPhones"                   = @("425-555-0100")
                    "externalUserState"                = $null
                    "externalUserStateChangeDate"      = $null
                    "Parameters"                       = $args
                }
            )
        }
    }
    

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Domain.Read.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}



Describe "Get-EntraDomainNameReference" {
    Context "Test for Get-EntraDomainNameReference" {
        It "Should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Get-EntraDomainNameReference -Name "M365x99297270.mail.onmicrosoft.com" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }

        It "Should return specific domain Name Reference" {
            $result = Get-EntraDomainNameReference -Name "M365x99297270.mail.onmicrosoft.com"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '22cc22cc-dd33-ee44-ff55-66aa66aa66aa'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when Name is empty" {
            { Get-EntraDomainNameReference -Name  } | Should -Throw "Missing an argument for parameter 'Name'*"
        }
        It "Should fail when Name is invalid" {
            { Get-EntraDomainNameReference -Name "" } | Should -Throw "Cannot bind argument to parameter 'Name' because it is an empty string.*"
        }
        It "Result should Contain Alias property" {
            $result = Get-EntraDomainNameReference -Name "M365x99297270.mail.onmicrosoft.com"
            $result.ObjectId | should -Be "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
            $result.DeletionTimestamp | should -Be $null
            $result.DirSyncEnabled | should -Be $null
            $result.ImmutableId | should -Be $null
            $result.Mobile | should -Be "425-555-0101"
            $result.ProvisioningErrors | Should -BeNullOrEmpty
            $result.TelephoneNumber | should -Be "425-555-0100"
            $result.UserState | should -Be $null
            $result.UserStateChangedOn | should -Be $null

        }
        It "Should contain DomainId in parameters when passed Name to it" { 

            $result = Get-EntraDomainNameReference -Name "M365x99297270.mail.onmicrosoft.com" 
            $params = Get-Parameters -data $result.Parameters
            $para= $params | ConvertTo-json | ConvertFrom-Json
            $para.Uri -match "M365x99297270.mail.onmicrosoft.com" | Should -BeTrue
        }
        It "Property parameter should work" {
            $result = Get-EntraDomainNameReference -Name "M365x99297270.mail.onmicrosoft.com" -Property Id
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be '22cc22cc-dd33-ee44-ff55-66aa66aa66aa'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraDomainNameReference -Name "M365x99297270.mail.onmicrosoft.com" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDomainNameReference"

            Get-EntraDomainNameReference -Name "M365x99297270.mail.onmicrosoft.com"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDomainNameReference"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Get-EntraDomainNameReference -Name "M365x99297270.mail.onmicrosoft.com"  -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }


    }

}

