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
    Mock -CommandName New-MgIdentityConditionalAccessPolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraMSConditionalAccessPolicy" {
    Context "Test for New-EntraMSConditionalAccessPolicy" {
        It "Should return created Conditional Access Policy Id" {
            $conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
            $conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
            $conditions.Applications.IncludeApplications = "00000002-0000-0ff1-ce00-000000000000"
            $conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
            $conditions.Users.IncludeUsers = "all"
            $controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
            $controls._Operator = "OR"
            $controls.BuiltInControls = "mfa"
            $SessionControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
            $result = New-EntraMSConditionalAccessPolicy -DisplayName "MFA policy" -State "Enabled" -Conditions $conditions -GrantControls $controls -SessionControls $SessionControls
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "0c53a5eb-3efb-4420-bff8-57ebc2913a13"
            $result.ObjectId | Should -Be "0c53a5eb-3efb-4420-bff8-57ebc2913a13"
            $result.DisplayName | Should -Be "MFA policy"
            $result.State | Should -Be "enabled"


            Should -Invoke -CommandName New-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when DisplayName parameter is empty" {
            { New-EntraMSConditionalAccessPolicy -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
        } 

        It "Should fail when State parameter is empty" {
            { New-EntraMSConditionalAccessPolicy -DisplayName "MFA policy" -State } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when Conditions parameter is empty" {
            { New-EntraMSConditionalAccessPolicy -DisplayName "MFA policy" -Conditions  } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when Conditions parameter is invalid" {
            { New-EntraMSConditionalAccessPolicy -DisplayName "MFA policy" -Conditions "" } | Should -Throw "Cannot process argument transformation on parameter 'Conditions'.*"
        }

        It "Should fail when GrantControls parameter is empty" {
            { New-EntraMSConditionalAccessPolicy -DisplayName "MFA policy" -GrantControls } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when GrantControls parameter is invalid" {
            { New-EntraMSConditionalAccessPolicy -DisplayName "MFA policy" -GrantControls "" } | Should -Throw "Cannot process argument transformation on parameter 'GrantControls'.*"
        }

        It "Should fail when SessionControls parameter is empty" {
            { New-EntraMSConditionalAccessPolicy -DisplayName "MFA policy" -SessionControls } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should fail when SessionControls parameter is invalid" {
            { New-EntraMSConditionalAccessPolicy -DisplayName "MFA policy" -SessionControls "" } | Should -Throw "Cannot process argument transformation on parameter 'SessionControls'.*"
        }

        It "Should contain IncludeUsers in parameters when passed Conditions to it" {
            $conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
            $conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
            $conditions.Applications.IncludeApplications = "00000002-0000-0ff1-ce00-000000000000"
            $conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
            $conditions.Users.IncludeUsers = "all"
            $Controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
            $SessionControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
            $result = New-EntraMSConditionalAccessPolicy -DisplayName "MFA policy" -State "Enabled" -Conditions $conditions -GrantControls $controls -SessionControls $SessionControls
            $result | Should -Not -BeNullOrEmpty
            $params = Get-Parameters -data $result.Parameters
            $params.Conditions.Users.IncludeUsers | Should -Be "all"

            Should -Invoke -CommandName New-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should contain BuiltInControls in parameters when passed GrantControls to it" {
            $conditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
            $conditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
            $conditions.Applications.IncludeApplications = "00000002-0000-0ff1-ce00-000000000000"
            $conditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
            $conditions.Users.IncludeUsers = "all"
            $controls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
            $controls._Operator = "OR"
            $controls.BuiltInControls = "mfa"
            $SessionControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls
            $result = New-EntraMSConditionalAccessPolicy -DisplayName "MFA policy" -State "Enabled" -Conditions $conditions -GrantControls $controls -SessionControls $SessionControls
            $result | Should -Not -BeNullOrEmpty
            $params = Get-Parameters -data $result.Parameters
            $params.GrantControls.BuiltInControls | Should -Be "mfa"

            Should -Invoke -CommandName New-MgIdentityConditionalAccessPolicy -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraMSConditionalAccessPolicy"

            $result = New-EntraMSConditionalAccessPolicy -DisplayName "MFA policy" -State "Enabled" -Conditions $conditions -GrantControls $controls -SessionControls $SessionControls
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }  
    }
}