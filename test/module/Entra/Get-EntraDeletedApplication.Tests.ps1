# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "AddIns"                            = {}
                "AppRoles"                          = {}
                "GroupMembershipClaims"             = {}
                "IdentifierUris"                    = {}
                "Info"                              = @{
                                                        LogoUrl="";
                                                    }
                "IsDeviceOnlyAuthSupported"         = $null
                "KeyCredentials"                    = {}
                "OptionalClaims"                    = {}
                "ParentalControlSettings"           = @{
                                                        CountriesBlockedForMinors=@{}; 
                                                        LegalAgeGroupRule="Allow";
                                                    }
                "PasswordCredentials"               = {}
                "Api"                               = @{
                                                        KnownClientApplications=@{};
                                                        PreAuthorizedApplications=@{};
                                                    }
                "PublicClient"                      = @{
                                                        RedirectUris=@{};
                                                    }
                "PublisherDomain"                   = "contoso.com"
                "Web"                               = @{
                                                        HomePageUrl="";  
                                                        LogoutUrl=""; 
                                                        RedirectUris=@{};
                                                        Oauth2AllowImplicitFlow=""
                                                    }
                "RequiredResourceAccess"            = $null                
                "DisplayName"                       = "Mock-test-App"
                "Id"                                = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "Logo"                              = $null
                "Parameters"                        = $args
            }
        )
    }

    Mock -CommandName Get-MgDirectoryDeletedItemAsApplication -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraDeletedApplication" {
    Context "Test for Get-EntraDeletedApplication" {        
        It "Should return all applications" {
            $result = Get-EntraDeletedApplication | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraDeletedApplication -All $true} | Should -Throw "A positional parameter cannot be found that accepts argument 'True'.*"
        }
        It "Should fail when invalid parameter is passed" {
            { Get-EntraDeletedApplication -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'*"
        }         
        It "Should return specific application by searchstring" {
            $result = Get-EntraDeletedApplication -SearchString 'Mock-test-App' | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-test-App'

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Graph.Entra -Times 1
        } 
        It "Should return specific application by filter" {
            $result = Get-EntraDeletedApplication -Filter "DisplayName -eq 'Mock-test-App'" | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Mock-test-App'

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Should return top application" {
            $result = Get-EntraDeletedApplication -Top 1 | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraDeletedApplication -Filter "DisplayName -eq 'Mock-test-App'" | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $result.ObjectId | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }
        It "Should contain Filter in parameters when passed SearchString to it" {               
            $result = Get-EntraDeletedApplication -SearchString 'Mock-test-App' | ConvertTo-Json -Depth 10| ConvertFrom-Json
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Match "Mock-test-App"
        }
        It "Property parameter should work" {
            $result = Get-EntraDeletedApplication -Property "DisplayName"  | ConvertTo-Json | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "Mock-test-App"

            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Property is empty" {
             { Get-EntraDeletedApplication  -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedApplication"
            $result =  Get-EntraDeletedApplication -Filter "DisplayName -eq 'Mock-test-App'" | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedApplication"    
            Should -Invoke -CommandName Get-MgDirectoryDeletedItemAsApplication -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                {  Get-EntraDeletedApplication -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}