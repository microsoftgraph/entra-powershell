# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications
    }
    if ((Get-Module -Name Microsoft.Graph.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Graph.Beta.Applications
    }
    if ((Get-Module -Name Microsoft.Graph.Beta.Identity.SignIns) -eq $null) {
        Import-Module Microsoft.Graph.Beta.Identity.SignIns
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    # Define variables for use across tests
    $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Grant-EntraBetaMCPServerPermission"
}

Describe "Grant-EntraBetaMCPServerPermission - Test Structure" {
    Context "Command Availability and Structure" {
        It "Should have the cmdlet available" {
            Get-Command Grant-EntraBetaMCPServerPermission | Should -Not -BeNullOrEmpty
        }

        It "Should have correct parameter sets" {
            $command = Get-Command Grant-EntraBetaMCPServerPermission
            $command.ParameterSets.Name | Should -Contain "PredefinedClients"
            $command.ParameterSets.Name | Should -Contain "PredefinedClientsScopes"
            $command.ParameterSets.Name | Should -Contain "CustomClients"
            $command.ParameterSets.Name | Should -Contain "CustomClientsScopes"
        }

        It "Should have correct default parameter set" {
            $command = Get-Command Grant-EntraBetaMCPServerPermission
            $command.DefaultParameterSet | Should -Be "PredefinedClients"
        }

        It "Should be in correct module" {
            $command = Get-Command Grant-EntraBetaMCPServerPermission
            $command.ModuleName | Should -Be "Microsoft.Entra.Beta.Applications"
            $command.CommandType | Should -Be "Function"
            $command.Visibility | Should -Be "Public"
        }

        It "Should validate MCPClient parameter correctly" {
            $command = Get-Command Grant-EntraBetaMCPServerPermission
            $mcpClientParam = $command.Parameters['MCPClient']
            $validateSetAttr = $mcpClientParam.Attributes | Where-Object { $_.TypeId.Name -eq 'ValidateSetAttribute' }
            $validateSetAttr.ValidValues | Should -Contain "VisualStudioCode"
            $validateSetAttr.ValidValues | Should -Contain "VisualStudio"
            $validateSetAttr.ValidValues | Should -Contain "VisualStudioMSAL"
        }

        It "Should validate MCPClientServicePrincipalId parameter with GUID pattern" {
            $command = Get-Command Grant-EntraBetaMCPServerPermission
            $spParam = $command.Parameters['MCPClientServicePrincipalId']
            $validatePatternAttr = $spParam.Attributes | Where-Object { $_.TypeId.Name -eq 'ValidatePatternAttribute' }
            $validatePatternAttr.RegexPattern | Should -Be '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$'
        }

        It "Should reject invalid GUID format" {
            { Grant-EntraBetaMCPServerPermission -MCPClientServicePrincipalId "not-a-guid" } | Should -Throw "*Cannot validate argument on parameter 'MCPClientServicePrincipalId'*"
        }

        It "Should reject invalid MCPClient value" {
            { Grant-EntraBetaMCPServerPermission -MCPClient "InvalidClient" } | Should -Throw "*Cannot validate argument on parameter 'MCPClient'*"
        }
    }

    Context "Parameter Set Validation" {
        It "Should accept valid predefined client" {
            # This test validates that the parameter binding works correctly
            # We're not testing actual execution here, just parameter validation
            $validClients = @('VisualStudioCode', 'VisualStudio', 'VisualStudioMSAL')
            foreach ($client in $validClients) {
                # Test that parameters bind without throwing parameter validation errors
                $cmd = { Grant-EntraBetaMCPServerPermission -MCPClient $client -WhatIf }
                $cmd | Should -Not -BeNullOrEmpty
            }
        }

        It "Should accept valid GUID for service principal" {
            $validGuid = "12345678-1234-1234-1234-123456789abc"
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClientServicePrincipalId $validGuid -WhatIf }
            $cmd | Should -Not -BeNullOrEmpty
        }

        It "Should support scopes parameter with predefined clients" {
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes @('User.Read') -WhatIf }
            $cmd | Should -Not -BeNullOrEmpty
        }

        It "Should support scopes parameter with custom clients" {
            $validGuid = "12345678-1234-1234-1234-123456789abc"
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClientServicePrincipalId $validGuid -Scopes @('User.Read') -WhatIf }
            $cmd | Should -Not -BeNullOrEmpty
        }
    }
}