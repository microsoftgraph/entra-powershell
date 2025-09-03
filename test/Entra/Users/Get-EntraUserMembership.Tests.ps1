# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DeletedDateTime"      = ""
                "Id"                   = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
                "AdditionalProperties" = @{
                    '@odata.type' = '#microsoft.graph.administrativeUnit'
                    'displayName' = "NEW2"
                    'description' = "TEST221"
                }
                "Parameters"           = $args
            }
        )
    }    
    Mock -CommandName Get-MgUserMemberOf -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Users
}
  
Describe "Get-EntraUserMembership" {
    Context "Test for Get-EntraUserMembership" {
        It "should throw when not connected and not invoke sdk" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
            { Get-EntraUserMembership -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Entra.Users -Times 0
        }

        It "Should return specific user membership" {
            $result = Get-EntraUserMembership -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should return specific user membership with alias" {
            $result = Get-EntraUserMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when UserId is empty" {
            { Get-EntraUserMembership -UserId } | Should -Throw "Missing an argument for parameter 'UserId'*"
        }

        It "Should return all user membership" {
            $result = Get-EntraUserMembership -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraUserMembership -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }  
        
        It "Should return top user membership" {
            $result = Get-EntraUserMembership -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 5
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Entra.Users -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraUserMembership -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraUserMembership -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraUserMembership -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.ObjectId | should -Be "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
        } 

        It "Should contain UserId in parameters when passed UserId to it" {
            $result = Get-EntraUserMembership -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }

        It "Property parameter should work" {
            $result = Get-EntraUserMembership -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property Id 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"

            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraUserMembership -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserMembership"

            $result = Get-EntraUserMembership -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserMembership"

            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { Get-EntraUserMembership -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}

