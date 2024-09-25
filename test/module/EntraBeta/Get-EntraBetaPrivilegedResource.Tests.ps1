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
                "DisplayName"          = "new"
                "ExternalId"           = "/administrativeUnits/bbbbbbbb-1111-2222-3333-cccccccccc55"
                "Id"                   = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                "Parent"               = "Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphGovernanceResource"
                "RegisteredDateTime"   = $null
                "RegisteredRoot"       = $null
                "RoleAssignmentRequests" = @()
                "RoleAssignments"      = @()
                "RoleDefinitions"      = @()
                "RoleSettings"         = @()
                "Status"               = "Active"
                "Type"                 = "administrativeUnits"
                "AdditionalProperties" = @{"@odata.context"="https://graph.microsoft.com/beta/`$metadata#governanceResources/`$entity"}
                "Parameters"           = $args
            }
        )
    }    
    Mock -CommandName Get-MgBetaPrivilegedAccessResource -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaPrivilegedResource" {
    Context "Test for Get-EntraBetaPrivilegedResource" {
        It "Should retrieve all resources from Microsoft Entra ID." {
            $result = Get-EntraBetaPrivilegedResource -ProviderId aadRoles
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessResource -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ProviderId are empty" {
            { Get-EntraBetaPrivilegedResource -ProviderId } | Should -Throw "Missing an argument for parameter 'ProviderId'*"
        }

        It "Should fail when ProviderId is Invalid" {
            { Get-EntraBetaPrivilegedResource -ProviderId "" } | Should -Throw "Cannot bind argument to parameter 'ProviderId' because it is an empty string."
        }

        It "Should get a specific privileged resource" {
            $result = Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.Status | Should -Be "Active"
            $result.Type | Should -Be "administrativeUnits"
            $result.ExternalId | Should -Be "/administrativeUnits/bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.DisplayName | Should -Be "new"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessResource -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id are empty" {
            { Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is Invalid" {
            { Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should get top privileged resources" {
            $result = Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessResource -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Top are empty" {
            { Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }

        It "Should fail when Top is Invalid" {
            { Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Top XYZ } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Should get a specific privileged resource by filter" {
            $result = Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Filter "DisplayName eq 'new'"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.Status | Should -Be "Active"
            $result.Type | Should -Be "administrativeUnits"
            $result.ExternalId | Should -Be "/administrativeUnits/bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.DisplayName | Should -Be "new"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessResource -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Filter are empty" {
            { Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Filter  } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }

        It "Should contain ObjectId in result" {
            $result = Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
        } 

        It "Should contain GovernanceResourceId in parameters when passed Id to it" {
            $result = Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $params = Get-Parameters -data $result.Parameters
            $params.GovernanceResourceId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessResource -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain PrivilegedAccessId in parameters when passed ProviderId to it" {
            $result = Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $params = Get-Parameters -data $result.Parameters
            $params.PrivilegedAccessId | Should -Be "aadRoles"

            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessResource -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'new'
    
            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessResource -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPrivilegedResource"
            $result= Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Id "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPrivilegedResource"
            Should -Invoke -CommandName Get-MgBetaPrivilegedAccessResource -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }     

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}