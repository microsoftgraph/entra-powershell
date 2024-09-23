# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
              "DeletedDateTime"              = $null
              "AdditionalProperties"         = @{
                                                  "@odata.type"          = "#microsoft.graph.group"
                                                  "displayName"          = "Mock-Membership"
                                                  "description"          = "MockData"
                                                  "organizationId"       = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                                                  "createdByAppId"       = "00001111-aaaa-2222-bbbb-3333cccc4444"
                                                  "mailEnabled"          =  $False
                                                  "securityEnabled"      =  $True
                                                  "renewedDateTime"      = "2023-10-18T07:21:48Z"
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaUserMemberOf -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaUserMembership" {
    Context "Test for Get-EntraBetaUserMembership" {
        It "Should return specific user membership" {
            $result = Get-EntraBetaUserMembership -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result.AdditionalProperties.DisplayName | Should -Be "Mock-Membership"
            $result.AdditionalProperties."@odata.type" | Should -Be "#microsoft.graph.group"

            Should -Invoke -CommandName Get-MgBetaUserMemberOf -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaUserMembership -ObjectId   } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraBetaUserMembership -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return all user memberships" {
            $result = Get-EntraBetaUserMembership -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -All
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgBetaUserMemberOf -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
         It "Should fail when All is invalid" {
            { Get-EntraBetaUserMembership -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -All xyz } | Should -Throw "A positional parameter cannot be found that accepts argument 'xyz'.*"
        }
        It "Should return top 1 user memberships" {
            $result = Get-EntraBetaUserMembership -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"

            Should -Invoke -CommandName Get-MgBetaUserMemberOf -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaUserMembership -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraBetaUserMembership -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaUserMembership -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.ObjectId | should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        It "Should contain UserId in parameters when passed ObjectId to it" {    
            
            $result = Get-EntraBetaUserMembership -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Property parameter should work" {
            $result =  Get-EntraBetaUserMembership -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Property Id
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be 'aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb'

            Should -Invoke -CommandName Get-MgBetaUserMemberOf -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraBetaUserMembership -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserMembership"
            
            $result = Get-EntraBetaUserMembership -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserMembership"
            Should -Invoke -CommandName Get-MgBetaUserMemberOf -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaUserMembership -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}   