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
              "Id"                              = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
              "DeletedDateTime"                 = $null
              "AdditionalProperties"            = @{"@odata.type" ="#microsoft.graph.group"
                                                    "DisplayName"                     = "All Employees"
                                                    "MailNickname"                    = "Employees"
                                                    "Mail"                            = "Employees@M365x99297270.OnMicrosoft.com"
                                                    "onPremisesProvisioningErrors"    = @{}
                                                    "ProxyAddresses"                  = @{SMTP="Employees@M365x99297270.OnMicrosoft.com"}
                                                    "SecurityEnabled"                 = "False"
                                                }
              "Parameters"                      = $args
            }
        )
        
    }  

    Mock -CommandName Get-MgContactMemberOf -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('OrgContact.Read.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}
  
Describe "Get-EntraContactMembership" {
    Context "Test for Get-EntraContactMembership" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Get-EntraContactMembership -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgContactMemberOf -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }

        It "Should return specific Contact Membership" {
            $result = Get-EntraContactMembership -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result.DeletedDateTime | Should -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgContactMemberOf -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }

        It "Should return specific Contact Membership with alias" {
            $result = Get-EntraContactMembership -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
            $result.DeletedDateTime | Should -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgContactMemberOf -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        
        It "Should fail when OrgContactId is invalid" {
            { Get-EntraContactMembership -OrgContactId "" } | Should -Throw "Cannot bind argument to parameter 'OrgContactId' because it is an empty string."
        }

        It "Should return all Contact Membership" {
            $result = Get-EntraContactMembership -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgContactMemberOf -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraContactMembership -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -All XY } | Should -Throw "A positional parameter cannot be found that accepts argument 'xy'.*"
        }

        It "Should return top Contact Membership" {
            $result = Get-EntraContactMembership -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgContactMemberOf -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraContactMembership -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraContactMembership -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Top DF } | Should -Throw  "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraContactMembership -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        } 

        It "Should contain OrgContactId in parameters when passed OrgContactId to it" {
            $result = Get-EntraContactMembership -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $params = Get-Parameters -data $result.Parameters
            $params.OrgContactId | Should -Match "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }

        It "Property parameter should work" {
            $result = Get-EntraContactMembership -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property Id
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'

            Should -Invoke -CommandName Get-MgContactMemberOf -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        
        It "Should fail when Property is empty" {
             { Get-EntraContactMembership -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraContactMembership"

            $result = Get-EntraContactMembership -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraContactMembership"

            Should -Invoke -CommandName Get-MgContactMemberOf -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Get-EntraContactMembership -OrgContactId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   

    }
}

