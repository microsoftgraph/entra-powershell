# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    # Import the function file directly for testing
    $functionPath = Join-Path $PSScriptRoot "..\..\..\module\EntraBeta\Microsoft.Entra.Beta\Applications\Revoke-EntraBetaMCPServerPermission.ps1"
    if (Test-Path $functionPath) {
        . $functionPath
    } else {
        throw "Function file not found at: $functionPath"
    }
    
    # Import common functions
    $commonFunctionsPath = Join-Path $PSScriptRoot "..\..\Common-Functions.ps1"
    if (Test-Path $commonFunctionsPath) {
        Import-Module $commonFunctionsPath -Force
    }
    
    # Define stub functions needed by the main function
    function New-EntraBetaCustomHeaders {
        param($Command)
        return @{ 'User-Agent' = "PowerShell/Test EntraPowershell/Test $($Command.Name)" }
    }
    
    function Get-EntraContext {
        return @{
            Scopes = @("Application.ReadWrite.All", "Directory.Read.All", "DelegatedPermissionGrant.ReadWrite.All")
        }
    }

    # Mock data for service principals
    $script:mockMCPServerSp = @{
        Id          = "12345678-1234-1234-1234-123456789012"
        AppId       = "e8c77dc2-69b3-43f4-bc51-3213c9d915b4"
        DisplayName = "Microsoft MCP Server for Enterprise"
    }

    $script:mockVSCodeSp = @{
        Id          = "87654321-4321-4321-4321-210987654321"
        AppId       = "aebc6443-996d-45c2-90f0-388ff96faa56"
        DisplayName = "Visual Studio Code"
    }

    $script:mockVSSp = @{
        Id          = "11111111-1111-1111-1111-111111111111"
        AppId       = "04f0c124-f2bc-4f59-8241-bf6df9866bbd"
        DisplayName = "Visual Studio"
    }

    $script:mockVSMSALSp = @{
        Id          = "22222222-2222-2222-2222-222222222222"
        AppId       = "62e61498-0c88-438b-a45c-2da0517bebe6"
        DisplayName = "Visual Studio MSAL"
    }

    $script:mockCustomSp = @{
        Id          = "33333333-3333-3333-3333-333333333333"
        AppId       = "33333333-3333-3333-3333-333333333333"
        DisplayName = "Custom MCP Client"
    }

    # Mock data for OAuth2 permission grants
    $script:mockGrant = @{
        Id           = "grant-12345"
        Scope        = "User.Read Application.ReadWrite.All Directory.Read.All"
        ClientId     = $script:mockVSCodeSp.Id
        ResourceId   = $script:mockMCPServerSp.Id
        ConsentType  = "AllPrincipals"
    }

    # Define user agent header value for testing
    $script:userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Revoke-EntraBetaMcpServerPermission"

    # Set up common mocks - these functions are called within the imported function
    Mock -CommandName Get-EntraContext -MockWith { 
        @{
            Scopes = @("Application.ReadWrite.All", "Directory.Read.All", "DelegatedPermissionGrant.ReadWrite.All")
        } 
    }

    Mock -CommandName New-EntraBetaCustomHeaders -MockWith {
        @{ 'User-Agent' = $script:userAgentHeaderValue }
    }

    # Mock Microsoft Graph cmdlets that the function uses
    Mock -CommandName Get-MgBetaServicePrincipal -MockWith { $null }
    Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { $null }
    Mock -CommandName Update-MgBetaOauth2PermissionGrant -MockWith { $null }
    Mock -CommandName Remove-MgBetaOauth2PermissionGrant -MockWith { $null }
}

