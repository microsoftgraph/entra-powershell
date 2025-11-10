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
        publishedPermissionScopes = @(
            [PSCustomObject]@{ Value = "MCP.User.Read"; IsEnabled = $true }
            [PSCustomObject]@{ Value = "MCP.Directory.Read.All"; IsEnabled = $true }
            [PSCustomObject]@{ Value = "MCP.Application.ReadWrite.All"; IsEnabled = $true }
            [PSCustomObject]@{ Value = "MCP.Files.Read"; IsEnabled = $true }
            [PSCustomObject]@{ Value = "MCP.Files.ReadWrite"; IsEnabled = $true }
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
        param($BodyParameter)
        return [PSCustomObject]@{
            Id = $testGrantId
            ClientId = $BodyParameter.clientId
            ResourceId = $BodyParameter.resourceId
            ConsentType = $BodyParameter.consentType
            Scope = $BodyParameter.scope
        }
    }

    Mock -CommandName Update-MgBetaOauth2PermissionGrant -MockWith {
        param($OAuth2PermissionGrantId, $BodyParameter)
        return [PSCustomObject]@{
            Id = $OAuth2PermissionGrantId
            ClientId = $testClientSpId
            ResourceId = $testResourceSpId
            ConsentType = "AllPrincipals"
            Scope = $BodyParameter.scope
        }
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
            { Grant-EntraBetaMCPServerPermission -MCPClientServicePrincipalId "not-a-guid" } | Should -Throw "Cannot process argument transformation on parameter 'MCPClientServicePrincipalId'*"
        }

        It "Should reject invalid MCPClient value" {
            { Grant-EntraBetaMCPServerPermission -MCPClient "InvalidClient" } | Should -Throw "*Cannot validate argument on parameter 'MCPClient'*"
        }
    }

    Context "Parameter Set Validation" {
        It "Should accept valid predefined client (PredefinedClient parameter set)" {
            $validClients = @('VisualStudioCode', 'VisualStudio', 'ChatGPT', 'ClaudeDesktop')
            foreach ($client in $validClients) {
                $cmd = { Grant-EntraBetaMCPServerPermission -MCPClient $client -WhatIf }
                $cmd | Should -Not -BeNullOrEmpty
            }
        }

        It "Should use PredefinedClientScopes parameter set when MCPClient and Scopes are provided" {
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes @('User.Read') -WhatIf }
            $cmd | Should -Not -BeNullOrEmpty
        }

        It "Should use CustomClient parameter set when only MCPClientServicePrincipalId is provided" {
            $validGuid = "12345678-1234-1234-1234-123456789abc"
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClientServicePrincipalId $validGuid -WhatIf }
            $cmd | Should -Not -BeNullOrEmpty
        }

        It "Should use CustomClientScopes parameter set when both MCPClientServicePrincipalId and Scopes are provided" {
            $validGuid = "12345678-1234-1234-1234-123456789abc"
            $cmd = { Grant-EntraBetaMCPServerPermission -MCPClientServicePrincipalId $validGuid -Scopes @('User.Read') -WhatIf }
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
            
            Should -Invoke -CommandName New-MgBetaOauth2PermissionGrant -ParameterFilter {
                $BodyParameter.scope -eq "Files.Read User.Read"
            }
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

    Context "Custom Client Support" {
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
                        publishedPermissionScopes = @()  # No scopes
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

        It "Should throw error when client service principal cannot be found or created" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*$resourceAppId*") {
                    return $mockResourceSp
                }
                return $null  # Client not found
            }
            
            Mock -CommandName New-MgBetaServicePrincipal -MockWith { 
                throw "Service principal creation failed"
            }
            
            { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' } |
                Should -Throw "*Service principal creation failed*"
        }
    }

    Context "Return Value" {
        It "Should return OAuth2PermissionGrant object when successful" {
            $result = Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode'
            
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be $testGrantId
            $result.ClientId | Should -Be $testClientSpId
            $result.ResourceId | Should -Be $testResourceSpId
            $result.ConsentType | Should -Be "AllPrincipals"
        }

        It "Should return null when no scopes are granted" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*$resourceAppId*") {
                    return [PSCustomObject]@{
                        Id = $testResourceSpId
                        AppId = $resourceAppId
                        DisplayName = "Microsoft MCP Server for Enterprise"
                        publishedPermissionScopes = @()  # No scopes available
                    }
                }
                return $mockClientSp
            }
            
            # This should throw due to no available scopes, not return null
            { Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' } |
                Should -Throw "*Resource app exposes no enabled delegated*"
        }

        It "Should return grant object with correct scope property" {
            $result = Grant-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes @('User.Read', 'Files.Read')
            
            $result.Scope | Should -Match "User.Read"
            $result.Scope | Should -Match "Files.Read"
        }
    }
}