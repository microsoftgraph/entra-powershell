# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

BeforeAll {
    if (Get-Module -ListAvailable -Name Microsoft.Graph.Beta.Applications) {
        Import-Module Microsoft.Graph.Beta.Applications -Force -ErrorAction SilentlyContinue
    }
    if (Get-Module -ListAvailable -Name Microsoft.Graph.Beta.Identity.SignIns) {
        Import-Module Microsoft.Graph.Beta.Identity.SignIns -Force -ErrorAction SilentlyContinue
    }

    # Mock the custom headers function to avoid module version issues in test context
    function New-EntraBetaCustomHeaders {
        param([string]$Command)
        return @{ 'User-Agent' = $userAgentHeaderValue }
    }

    # Import the main function for testing
    $functionPath = Join-Path $PSScriptRoot "..\..\..\module\EntraBeta\Microsoft.Entra.Beta\Applications\Grant-EntraBetaMCPServerPermission.ps1"
    . $functionPath

    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Grant-EntraBetaMCPServerPermission"
    
    # Test constants
    $script:resourceAppId = "e8c77dc2-69b3-43f4-bc51-3213c9d915b4"  # Microsoft MCP Server for Enterprise
    $script:testResourceSpId = "resource-sp-12345678-1234-1234-1234-123456789abc"
    $script:testClientSpId = "client-sp-12345678-1234-1234-1234-123456789abc"
    $script:testGrantId = "grant-12345678-1234-1234-1234-123456789abc"
    
    # Mock service principal for MCP resource
    $script:mockResourceSp = [PSCustomObject]@{
        Id = $testResourceSpId
        AppId = $resourceAppId
        DisplayName = "Microsoft MCP Server for Enterprise"
        Oauth2PermissionScopes = @(
            [PSCustomObject]@{ Value = "User.Read"; IsEnabled = $true }
            [PSCustomObject]@{ Value = "Directory.Read.All"; IsEnabled = $true }
            [PSCustomObject]@{ Value = "Application.ReadWrite.All"; IsEnabled = $true }
            [PSCustomObject]@{ Value = "Files.Read"; IsEnabled = $true }
            [PSCustomObject]@{ Value = "Files.ReadWrite"; IsEnabled = $true }
        )
    }
    
    # Mock service principal for VS Code client
    $script:mockClientSp = [PSCustomObject]@{
        Id = $testClientSpId
        AppId = "aebc6443-996d-45c2-90f0-388ff96faa56"
        DisplayName = "Visual Studio Code"
    }
    
    # Mock permission grant
    $script:mockGrant = [PSCustomObject]@{
        Id = $testGrantId
        ClientId = $testClientSpId
        ResourceId = $testResourceSpId
        ConsentType = "AllPrincipals"
        Scope = "User.Read Directory.Read.All"
    }

    # Mock functions with default behaviors  
    Mock -CommandName Get-EntraContext -MockWith { 
        return [PSCustomObject]@{ 
            Account = "test@contoso.com"
            Environment = "Global"
        }
    }

    Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
        param($Filter, $Headers)
        if ($Filter -like "*$resourceAppId*") {
            return $mockResourceSp
        }
        elseif ($Filter -like "*aebc6443-996d-45c2-90f0-388ff96faa56*") {
            return $mockClientSp
        }
        return $null
    }

    Mock -CommandName New-MgBetaServicePrincipal -MockWith { 
        param($AppId, $Headers)
        if ($AppId -eq $resourceAppId) {
            return $mockResourceSp
        }
        elseif ($AppId -eq "aebc6443-996d-45c2-90f0-388ff96faa56") {
            return $mockClientSp
        }
        return [PSCustomObject]@{ Id = "new-sp-id"; AppId = $AppId }
    }

    Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith {
        return $null  # Default: no existing grant
    }

    Mock -CommandName New-MgBetaOauth2PermissionGrant -MockWith { 
        return $mockGrant
    }

    Mock -CommandName Update-MgBetaOauth2PermissionGrant -MockWith {
        return $mockGrant
    }

    Mock -CommandName Remove-MgBetaOauth2PermissionGrant -MockWith {
        return $null
    }
}

