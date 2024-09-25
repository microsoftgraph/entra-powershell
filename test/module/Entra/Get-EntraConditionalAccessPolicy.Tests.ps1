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
                "Id"                   = "aaaaaaaa-1111-2222-3333-ccccccccccc"
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
            $result = Get-EntraConditionalAccessPolicy -PolicyId "aaaaaaaa-1111-2222-3333-ccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-1111-2222-3333-ccccccccccc"
            $result.ObjectId | Should -Be "aaaaaaaa-1111-2222-3333-ccccccccccc"
            $result.DisplayName | Should -Be "MFA policy"
            $result.State | Should -Be "enabled"

            Should -Invoke -CommandName Get-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should retrieves a list of all conditional access policies in Microsoft Entra ID" {
            $result = Get-EntraConditionalAccessPolicy 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Contain "aaaaaaaa-1111-2222-3333-ccccccccccc"
            $result.ObjectId | Should -Contain "aaaaaaaa-1111-2222-3333-ccccccccccc"

            Should -Invoke -CommandName Get-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Property parameter should work" {
            $result = Get-EntraConditionalAccessPolicy -PolicyId "aaaaaaaa-1111-2222-3333-ccccccccccc" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'MFA policy'
        }

        It "Should fail when PolicyId is empty" {
            { Get-EntraConditionalAccessPolicy -PolicyId } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        }

        It "Should fail when PolicyId is invalid" {
            { Get-EntraConditionalAccessPolicy -PolicyId "" } | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string."
        }

        It "Result should Contain ObjectId" {
            $result = Get-EntraConditionalAccessPolicy -PolicyId "aaaaaaaa-1111-2222-3333-ccccccccccc"
            $result.ObjectId | should -Be "aaaaaaaa-1111-2222-3333-ccccccccccc"
        } 
      
        It "Should contain ConditionalAccessPolicyId in parameters when passed PolicyId to it" {
            $result = Get-EntraConditionalAccessPolicy -PolicyId "aaaaaaaa-1111-2222-3333-ccccccccccc"
            $params = Get-Parameters -data $result.Parameters
            $params.ConditionalAccessPolicyId | Should -Be "aaaaaaaa-1111-2222-3333-ccccccccccc"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraConditionalAccessPolicy"
            $result = Get-EntraConditionalAccessPolicy -PolicyId "aaaaaaaa-1111-2222-3333-ccccccccccc"
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
                { Get-EntraConditionalAccessPolicy -PolicyId "aaaaaaaa-1111-2222-3333-ccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}