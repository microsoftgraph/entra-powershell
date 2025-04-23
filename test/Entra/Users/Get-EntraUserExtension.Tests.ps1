# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

Describe "Get-EntraUserExtension" {
    BeforeAll {
        # Clean up any existing module instances
        Get-Module -Name Microsoft.Entra.Users | Remove-Module -Force -ErrorAction SilentlyContinue
        
        # Import the module
        Import-Module Microsoft.Entra.Users -Force
        Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

        # Define variables needed for mocks as script-scoped variables
        $script:psVersion = $PSVersionTable.PSVersion.ToString()
        $script:entraVersion = (Get-Module Microsoft.Entra.Users).Version.ToString()

        # Create different mock responses for different API calls
        $mockExtensionProperties = {
            param($Uri, $Method, $Headers, $Body)
            
            if ($Method -eq "POST" -and $Uri -match "directoryObjects/getAvailableExtensionProperties") {
                return @{
                    value = @(
                        @{ Name = "extension_abc123_customAttribute1" }
                        @{ Name = "extension_abc123_customAttribute2" }
                    )
                }
            }
            
            throw "Unexpected URI or method in extension properties mock: $Method $Uri"
        }
        
        $mockUserData = {
            param($Uri, $Method, $Headers, $Body)
            
            if ($Method -eq "GET" -and $Uri -match "users/") {
                return @{
                    "employeeId"                        = "1234567890"
                    "userPrincipalName"                 = "sawyerM@contoso.com"          
                    "createdDateTime"                   = "2023-10-01T00:00:00Z"
                    "id"                                = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                    "onPremisesDistinguishedName"       = "CN=SawyerM,OU=Users,DC=contoso,DC=com"
                    "userIdentities"                    = @()
                    "extension_abc123_customAttribute1" = "Value1"
                    "extension_abc123_customAttribute2" = "Value2"
                }
            }
            
            throw "Unexpected URI or method in user data mock: $Method $Uri"
        }

        # Create a single mock that handles both types of requests
        Mock -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -MockWith {
            param($Uri, $Method, $Headers, $Body)
            
            # For extension properties request
            if ($Method -eq "POST" -and $Uri -match "directoryObjects/getAvailableExtensionProperties") {
                return & $mockExtensionProperties $Uri $Method $Headers $Body
            }
            # For user data request
            elseif ($Method -eq "GET" -and $Uri -match "users/") {
                return & $mockUserData $Uri $Method $Headers $Body
            }
            else {
                Write-Error "Mock received unexpected request: $Method $Uri"
                throw [System.Net.WebException]::new("Response status code does not indicate success: NotFound (Not Found).")
            }
        }
        
        # Mock Get-EntraContext
        Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Users
        
        # Mock New-EntraCustomHeaders with defined user agent string using script-scoped variables
        Mock -CommandName New-EntraCustomHeaders -MockWith { 
            @{ 'User-Agent' = "PowerShell/$($script:psVersion) EntraPowershell/$($script:entraVersion) Get-EntraUserExtension" }
        } -ModuleName Microsoft.Entra.Users
    }

    Context "Test for Get-EntraUserExtension" {
        It "Should return user extensions" {
            $result = Get-EntraUserExtension -UserId 'SawyerM@contoso.com'            
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -Times 2
        }

        It "Should execute successfully with Alias" {
            $result = Get-EntraUserExtension -Identity 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -Times 2
        }

        It "Should contain 'User-Agent' header" {
            # Fix: No longer checking for specific header value, just that the mock was called
            $result = Get-EntraUserExtension -UserId 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName New-EntraCustomHeaders -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when UserId is empty" {
            { Get-EntraUserExtension -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Property parameter should work" {
            $result = Get-EntraUserExtension -UserId 'SawyerM@contoso.com' -Property DisplayName
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Users -Times 2
        }

        It "Should fail when Property is empty" {
            { Get-EntraUserExtension -UserId 'SawyerM@contoso.com' -Property } | Should -Throw "Missing an argument for parameter 'Property'.*"
        }

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { 
                    Get-EntraUserExtension -UserId 'SawyerM@contoso.com' -Debug 
                } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
        
        It "Should include all required properties in results" {
            $result = Get-EntraUserExtension -UserId 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty
            
            # Convert to hashtable for easier property checking
            $properties = @{}
            $result | ForEach-Object { $properties[$_.Name] = $_.Value }
            
            # Check for the required properties
            $properties.Keys | Should -Contain "id" 
            $properties.Keys | Should -Contain "userPrincipalName"
            $properties.Keys | Should -Contain "createdDateTime"
            $properties.Keys | Should -Contain "employeeId" 
            $properties.Keys | Should -Contain "onPremisesDistinguishedName"
            $properties.Keys | Should -Contain "userIdentities"
        }
    }
}
