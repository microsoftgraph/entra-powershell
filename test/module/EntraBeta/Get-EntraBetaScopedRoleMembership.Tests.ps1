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
              "Id"                           = "zTVcE8KFQ0W4bI9tvt6kz9Es_cQCeeJLolvVzF_5NRdnAVb9H_8aR410OwBwq86hU"
              "RoleId"                       = "cccccccc-85c2-4543-b86c-cccccccccccc"
              "AdministrativeUnitId"         = "dddddddd-7902-4be2-a25b-dddddddddddd"

              "RoleMemberInfo"               = @{
                                                  "DisplayName"          = "Conf Room Adams"
                                                  "Id"                   = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
                                                  "AdditionalProperties" = @{"userPrincipalName" = "Adams@M365x99297270.OnMicrosoft.com" }  
                                                }
              "AdditionalProperties"         = @{"@odata.context"  = 'https://graph.microsoft.com/beta/$metadata#scopedRoleMemberships/$entity]'}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaDirectoryAdministrativeUnitScopedRoleMember -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaScopedRoleMembership" {
    Context "Test for Get-EntraBetaScopedRoleMembership" {
        It "Should return specific scoped role membership" {
            $result = Get-EntraBetaScopedRoleMembership -ObjectId "dddddddd-1111-2222-3333-eeeeeeeeeeee" -ScopedRoleMembershipId "zTVcE8KFQ0W4bI9tvt6kz9Es_cQCeeJLolvVzF_5NRdnAVb9H_8aR410OwBwq86hU"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "zTVcE8KFQ0W4bI9tvt6kz9Es_cQCeeJLolvVzF_5NRdnAVb9H_8aR410OwBwq86hU"
            $result.RoleId | Should -Be "cccccccc-85c2-4543-b86c-cccccccccccc"
            $result.AdministrativeUnitId | Should -Be "dddddddd-7902-4be2-a25b-dddddddddddd"

            Should -Invoke -CommandName Get-MgBetaDirectoryAdministrativeUnitScopedRoleMember -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaScopedRoleMembership -ObjectId  } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraBetaScopedRoleMembership -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when ScopedRoleMembershipId is empty" {
            { Get-EntraBetaScopedRoleMembership -ObjectId "dddddddd-1111-2222-3333-eeeeeeeeeeee" -ScopedRoleMembershipId   } | Should -Throw "Missing an argument for parameter 'ScopedRoleMembershipId'*"
        }
        It "Should fail when ScopedRoleMembershipId is invalid" {
            { Get-EntraBetaScopedRoleMembership -ObjectId "dddddddd-1111-2222-3333-eeeeeeeeeeee" -ScopedRoleMembershipId "" } | Should -Throw "Cannot bind argument to parameter 'ScopedRoleMembershipId' because it is an empty string."
        }
        It "Should contain AdministrativeUnitId in parameters when passed ObjectId to it" {    
            
            $result = Get-EntraBetaScopedRoleMembership -ObjectId "dddddddd-1111-2222-3333-eeeeeeeeeeee" -ScopedRoleMembershipId "zTVcE8KFQ0W4bI9tvt6kz9Es_cQCeeJLolvVzF_5NRdnAVb9H_8aR410OwBwq86hU"
            $params = Get-Parameters -data $result.Parameters
            $params.AdministrativeUnitId | Should -Be "dddddddd-1111-2222-3333-eeeeeeeeeeee"
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaScopedRoleMembership -ObjectId "dddddddd-1111-2222-3333-eeeeeeeeeeee" -ScopedRoleMembershipId "zTVcE8KFQ0W4bI9tvt6kz9Es_cQCeeJLolvVzF_5NRdnAVb9H_8aR410OwBwq86hU" -Property RoleId
            $result | Should -Not -BeNullOrEmpty
            $result.RoleId | Should -Be 'cccccccc-85c2-4543-b86c-cccccccccccc'

            Should -Invoke -CommandName Get-MgBetaDirectoryAdministrativeUnitScopedRoleMember -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraBetaScopedRoleMembership -ObjectId "dddddddd-1111-2222-3333-eeeeeeeeeeee" -ScopedRoleMembershipId "zTVcE8KFQ0W4bI9tvt6kz9Es_cQCeeJLolvVzF_5NRdnAVb9H_8aR410OwBwq86hU" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaScopedRoleMembership"

            $result =  Get-EntraBetaScopedRoleMembership -ObjectId "dddddddd-1111-2222-3333-eeeeeeeeeeee" -ScopedRoleMembershipId "zTVcE8KFQ0W4bI9tvt6kz9Es_cQCeeJLolvVzF_5NRdnAVb9H_8aR410OwBwq86hU"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaScopedRoleMembership"

            Should -Invoke -CommandName Get-MgBetaDirectoryAdministrativeUnitScopedRoleMember -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaScopedRoleMembership -ObjectId "dddddddd-1111-2222-3333-eeeeeeeeeeee" -ScopedRoleMembershipId "zTVcE8KFQ0W4bI9tvt6kz9Es_cQCeeJLolvVzF_5NRdnAVb9H_8aR410OwBwq86hU" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 

    }
}   