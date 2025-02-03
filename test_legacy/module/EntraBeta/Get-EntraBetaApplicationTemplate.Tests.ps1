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
                "Categories"                    = "businessMgmt"
                "Description"                   = "Capture and manage your ESG data from across the organization in an integrated, cloud-based platform that connects organizational strategy, automates reporting, and simplifies stakeholder engagement."
                "DisplayName"                   = "FigBytes"
                "HomePageUrl"                   = "https://figbytes.biz/"
                "Id"                            = "bbbbcccc-1111-dddd-2222-eeee3333ffff"
                "LogoUrl"                       = "https://galleryapplogos1.azureedge.net/app-logo/figbytes_AAA12D0E_215.png"
                "Publisher"                     = "Figbytes"
                "SupportedClaimConfiguration"   = [PSCustomObject]@{
                                                    "NameIdPolicyFormat" = $null
                                                }
                "SupportedProvisioningTypes"    = @()
                "SupportedSingleSignOnModes"    = @("saml", "external")
                "AdditionalProperties"          = @{"@odata.context" = "https://graph.microsoft.com/beta/`$metadata#applicationTemplates/`$entity"}
                "InformationalUrls"             = [PSCustomObject]@{
                                                    "AppSignUpUrl"                  = "https://go.microsoft.com/fwlink/?linkid=2190589"
                                                    "SingleSignOnDocumentationUrl"   = $null
                                                }
                "Parameters"             = $args
            }
        )
    }
    Mock -CommandName  Get-MgBetaApplicationTemplate -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaApplicationTemplate" {
    Context "Test for Get-EntraBetaApplicationTemplate" {
        It "Should get a specific application template" {
            $result = Get-EntraBetaApplicationTemplate -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'FigBytes'
            $result.Description | should -Be  "Capture and manage your ESG data from across the organization in an integrated, cloud-based platform that connects organizational strategy, automates reporting, and simplifies stakeholder engagement."

            Should -Invoke -CommandName  Get-MgBetaApplicationTemplate -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraBetaApplicationTemplate -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaApplicationTemplate -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should get a list of all the application templates" {
            $result = Get-EntraBetaApplicationTemplate 
            $result | Should -Not -BeNullOrEmpty
        
            Should -Invoke -CommandName  Get-MgBetaApplicationTemplate -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain Id in result" {
            $result = Get-EntraBetaApplicationTemplate -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result.Id | should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"

            Should -Invoke -CommandName Get-MgBetaApplicationTemplate -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        } 

        It "Should contain ApplicationTemplateId in parameters when passed Id to it" {
            $result = Get-EntraBetaApplicationTemplate -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $params = Get-Parameters -data $result.Parameters
            $params.ApplicationTemplateId | Should -Be "bbbbcccc-1111-dddd-2222-eeee3333ffff"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationTemplate"
            $result = Get-EntraBetaApplicationTemplate -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationTemplate"
            Should -Invoke -CommandName Get-MgBetaApplicationTemplate -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
            $true
           }
       }   

       It "Property parameter should work" {
        $result = Get-EntraBetaApplicationTemplate -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Property DisplayName
        $result | Should -Not -BeNullOrEmpty
        $result.DisplayName | Should -Be 'FigBytes'

        Should -Invoke -CommandName Get-MgBetaApplicationTemplate  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
       }

       It "Should fail when Property is empty" {
        { Get-EntraBetaApplicationTemplate -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
       }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaApplicationTemplate -Id "bbbbcccc-1111-dddd-2222-eeee3333ffff" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}