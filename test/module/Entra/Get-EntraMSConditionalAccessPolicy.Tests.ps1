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
                "Id"                   = "0c53a5eb-3efb-4420-bff8-57ebc2913a13"
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

Describe "Get-EntraMSConditionalAccessPolicy" {
    Context "Test for Get-EntraMSConditionalAccessPolicy" {
        It "Should retrieves a conditional access policy in Microsoft Entra ID with given ID" {
            $result = Get-EntraMSConditionalAccessPolicy -PolicyId "0c53a5eb-3efb-4420-bff8-57ebc2913a13"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "0c53a5eb-3efb-4420-bff8-57ebc2913a13"
            $result.ObjectId | Should -Be "0c53a5eb-3efb-4420-bff8-57ebc2913a13"
            $result.DisplayName | Should -Be "MFA policy"
            $result.State | Should -Be "enabled"

            Should -Invoke -CommandName Get-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should retrieves a list of all conditional access policies in Microsoft Entra ID" {
            $result = Get-EntraMSConditionalAccessPolicy 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Contain "0c53a5eb-3efb-4420-bff8-57ebc2913a13"
            $result.ObjectId | Should -Contain "0c53a5eb-3efb-4420-bff8-57ebc2913a13"

            Should -Invoke -CommandName Get-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when PolicyId is empty" {
            { Get-EntraMSConditionalAccessPolicy -PolicyId } | Should -Throw "Missing an argument for parameter 'PolicyId'*"
        }

        It "Should fail when PolicyId is invalid" {
            { Get-EntraMSConditionalAccessPolicy -PolicyId "" } | Should -Throw "Cannot bind argument to parameter 'PolicyId' because it is an empty string."
        }

        It "Result should Contain ObjectId" {
            $result = Get-EntraMSConditionalAccessPolicy -PolicyId "0c53a5eb-3efb-4420-bff8-57ebc2913a13"
            $result.ObjectId | should -Be "0c53a5eb-3efb-4420-bff8-57ebc2913a13"
        } 
      
        It "Should contain ConditionalAccessPolicyId in parameters when passed PolicyId to it" {
            $result = Get-EntraMSConditionalAccessPolicy -PolicyId "0c53a5eb-3efb-4420-bff8-57ebc2913a13"
            $params = Get-Parameters -data $result.Parameters
            $params.ConditionalAccessPolicyId | Should -Be "0c53a5eb-3efb-4420-bff8-57ebc2913a13"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSConditionalAccessPolicy"

            $result = Get-EntraMSConditionalAccessPolicy -PolicyId "0c53a5eb-3efb-4420-bff8-57ebc2913a13"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Contain $userAgentHeaderValue
        }    
    }
}