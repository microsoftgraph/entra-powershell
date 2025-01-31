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
              "DisplayName"                  = "Mock-Admin-Unit"
              "Description"                  = "NewAdministrativeUnit"
              "DeletedDateTime"              = $null
              "IsMemberManagementRestricted" = $null
              "Members"                      = $null
              "ScopedRoleMembers"            = $null
              "Visibility"                   = $null
              "AdditionalProperties"         = @{"@odata.context"  = 'https://graph.microsoft.com/beta/$metadata#scopedRoleMemberships/$entity]'}
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName New-MgBetaAdministrativeUnit -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaAdministrativeUnit" {
    Context "Test for New-EntraBetaAdministrativeUnit" {
        It "Should return created administrative unit" {
            $result = New-EntraBetaAdministrativeUnit -DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit" -IsMemberManagementRestricted $True
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result.DisplayName | Should -Be "Mock-Admin-Unit"
            $result.Description | Should -Be "NewAdministrativeUnit"

            Should -Invoke -CommandName New-MgBetaAdministrativeUnit -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when DisplayName is empty" {
            { New-EntraBetaAdministrativeUnit -DisplayName  -Description "NewAdministrativeUnit"  } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        }
        It "Should fail when DisplayName is invalid" {
            { New-EntraBetaAdministrativeUnit -DisplayName "" -Description "NewAdministrativeUnit" } | Should -Throw "Cannot bind argument to parameter 'DisplayName' because it is an empty string."
        }
        It "Should fail when Description is empty" {
            { New-EntraBetaAdministrativeUnit -DisplayName "Mock-Admin-Unit" -Description   } | Should -Throw "Missing an argument for parameter 'Description'*"
        }
        It "Should fail when IsMemberManagementRestricted is empty" {
            { New-EntraBetaAdministrativeUnit -DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit" -IsMemberManagementRestricted  } | Should -Throw "Missing an argument for parameter 'IsMemberManagementRestricted'*"
        }
        It "Should fail when IsMemberManagementRestricted is invalid" {
            { New-EntraBetaAdministrativeUnit -DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit" -IsMemberManagementRestricted "" } | Should -Throw "Cannot process argument transformation on parameter 'IsMemberManagementRestricted'.*"
        }
        It "Result should contain ObjectId"{
            $result = New-EntraBetaAdministrativeUnit -DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit"
            $result.ObjectId | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAdministrativeUnit"
            
            $result = New-EntraBetaAdministrativeUnit -DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAdministrativeUnit"
            Should -Invoke -CommandName New-MgBetaAdministrativeUnit -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { New-EntraBetaAdministrativeUnit -DisplayName "Mock-Admin-Unit" -Description "NewAdministrativeUnit" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}   