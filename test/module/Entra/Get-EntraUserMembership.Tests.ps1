# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "DeletedDateTime"       = ""
                "Id"                    = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
                "AdditionalProperties"  = @{
                    '@odata.type'       = '#microsoft.graph.administrativeUnit'
                    'displayName'       = "NEW2"
                    'description'       = "TEST221"
                }
                "Parameters"            = $args
            }
        )
    }    
    Mock -CommandName Get-MgUserMemberOf -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraUserMembership" {
    Context "Test for Get-EntraUserMembership" {
        It "Should return specific user membership" {
            $result = Get-EntraUserMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraUserMembership -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is invalid" {
            { Get-EntraUserMembership -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should return all user membership" {
            $result = Get-EntraUserMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All 
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All has an argument" {
            { Get-EntraUserMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }  
        
        It "Should return top user membership" {
            $result = Get-EntraUserMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top 5
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraUserMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraUserMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Result should Contain ObjectId" {
            $result = Get-EntraUserMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.ObjectId | should -Be "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
        } 

        It "Should contain UserId in parameters when passed ObjectId to it" {
            $result = Get-EntraUserMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }

        It "Property parameter should work" {
            $result =  Get-EntraUserMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property Id 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"

            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Property is empty" {
             {  Get-EntraUserMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserMembership"

            $result = Get-EntraUserMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserMembership"

            Should -Invoke -CommandName Get-MgUserMemberOf -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraUserMembership -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}