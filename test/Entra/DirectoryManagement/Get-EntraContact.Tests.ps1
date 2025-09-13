# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "DeletedDateTime"                 = $null
              "Id"                              = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
              "Department"                      = $null
              "GivenName"                       = $null
              "DisplayName"                     = "Bob Kelly (TAILSPIN)"
              "JobTitle"                        = $null
              "OnPremisesLastSyncDateTime"      = $null
              "MailNickname"                    = "BobKTAILSPIN"
              "Mail"                            = "bobk@tailspintoys.com"
              "Phones"                          = $null
              "ServiceProvisioningErrors"       = @{}
              "ProxyAddresses"                  = @{"SMTP"="bobk@tailspintoys.com"}
              "Surname"                         = $null
              "Addresses"                       = @{    "City"= ""
                                                        "CountryOrRegion" = ""
                                                        "OfficeLocation"= ""
                                                        "PostalCode"= ""
                                                        "State"= ""
                                                        "Street"= ""
                                                }
              "AdditionalProperties"            = @{
                                                    imAddresses = ""
                                                    "@odata.context" = "https://graph.microsoft.com/v1.0/`$metadata#contacts/`$entity"
                                                }
              "Manager"                         = $null
              "OnPremisesSyncEnabled"           = @{}
              "Parameters"                      = $args
            }
        )
        
    }  

    Mock -CommandName Get-MgContact -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('OrgContact.Read.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}
  
Describe "Get-EntraContact" {
    Context "Test for Get-EntraContact" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Get-EntraContact -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgContact -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }
        
        It "Should return specific Contact" {
            $result = Get-EntraContact -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result.OnPremisesSyncEnabled | Should -BeNullOrEmpty
            $result.OnPremisesLastSyncDateTime | Should -BeNullOrEmpty
            $result.Phones | Should -BeNullOrEmpty
            $result.ServiceProvisioningErrors | Should -BeNullOrEmpty
            $result.Mobile | Should -BeNullOrEmpty
            $result.TelephoneNumber | Should -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgContact -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }

        It "Should return specific Contact alias" {
            $result = Get-EntraContact -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result.OnPremisesSyncEnabled | Should -BeNullOrEmpty
            $result.OnPremisesLastSyncDateTime | Should -BeNullOrEmpty
            $result.Phones | Should -BeNullOrEmpty
            $result.ServiceProvisioningErrors | Should -BeNullOrEmpty
            $result.Mobile | Should -BeNullOrEmpty
            $result.TelephoneNumber | Should -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgContact -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }

        
        It "Should fail when OrgContactId is empty" {
            { Get-EntraContact -OrgContactId } | Should -Throw "Missing an argument for parameter 'OrgContactId'*"
        }

        It "Should fail when OrgContactId is invalid" {
            { Get-EntraContact -OrgContactId "" } | Should -Throw "Cannot bind argument to parameter 'OrgContactId' because it is an empty string."
        }

        It "Should return all contact" {
            $result = Get-EntraContact -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgContact  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraContact -All XY } | Should -Throw "A positional parameter cannot be found that accepts argument 'xy'.*"
        }

        It "Should return specific group by filter" {
            $result = Get-EntraContact -Filter "DisplayName -eq 'Bob Kelly (TAILSPIN)'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Bob Kelly (TAILSPIN)'

            Should -Invoke -CommandName Get-MgContact  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }  

        It "Should fail when filter is empty" {
            { Get-EntraContact -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }         

        It "Should return top contact" {
            $result = Get-EntraContact -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgContact  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraContact -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraContact -Top xy } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain OrgContactId" {
            $result = Get-EntraContact -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        } 

        It "Should contain OrgContactId in parameters when passed OrgContactId to it" {
            $result = Get-EntraContact -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $params = Get-Parameters -data $result.Parameters
            $params.OrgContactId | Should -Match "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }
        It "Property parameter should work" {
            $result = Get-EntraContact -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Bob Kelly (TAILSPIN)'

            Should -Invoke -CommandName Get-MgContact -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraContact -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraContact"

            $result = Get-EntraContact -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraContact"

            Should -Invoke -CommandName Get-MgContact -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Get-EntraContact -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}

