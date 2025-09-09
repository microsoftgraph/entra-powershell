# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.Beta.DirectoryManagement       
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "bbbbbbbb-1111-2222-3333-cccccccccccc"
              "DeletedDateTime"              = $null
              "AdditionalProperties"         = @{
                                                  "@odata.type"          = "#microsoft.graph.user"
                                                  "displayName"          = "Mock-UnitMember"
                                                  "mailEnabled"          =  $True
                                                  "isManagementRestricted"=  $False
                                                  "renewedDateTime"      = "2023-10-18T07:21:48Z"
                                                  "mobilePhone"          = "425-555-0101"
                                                  "businessPhones"       = {"425-555-0101"}
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaAdministrativeUnitMember -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('AdministrativeUnit.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Get-EntraBetaAdministrativeUnitMember" {
    Context "Test for Get-EntraBetaAdministrativeUnitMember" {
        It "Should return specific administrative unit member" {
            $result = Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "pppppppp-1111-1111-1111-aaaaaaaaaaaa"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.AdditionalProperties.DisplayName | Should -Be "Mock-UnitMember"
            $result.AdditionalProperties."@odata.type" | Should -Be "#microsoft.graph.user"

            Should -Invoke -CommandName Get-MgBetaAdministrativeUnitMember -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should return specific administrative unit member with alias" {
            $result = Get-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.AdditionalProperties.DisplayName | Should -Be "Mock-UnitMember"
            $result.AdditionalProperties."@odata.type" | Should -Be "#microsoft.graph.user"

            Should -Invoke -CommandName Get-MgBetaAdministrativeUnitMember -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when AdministrativeUnitId is empty" {
            { Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId   } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
        }
        It "Should fail when AdministrativeUnitId is invalid" {
            { Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "" } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId' because it is an empty string."
        }
        It "Should return all administrative unit members" {
            $result = Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -All
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgBetaAdministrativeUnitMember -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when All is invalid" {
            { Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -All XY } | Should -Throw "A positional parameter cannot be found that accepts argument 'xy'.*"
        }
        It "Should return top 1 administrative unit member" {
            $result = Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Get-MgBetaAdministrativeUnitMember -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Result should Contain AdministrativeUnitId" {
            $result = Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "pppppppp-1111-1111-1111-aaaaaaaaaaaa"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain AdministrativeUnitId in parameters when passed AdministrativeUnitId to it" {    
            
            $result = Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "pppppppp-1111-1111-1111-aaaaaaaaaaaa"
            $params = Get-Parameters -data $result.Parameters
            $params.AdministrativeUnitId | Should -Be "pppppppp-1111-1111-1111-aaaaaaaaaaaa"
        }
        It "Property parameter should work" {
            $result =  Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -Property ID
            $result | Should -Not -BeNullOrEmpty
            $result.ID | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
 
            Should -Invoke -CommandName Get-MgBetaAdministrativeUnitMember -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAdministrativeUnitMember"

            $result = Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "pppppppp-1111-1111-1111-aaaaaaaaaaaa"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAdministrativeUnitMember"

            Should -Invoke -CommandName Get-MgBetaAdministrativeUnitMember -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
                { Get-EntraBetaAdministrativeUnitMember -AdministrativeUnitId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}   