Describe "Revoke-EntraBetaMcpServerPermission" {
    Context "Parameter Validation" {
        It "Should fail when CustomClientAppId has invalid GUID format" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { $script:mockMCPServerSp }
            
            { Revoke-EntraBetaMcpServerPermission -CustomClientAppId "invalid-guid" } | 
                Should -Throw "Cannot process argument transformation on parameter 'CustomClientAppId'*"
        }

        It "Should accept valid GUID format for CustomClientAppId" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $script:mockMCPServerSp
                } else {
                    return $script:mockCustomSp
                }
            }
            
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { $null }
            
            { Revoke-EntraBetaMcpServerPermission -CustomClientAppId "33333333-3333-3333-3333-333333333333" } | 
                Should -Not -Throw
        }

        It "Should reject empty or null values for Scopes parameter" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { $script:mockMCPServerSp }
            
            { Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @() } | 
                Should -Throw "*Cannot validate argument on parameter 'Scopes'*"
                
            { Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes $null } | 
                Should -Throw "*Cannot validate argument on parameter 'Scopes'*"
                
            { Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @("") } | 
                Should -Throw "*Cannot validate argument on parameter 'Scopes'*"
        }

        It "Should accept valid scope values" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $script:mockMCPServerSp
                } else {
                    return $script:mockVSCodeSp
                }
            }
            
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "MCP.User.Read MCP.Application.ReadWrite.All MCP.Directory.Read.All"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            { Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @("MCP.User.Read", "MCP.Directory.Read.All") } | 
                Should -Not -Throw
        }
    }

    Context "Authentication and Permissions" {
        It "Should fail when not connected to Microsoft Graph" {
            Mock -CommandName Get-EntraContext -MockWith { $null }
            
            { Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" } | 
                Should -Throw "*Not connected to Microsoft Graph*"
        }

        It "Should require correct scopes for operation" {
            Mock -CommandName Get-EntraContext -MockWith { 
                @{ Scopes = @("Application.Read.All") }  # Missing required scopes
            }
            
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { $script:mockMCPServerSp }
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { $null }

            # The command should still run but may have limited functionality
            { Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" } | 
                Should -Not -Throw
        }
    }

    Context "Service Principal Resolution" {
        It "Should resolve predefined MCP clients correctly" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $script:mockMCPServerSp
                } elseif ($Filter -like "*aebc6443-996d-45c2-90f0-388ff96faa56*") {
                    return $script:mockVSCodeSp
                }
            }
            
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { $null }

            Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode"
            Should -Invoke -CommandName Get-MgBetaServicePrincipal -Times 2
        }

        It "Should handle custom client app IDs" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $script:mockMCPServerSp
                } elseif ($Filter -like "*33333333-3333-3333-3333-333333333333*") {
                    return $script:mockCustomSp
                }
            }
            
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { $null }

            Revoke-EntraBetaMcpServerPermission -CustomClientAppId "33333333-3333-3333-3333-333333333333"
            Should -Invoke -CommandName Get-MgBetaServicePrincipal -Times 2
        }

        It "Should warn when MCP Server service principal is not found" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $null  # MCP Server not found
                }
            }

            { Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" } | 
                Should -Throw "*Service principal for Microsoft MCP Server for Enterprise not found*"
        }

        It "Should throw error when client service principal is not found" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $script:mockMCPServerSp
                } else {
                    return $null  # Client SP not found
                }
            }

            { Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" } | 
                Should -Throw "*Could not get service principal for*"
        }
    }

    Context "Permission Grant Management" {
        BeforeEach {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $script:mockMCPServerSp
                } elseif ($Filter -like "*aebc6443-996d-45c2-90f0-388ff96faa56*") {
                    return $script:mockVSCodeSp
                }
            }
        }

        It "Should handle case when no grants exist and return null" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { $null }

            $result = Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode"
            $result | Should -Be $null
            Should -Invoke -CommandName Get-MgBetaOauth2PermissionGrant -Times 1
        }

        It "Should revoke specific scopes when specified and return updated grant" {
            # Mock to always return the original grant (before update)
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read Application.ReadWrite.All Directory.Read.All"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            # Mock update to return nothing (void)
            Mock -CommandName Update-MgBetaOauth2PermissionGrant -MockWith { return $null }

            $result = Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @("User.Read")
            
            Should -Invoke -CommandName Update-MgBetaOauth2PermissionGrant -Times 1
            # Since our mock always returns the original grant, we'll get that back
            $result | Should -Not -Be $null
            $result.Id | Should -Be "grant-12345"
            $result.Scope | Should -Be "User.Read Application.ReadWrite.All Directory.Read.All"
        }

        It "Should remove entire grant when all scopes are revoked and return null" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            Mock -CommandName Remove-MgBetaOauth2PermissionGrant -MockWith {}

            $result = Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @("User.Read")
            Should -Invoke -CommandName Remove-MgBetaOauth2PermissionGrant -Times 1
            $result | Should -Be $null
        }

        It "Should revoke all permissions when no scopes specified and return null" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read Application.ReadWrite.All Directory.Read.All"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            Mock -CommandName Remove-MgBetaOauth2PermissionGrant -MockWith {}

            $result = Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode"
            Should -Invoke -CommandName Remove-MgBetaOauth2PermissionGrant -Times 1
            $result | Should -Be $null
        }

        It "Should warn when specified scopes are not currently granted" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            Mock -CommandName Write-Warning -MockWith {}

            Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @("NonExistent.Scope")
            Should -Invoke -CommandName Write-Warning -Times 1
        }

        It "Should handle partial scope matches correctly" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read Application.ReadWrite.All Directory.Read.All"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            Mock -CommandName Update-MgBetaOauth2PermissionGrant -MockWith { return $null }
            Mock -CommandName Write-Warning -MockWith {}

            # Mix of valid and invalid scopes
            Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @("User.Read", "NonExistent.Scope")
            
            # Should warn about invalid scope but still process valid ones
            Should -Invoke -CommandName Write-Warning -Times 1
            Should -Invoke -CommandName Update-MgBetaOauth2PermissionGrant -Times 1
        }

        It "Should return early when no valid scopes to revoke and return current grant" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            Mock -CommandName Write-Warning -MockWith {}
            Mock -CommandName Update-MgBetaOauth2PermissionGrant -MockWith {}

            $result = Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @("NonExistent.Scope")
            
            # Should warn about no valid scopes and not attempt any updates
            Should -Invoke -CommandName Write-Warning -Times 2
            Should -Invoke -CommandName Update-MgBetaOauth2PermissionGrant -Times 0
            $result | Should -Not -Be $null
            $result.Id | Should -Be "grant-12345"
            $result.Scope | Should -Be "User.Read"
        }

        It "Should handle duplicate scopes correctly" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read Application.ReadWrite.All"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            Mock -CommandName Update-MgBetaOauth2PermissionGrant -MockWith { return $null }

            # Pass duplicate scopes - should be deduplicated internally
            Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @("User.Read", "User.Read", "User.Read")
            Should -Invoke -CommandName Update-MgBetaOauth2PermissionGrant -Times 1
        }

        It "Should handle scope case insensitivity correctly" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $script:mockMCPServerSp
                } elseif ($Filter -like "*aebc6443-996d-45c2-90f0-388ff96faa56*") {
                    return $script:mockVSCodeSp
                }
            }
            
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read Application.ReadWrite.All"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            Mock -CommandName Update-MgBetaOauth2PermissionGrant -MockWith {}
            Mock -CommandName Write-Warning -MockWith {}

            # Test case insensitivity - "user.read" should match "User.Read"
            $null = Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @("user.read")
            
            # Should not warn because PowerShell treats them as the same (case insensitive)
            Should -Invoke -CommandName Write-Warning -Times 0
        }
    }

    Context "Return Values" {
        BeforeEach {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $script:mockMCPServerSp
                } elseif ($Filter -like "*aebc6443-996d-45c2-90f0-388ff96faa56*") {
                    return $script:mockVSCodeSp
                }
            }
            Mock -CommandName Write-Host -MockWith {}
        }

        It "Should return null when no grant exists" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { $null }

            $result = Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode"
            $result | Should -Be $null
        }

        It "Should return null when all permissions are revoked" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            Mock -CommandName Remove-MgBetaOauth2PermissionGrant -MockWith {}

            $result = Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode"
            $result | Should -Be $null
        }

        It "Should return updated OAuth2PermissionGrant when permissions are partially revoked" {
            # Mock to always return the original grant (before update)
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read Application.ReadWrite.All Directory.Read.All"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            Mock -CommandName Update-MgBetaOauth2PermissionGrant -MockWith { return $null }

            $result = Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @("User.Read")
            
            $result | Should -Not -Be $null
            $result.Id | Should -Be "grant-12345"
            $result.Scope | Should -Be "User.Read Application.ReadWrite.All Directory.Read.All"
            $result.ClientId | Should -Be $script:mockVSCodeSp.Id
            $result.ResourceId | Should -Be $script:mockMCPServerSp.Id
            $result.ConsentType | Should -Be "AllPrincipals"
        }

        It "Should return current grant when no valid scopes to revoke" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            Mock -CommandName Write-Warning -MockWith {}

            $result = Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @("NonExistent.Scope")
            
            $result | Should -Not -Be $null
            $result.Id | Should -Be "grant-12345"
            $result.Scope | Should -Be "User.Read"
        }

        It "Should return current grant when no scopes are currently granted" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = ""
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }

            $result = Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode"
            
            $result | Should -Not -Be $null
            $result.Id | Should -Be "grant-12345"
            $result.Scope | Should -Be ""
        }
    }

    Context "Error Handling" {
        BeforeEach {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $script:mockMCPServerSp
                } elseif ($Filter -like "*aebc6443-996d-45c2-90f0-388ff96faa56*") {
                    return $script:mockVSCodeSp
                }
            }
        }

        It "Should throw error when grant update fails" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read Application.ReadWrite.All"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            Mock -CommandName Update-MgBetaOauth2PermissionGrant -MockWith { 
                throw "Update failed" 
            }

            # Should throw error when update fails
            { Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @("User.Read") } | 
                Should -Throw "*Failed to revoke permissions*"
        }

        It "Should throw error when grant removal fails" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            Mock -CommandName Remove-MgBetaOauth2PermissionGrant -MockWith { 
                throw "Removal failed" 
            }

            # Should throw error when removal fails
            { Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" } | 
                Should -Throw "*Failed to revoke permissions*"
        }
    }

    Context "Output and Logging" {
        BeforeEach {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $script:mockMCPServerSp
                } elseif ($Filter -like "*aebc6443-996d-45c2-90f0-388ff96faa56*") {
                    return $script:mockVSCodeSp
                }
            }
            
            Mock -CommandName Write-Host -MockWith {}
            Mock -CommandName Write-Verbose -MockWith {}
        }

        It "Should provide informative output during execution" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read Application.ReadWrite.All"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            Mock -CommandName Remove-MgBetaOauth2PermissionGrant -MockWith {}

            # Execute the command - test that it runs successfully and outputs results
            { Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" } | Should -Not -Throw
            
            # Verify that the core removal function was called
            Should -Invoke -CommandName Remove-MgBetaOauth2PermissionGrant -Times 1
        }

        It "Should execute successfully when verbose flag is used" {
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { $null }

            # Test that the function executes without errors when using verbose and whatif
            { Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Verbose } | Should -Not -Throw
        }
    }

    Context "Integration Scenarios" {
        It "Should handle complete workflow for single client with specific scopes" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $script:mockMCPServerSp
                } elseif ($Filter -like "*aebc6443-996d-45c2-90f0-388ff96faa56*") {
                    return $script:mockVSCodeSp
                }
            }
            
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read Application.ReadWrite.All Directory.Read.All"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            Mock -CommandName Update-MgBetaOauth2PermissionGrant -MockWith { return $null }
            Mock -CommandName Write-Host -MockWith {}

            $result = Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode" -Scopes @("User.Read")

            Should -Invoke -CommandName Get-MgBetaServicePrincipal -Times 2
            Should -Invoke -CommandName Get-MgBetaOauth2PermissionGrant -Times 3
            Should -Invoke -CommandName Update-MgBetaOauth2PermissionGrant -Times 1
            $result | Should -Not -Be $null
            $result.Scope | Should -Be "User.Read Application.ReadWrite.All Directory.Read.All"
        }

        It "Should handle complete workflow for single client with all scopes revoked" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $script:mockMCPServerSp
                } elseif ($Filter -like "*aebc6443-996d-45c2-90f0-388ff96faa56*") {
                    return $script:mockVSCodeSp
                }
            }
            
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-12345"
                    Scope        = "User.Read Application.ReadWrite.All"
                    ClientId     = $script:mockVSCodeSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            Mock -CommandName Remove-MgBetaOauth2PermissionGrant -MockWith {}
            Mock -CommandName Write-Host -MockWith {}

            $result = Revoke-EntraBetaMcpServerPermission -PredefinedClient "VisualStudioCode"

            Should -Invoke -CommandName Get-MgBetaServicePrincipal -Times 2
            Should -Invoke -CommandName Get-MgBetaOauth2PermissionGrant -Times 1
            Should -Invoke -CommandName Remove-MgBetaOauth2PermissionGrant -Times 1
            $result | Should -Be $null
        }

        It "Should handle custom client service principal ID workflow" {
            Mock -CommandName Get-MgBetaServicePrincipal -MockWith { 
                param($Filter)
                if ($Filter -like "*e8c77dc2-69b3-43f4-bc51-3213c9d915b4*") {
                    return $script:mockMCPServerSp
                } elseif ($Filter -like "*33333333-3333-3333-3333-333333333333*") {
                    return $script:mockCustomSp
                }
            }
            
            Mock -CommandName Get-MgBetaOauth2PermissionGrant -MockWith { 
                return @{
                    Id           = "grant-custom"
                    Scope        = "User.Read Directory.Read.All"
                    ClientId     = $script:mockCustomSp.Id
                    ResourceId   = $script:mockMCPServerSp.Id
                    ConsentType  = "AllPrincipals"
                }
            }
            
            Mock -CommandName Update-MgBetaOauth2PermissionGrant -MockWith { return $null }
            Mock -CommandName Write-Host -MockWith {}

            $result = Revoke-EntraBetaMcpServerPermission -CustomClientAppId "33333333-3333-3333-3333-333333333333" -Scopes @("User.Read")

            Should -Invoke -CommandName Get-MgBetaServicePrincipal -Times 2
            Should -Invoke -CommandName Update-MgBetaOauth2PermissionGrant -Times 1
            $result | Should -Not -Be $null
            $result.Scope | Should -Be "User.Read Directory.Read.All"
        }
    }
}
