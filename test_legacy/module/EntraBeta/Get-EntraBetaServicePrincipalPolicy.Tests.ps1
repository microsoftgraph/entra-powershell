# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

$scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                           = "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
                    "DeletedDateTime"              = $null
                    "@odata.type"                  = "#microsoft.graph.policy"
                    "keyCredentials"               = $null
                    "alternativeIdentifier"        = "value1"
                    "definition"                   = @{"activityBasedTimeoutPolicies" = @{
                                                                                            "AlternateLoginIDLookup"= $true 
                                                                                            "IncludedUserIds"      = "UserID"
                                                                                         }
                                                }
                    "displayName"                  = "Mock policy"
                    "type"                         = "activityBasedTimeoutPolicy"
                    "isOrganizationDefault"        = $false 
                    "createdDateTime"              = "16-08-2023 08:25:02"                       
                }
            )
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaServicePrincipalPolicy" {
    Context "Test for Get-EntraBetaServicePrincipalPolicy" {
        It "Should return specific service principal policy" {
            $result = Get-EntraBetaServicePrincipalPolicy -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result.displayName | Should -Be "Mock policy"
            $result.ServicePrincipalType | Should -be "activityBasedTimeoutPolicy"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraBetaServicePrincipalPolicy -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraBetaServicePrincipalPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Result should Contain @odata.type" {
            $result = Get-EntraBetaServicePrincipalPolicy -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" 
            $result."@odata.type" | should -Be "#microsoft.graph.policy"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaServicePrincipalPolicy"
            
            $result = Get-EntraBetaServicePrincipalPolicy -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaServicePrincipalPolicy"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaServicePrincipalPolicy -Id "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}    