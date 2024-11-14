# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null) {
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $PSScriptRoot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        #Write-Host "Mocking set-EntraPolicy with parameters: $($args | ConvertTo-Json -Depth 3)"
        
        $response = @{
            '@odata.context' = 'https://graph.microsoft.com/v1.0/$metadata#policies/homeRealmDiscoveryPolicies/$entity'            
        }

        return $response
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaPolicy" {
    Context "Test for Set-EntraBetaPolicy" {
        It "Should return updated Policy" {
            Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Definition @('{"homeRealmDiscoveryPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}') -DisplayName "new update 13" -IsOrganizationDefault $false            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Set-EntraBetaPolicy -Id   } | Should -Throw "Missing an argument for parameter 'Id'*"
        } 

        It "Should fail when Id is invalid" {
            { Set-EntraBetaPolicy -Id ""  } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        } 

        It "Should fail when Definition is empty" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Definition   } | Should -Throw "Missing an argument for parameter 'Definition'*"
        } 

        It "Should fail when DisplayName is empty" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -DisplayName   } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        } 

        It "Should fail when IsOrganizationDefault is empty" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -IsOrganizationDefault   } | Should -Throw "Missing an argument for parameter 'IsOrganizationDefault'*"
        } 

        It "Should fail when IsOrganizationDefault is invalid" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -IsOrganizationDefault ""  } | Should -Throw "Cannot process argument transformation on parameter 'IsOrganizationDefault'*"
        } 

        It "Should fail when KeyCredentials is empty" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -KeyCredentials   } | Should -Throw "Missing an argument for parameter 'KeyCredentials'*"
        } 

        It "Should fail when KeyCredentials is invalid" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -KeyCredentials ""  } | Should -Throw "Cannot process argument transformation on parameter 'KeyCredentials'*"
        } 

        It "Should fail when AlternativeIdentifier is empty" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -AlternativeIdentifier   } | Should -Throw "Missing an argument for parameter 'AlternativeIdentifier'*"
        } 

        It "Should fail when Type is empty" {
            { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Type   } | Should -Throw "Missing an argument for parameter 'Type'*"
        } 

        It "Should return updated Policy when passes Type" {
            Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
            Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Type "HomeRealmDiscoveryPolicy"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaPolicy"
            Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaPolicy"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' -eq $userAgentHeaderValue
                $true
            }
        } 

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaPolicy -Id "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Definition @('{"homeRealmDiscoveryPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}') -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}