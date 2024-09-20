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
                "Conditions"           = [PSCustomObject]@{
                    "ClientAppTypes"             = @("all")
                    "ServicePrincipalRiskLevels" = @()
                    "SignInRiskLevels"           = @()
                    "UserRiskLevels"             = @()
                }
                "CreatedDateTime"      = "20-May-24 9:26:07 AM"
                "Description"          = ""
                "DisplayName"          = "MFA policy"
                "GrantControls"        = [PSCustomObject]@{
                    "BuiltInControls"              = @("mfa")
                    "CustomAuthenticationFactors"  = @()
                    "Operator"                     = "OR"
                    "TermsOfUse"                   = @()
                }
                "Id"                   = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                "ModifiedDateTime"     = ""
                "SessionControls"      = [PSCustomObject]@{
                    "DisableResilienceDefaults" = $null
                }
                "State"                = "enabled"
                "TemplateId"           = ""
                "AdditionalProperties" = @{
                    "@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#identity/conditionalAccess/policies/$entity"
                }
                "Parameters"          = $args
            }
        )
    }
    Mock -CommandName Get-MgIdentityConditionalAccessPolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraConditionalAccessPolicy" {
    Context "Test for Get-EntraConditionalAccessPolicy" {
        It "Should retrieves a conditional access policy in Microsoft Entra ID with given ID" {
            $result = Get-EntraConditionalAccessPolicy -PolicyId "0c53a5eb-3efb-4420-bff8-57ebc2913a13"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ObjectId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.DisplayName | Should -Be "MFA policy"
            $result.State | Should -Be "enabled"

            Should -Invoke -CommandName Get-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should retrieves a list of all conditional access policies in Microsoft Entra ID" {
            $result = Get-EntraConditionalAccessPolicy 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Contain "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ObjectId | Should -Contain "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"

            Should -Invoke -CommandName Get-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when PolicyId is empty" {
            { Get-EntraConditionalAccessPolicy -PolicyId } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        }

        It "Should fail when PolicyId is invalid" {
            { Get-EntraConditionalAccessPolicy -PolicyId "" } | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string."
        }

        It "Result should Contain ObjectId" {
            $result = Get-EntraConditionalAccessPolicy -PolicyId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.ObjectId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        } 
      
        It "Should contain ConditionalAccessPolicyId in parameters when passed PolicyId to it" {
            $result = Get-EntraConditionalAccessPolicy -PolicyId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $params = Get-Parameters -data $result.Parameters
            $params.ConditionalAccessPolicyId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraConditionalAccessPolicy"
            $result = Get-EntraConditionalAccessPolicy -PolicyId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraConditionalAccessPolicy"
            Should -Invoke -CommandName Get-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraConditionalAccessPolicy -PolicyId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}