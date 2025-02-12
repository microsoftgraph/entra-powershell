# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "AddIns"                    = {}
                "AppRoles"                  = {}
                "GroupMembershipClaims"     = {}
                "IdentifierUris"            = {}
                "Info"                      = @{
                    LogoUrl = "";
                }
                "IsDeviceOnlyAuthSupported" = $null
                "KeyCredentials"            = {}
                "OptionalClaims"            = {}
                "ParentalControlSettings"   = @{
                    CountriesBlockedForMinors = @{}; 
                    LegalAgeGroupRule         = "Allow";
                }
                "PasswordCredentials"       = {}
                "Api"                       = @{
                    KnownClientApplications   = @{};
                    PreAuthorizedApplications = @{};
                }
                "PublicClient"              = @{
                    RedirectUris = @{};
                }
                "PublisherDomain"           = "contoso.com"
                "Web"                       = @{
                    HomePageUrl             = "";  
                    LogoutUrl               = ""; 
                    RedirectUris            = @{};
                    Oauth2AllowImplicitFlow = ""
                }
                "RequiredResourceAccess"    = $null                
                "DisplayName"               = "Mock-test-App"
                "Id"                        = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "Logo"                      = $null
                "Parameters"                = $args
                "DeletedDateTime"           = "02/12/2025 11:07:07"
                "DeletionAgeInDays"         = 0
            }
        )
    }

    Mock -CommandName Get-MgDirectoryDeletedItemAsApplication -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
}

Describe "Get-EntraDeletedApplication" {
    Context "Test for Get-EntraDeletedApplication" {        
        It "Should return all deleted applications" {
            $result = Get-EntraDeletedApplication -All | ConvertTo-Json -Depth 5 | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should fail when invalid parameter is passed" {
            { Get-EntraDeletedApplication -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'*"
        }         
        It "Should return specific application by SearchString" {
            $result = Get-EntraDeletedApplication -SearchString 'Mock-test-App' | ConvertTo-Json -Depth 5 | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Applications -Times 1
        } 
        It "Should return specific application by filter" {
            $result = Get-EntraDeletedApplication -Filter "DisplayName -eq 'Mock-test-App'" | ConvertTo-Json -Depth 5 | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }  
        It "Should return top application" {
            $result = Get-EntraDeletedApplication -Top 1 | ConvertTo-Json -Depth 5 | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraDeletedApplication -Filter "DisplayName -eq 'Mock-test-App'" | ConvertTo-Json -Depth 5 | ConvertFrom-Json
            $result.ObjectId | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {               
            $result = Get-EntraDeletedApplication -SearchString 'Mock-test-App' | ConvertTo-Json -Depth 5 | ConvertFrom-Json
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Mock-test-App"
        }
        It "Property parameter should work" {
            $result = Get-EntraDeletedApplication -Property "DisplayName"  | ConvertTo-Json | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Mock-test-App"

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should fail when Property is empty" {
            { Get-EntraDeletedApplication  -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedApplication"
            $result = Get-EntraDeletedApplication -Filter "DisplayName -eq 'Mock-test-App'" | ConvertTo-Json -Depth 5 | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedApplication"    
            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Get-EntraDeletedApplication -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}


# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        @{
            "description"                   = "test111"
            "membershipRule"                = $null
            "membershipRuleProcessingState" = $null
            "id"                            = "aaaaaaaa-2222-3333-4444-bbbbbbbbbbbb"
            "deletedDateTime"               = $null
            "visibility"                    = $null
            "displayName"                   = "test111"
            "membershipType"                = $null
            "Parameters"                    = $args
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement
}
Describe "Tests for Get-EntraDeletedApplication" {
    It "Result should not be empty" {
        $result = Get-EntraDeletedApplication -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Result should not be empty objectid" {
        $result = Get-EntraDeletedApplication -ObjectId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }    
    It "Should fail when AdministrativeUnitId is empty" {
        { Get-EntraDeletedApplication -AdministrativeUnitId "" } | Should -Throw "Cannot bind argument to parameter 'AdministrativeUnitId'*"
    }
    It "Should fail when AdministrativeUnitId is null" {
        { Get-EntraDeletedApplication -AdministrativeUnitId } | Should -Throw "Missing an argument for parameter 'AdministrativeUnitId'*"
    }    
    It "Should fail when All has an argument" {
        { Get-EntraDeletedApplication -All $true } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
    }
    It "Should fail when filter is empty" {
        { Get-EntraDeletedApplication -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
    }
    It "Should fail when Top is empty" {
        { Get-EntraDeletedApplication -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
    }
    It "Should fail when Top is invalid" {
        { Get-EntraDeletedApplication -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
    }         
    It "Should fail when invalid parameter is passed" {
        { Get-EntraDeletedApplication -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should return specific AdministrativeUnit by filter" {
        $result = Get-EntraDeletedApplication -Filter "displayName -eq 'test111'"
        $result | Should -Not -BeNullOrEmpty
        $result.DisplayName | should -Be 'test111'
        Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }  
    It "Should return top AdministrativeUnit" {
        $result = @(Get-EntraDeletedApplication -Top 1)
        $result | Should -Not -BeNullOrEmpty
        $result | Should -HaveCount 1 
        Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }  
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedApplication"
        $result = Get-EntraDeletedApplication -AdministrativeUnitId "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedApplication"
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
            { Get-EntraDeletedApplication -Top 1 -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}