Describe "Grant-EntraBetaMCPServerPermission - Test Structure" {
    Context "Command Availability and Structure" {
        It "Should have the cmdlet available" {
            Get-Command Grant-EntraBetaMCPServerPermission | Should -Not -BeNullOrEmpty
        }

        It "Should reject invalid GUID format" {
            { Grant-EntraBetaMCPServerPermission -MCPClientServicePrincipalId "not-a-guid" } | Should -Throw "*Cannot validate argument on parameter 'MCPClientServicePrincipalId'*"
        }

        It "Should reject invalid MCPClient value" {
            { Grant-EntraBetaMCPServerPermission -MCPClient "InvalidClient" } | Should -Throw "*Cannot validate argument on parameter 'MCPClient'*"
        }
    }

    Context "Parameter Set Validation" {
        It "Should accept valid predefined client (PredefinedClients parameter set)" {
            $validClients = @('VisualStudioCode', 'VisualStudio', 'VisualStudioMSAL')
            foreach ($client in $validClients) {
                $cmd = { Grant-EntraBetaMCPServerPermission -MCPClient $client -WhatIf }
                $cmd | Should -Not -BeNullOrEmpty
            }
        }

        It "Should use PredefinedClientsScopes parameter set when MCPClient and Scopes are provided" {
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes @('User.Read') -WhatIf }
            $cmd | Should -Not -BeNullOrEmpty
        }

        It "Should use CustomClients parameter set when only MCPClientServicePrincipalId is provided" {
            $validGuid = "12345678-1234-1234-1234-123456789abc"
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClientServicePrincipalId $validGuid -WhatIf }
            $cmd | Should -Not -BeNullOrEmpty
        }

        It "Should use CustomClientsScopes parameter set when both MCPClientServicePrincipalId and Scopes are provided" {
            $validGuid = "12345678-1234-1234-1234-123456789abc"
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClientServicePrincipalId $validGuid -Scopes @('User.Read') -WhatIf }
            $cmd | Should -Not -BeNullOrEmpty
        }

        It "Should accept multiple predefined clients in array" {
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClient @('VisualStudioCode', 'VisualStudio') -WhatIf }
            $cmd | Should -Not -BeNullOrEmpty
        }

        It "Should accept multiple custom service principal IDs in array" {
            $validGuids = @("12345678-1234-1234-1234-123456789abc", "87654321-4321-4321-4321-cba987654321")
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClientServicePrincipalId $validGuids -WhatIf }
            $cmd | Should -Not -BeNullOrEmpty
        }

        It "Should accept valid GUID for service principal" {
            $validGuid = "12345678-1234-1234-1234-123456789abc"
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClientServicePrincipalId $validGuid -WhatIf }
            $cmd | Should -Not -BeNullOrEmpty
        }

        It "Should support scopes parameter with specific predefined clients" {
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes @('User.Read') -WhatIf }
            $cmd | Should -Not -BeNullOrEmpty
        }

        It "Should support scopes parameter with custom clients" {
            $validGuid = "12345678-1234-1234-1234-123456789abc"
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClientServicePrincipalId $validGuid -Scopes @('User.Read') -WhatIf }
            $cmd | Should -Not -BeNullOrEmpty
        }

        It "Should reject providing both MCPClient and MCPClientServicePrincipalId" {
            $validGuid = "12345678-1234-1234-1234-123456789abc"
            { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -MCPClientServicePrincipalId $validGuid } | 
                Should -Throw "*Parameter set cannot be resolved*"
        }

        It "Should default to all predefined clients when only Scopes is provided" {
            { Grant-EntraBetaMCPServerPermission -Scopes @('User.Read') } | 
                Should -Not -Throw
            
            # Should process all 3 predefined clients
            Should -Invoke -CommandName New-MgBetaOauth2PermissionGrant -Times 3
        }

        It "Should reject empty scopes array due to ValidateNotNullOrEmpty" {
            { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes @() } | 
                Should -Throw "*Cannot validate argument on parameter 'Scopes'*"
        }

        It "Should reject null scopes due to ValidateNotNullOrEmpty" {
            { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes $null } | 
                Should -Throw "*Cannot validate argument on parameter 'Scopes'*"
        }

        It "Should reject empty string in scopes array" {
            { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes @('') } | 
                Should -Throw "*Cannot validate argument on parameter 'Scopes'*"
        }
    }

    Context "Entra Context Validation" {
        It "Should throw error when not connected to Microsoft Graph" {
            Mock -CommandName Get-EntraContext -MockWith { return $null }
            
            { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' } | 
                Should -Throw "*Not connected to Microsoft Graph*"
        }

        It "Should proceed when properly authenticated" {
            { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' } | 
                Should -Not -Throw
        }
    }

    Context "Custom Headers" {
        It "Should include correct User-Agent header in service principal requests" {
            Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode'
            
            Should -Invoke -CommandName Get-MgBetaServicePrincipal -Times 2 -ParameterFilter {
                $Headers.'User-Agent' -eq $userAgentHeaderValue
            }
        }

        It "Should include correct User-Agent header in permission grant requests" {
            Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode'
            
            Should -Invoke -CommandName New-MgBetaOauth2PermissionGrant -Times 1 -ParameterFilter {
                $Headers.'User-Agent' -eq $userAgentHeaderValue
            }
        }

        It "Should include User-Agent header when creating new service principal" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { return $null }
            
            Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode'
            
            Should -Invoke -CommandName New-MgBetaServicePrincipal -Times 1 -ParameterFilter {
                $Headers.'User-Agent' -eq $userAgentHeaderValue
            }
        }

        It "Should include User-Agent header when updating existing permission grant" {
            # Mock existing grant that needs updating
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith {
                return [PSCustomObject]@{
                    Id = $testGrantId
                    ClientId = $testClientSpId
                    ResourceId = $testResourceSpId
                    ConsentType = "AllPrincipals"
                    Scope = "User.Read"  # Different from target scope
                }
            }
            
            Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes @('Directory.Read.All')
            
            Should -Invoke -CommandName Update-MgBetaOauth2PermissionGrant -Times 1 -ParameterFilter {
                $Headers.'User-Agent' -eq $userAgentHeaderValue
            }
        }
    }

    Context "Service Principal Management" {
        It "Should retrieve existing MCP resource service principal" {
            Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode'
            
            Should -Invoke -CommandName Get-MgBetaServicePrincipal -ParameterFilter {
                $Filter -eq "appId eq '$resourceAppId'"
            }
        }

        It "Should create MCP resource service principal if not found" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*$resourceAppId*") {
                    return $null  # Not found
                }
                return $mockClientSp
            }
            
            Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode'
            
            Should -Invoke -CommandName New-MgBetaServicePrincipal -ParameterFilter {
                $AppId -eq $resourceAppId
            }
        }

        It "Should retrieve existing client service principal" {
            Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode'
            
            Should -Invoke -CommandName Get-MgBetaServicePrincipal -ParameterFilter {
                $Filter -eq "appId eq 'aebc6443-996d-45c2-90f0-388ff96faa56'"
            }
        }

        It "Should create client service principal if not found" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*$resourceAppId*") {
                    return $mockResourceSp
                }
                return $null  # Client not found
            }
            
            Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode'
            
            Should -Invoke -CommandName New-MgBetaServicePrincipal -ParameterFilter {
                $AppId -eq "aebc6443-996d-45c2-90f0-388ff96faa56"
            }
        }
    }

    Context "Permission Grant Creation" {
        It "Should create new permission grant when none exists" {
            Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode'
            
            Should -Invoke -CommandName New-MgBetaOauth2PermissionGrant -ParameterFilter {
                $BodyParameter.clientId -eq $testClientSpId -and
                $BodyParameter.resourceId -eq $testResourceSpId -and
                $BodyParameter.consentType -eq "AllPrincipals"
            }
        }

        It "Should grant all available scopes by default" {
            Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode'
            
            Should -Invoke -CommandName New-MgBetaOauth2PermissionGrant -ParameterFilter {
                $BodyParameter.scope -eq "Application.ReadWrite.All Directory.Read.All Files.Read Files.ReadWrite User.Read"
            }
        }

        It "Should grant only specified scopes when provided" {
            Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes @('User.Read', 'Files.Read')
            
            Should -Invoke -CommandName New-MgBetaOauth2PermissionGrant -Times 1
        }

        It "Should update existing grant with different scopes" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith {
                return [PSCustomObject]@{
                    Id = $testGrantId
                    ClientId = $testClientSpId
                    ResourceId = $testResourceSpId
                    ConsentType = "AllPrincipals"
                    Scope = "User.Read"  # Existing different scope
                }
            }
            
            Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes @('Files.Read')
            
            # Should call Update instead of New when grant exists with different scopes
            Should -Invoke -CommandName Update-MgBetaOauth2PermissionGrant -Times 1
            Should -Invoke -CommandName New-MgBetaOauth2PermissionGrant -Times 0
        }
    }

    Context "Multiple Client Support" {
        It "Should process multiple predefined clients" {
            Grant-EntraBetaMCPServerPermission -MCPClient @('VisualStudioCode', 'VisualStudio')
            
            Should -Invoke -CommandName Get-MgBetaServicePrincipal -Times 3  # 1 resource + 2 clients
            Should -Invoke -CommandName New-MgBetaOauth2PermissionGrant -Times 2  # 2 clients
        }

        It "Should handle custom service principal IDs" {
            $customSpId = "12345678-1234-1234-1234-123456789abc"  # Valid GUID format
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*$resourceAppId*") {
                    return $mockResourceSp
                }
                elseif ($Filter -like "*$customSpId*") {
                    return [PSCustomObject]@{ Id = "custom-sp-id"; AppId = $customSpId; DisplayName = "Custom Client" }
                }
                return $null
            }
            
            Grant-EntraBetaMCPServerPermission -MCPClientServicePrincipalId $customSpId
            
            Should -Invoke -CommandName Get-MgBetaServicePrincipal -ParameterFilter {
                $Filter -eq "appId eq '$customSpId'"
            }
        }
    }

    Context "Scope Validation" {
        It "Should accept valid scopes from available permissions" {
            Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes @('User.Read', 'Files.Read')
            
            Should -Invoke -CommandName New-MgBetaOauth2PermissionGrant -Times 1
        }

        It "Should throw error for invalid scopes not available on resource" {
            { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes @('Invalid.Scope') } |
                Should -Throw "*Invalid scopes (not available on resource)*"
        }

        It "Should throw error when resource has no enabled scopes" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*$resourceAppId*") {
                    return [PSCustomObject]@{
                        Id = $testResourceSpId
                        AppId = $resourceAppId
                        DisplayName = "Microsoft MCP Server for Enterprise"
                        Oauth2PermissionScopes = @()  # No scopes
                    }
                }
                return $mockClientSp
            }
            
            { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' } |
                Should -Throw "*Resource app exposes no enabled delegated*"
        }
    }

    Context "Error Handling" {
        It "Should handle service principal creation failures gracefully" {
            Mock -CommandName New-MgBetaServicePrincipal -MockWith { 
                throw "Access denied" 
            }
            
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { return $null }
            
            { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' } |
                Should -Throw "*Access denied*"
        }

        It "Should continue with other clients when one fails" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*$resourceAppId*") {
                    return $mockResourceSp
                }
                elseif ($Filter -like "*aebc6443-996d-45c2-90f0-388ff96faa56*") {
                    return $mockClientSp
                }
                elseif ($Filter -like "*04f0c124-f2bc-4f59-8241-bf6df9866bbd*") {
                    throw "Service principal not found"
                }
                return $null
            }
            
            # Should not throw, but should show warning for failed client
            { Grant-EntraBetaMCPServerPermission -MCPClient @('VisualStudioCode', 'VisualStudio') } |
                Should -Not -Throw
            
            # Should still process the successful client
            Should -Invoke -CommandName New-MgBetaOauth2PermissionGrant -Times 1
        }
    }
}