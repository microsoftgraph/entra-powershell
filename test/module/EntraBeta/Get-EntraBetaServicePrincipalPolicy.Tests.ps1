BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

$scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                           = "bbbbbbbb-e731-4ec1-a4f6-pepepepa"
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
                    "type"                         = "HomeRealmDiscoveryPolicy"
                    "isOrganizationDefault"        = $false 
                    "createdDateTime"              = "16-08-2023 08:25:02"                       
                    
                }

            )
            "Parameters"                   = $args
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaServicePrincipalPolicy" {
Context "Test for Get-EntraBetaServicePrincipalPolicy" {
        It "Should return specifin service principal policy" {
            $result = Get-EntraBetaServicePrincipalPolicy -Id "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa" 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "bbbbbbbb-e731-4ec1-a4f6-pepepepa"
            $result.displayName | Should -Be "Mock policy"
            $result.type | Should -be "HomeRealmDiscoveryPolicy"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraBetaServicePrincipalPolicy -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraBetaServicePrincipalPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Result should Contain @odata.type" {
            $result = Get-EntraBetaServicePrincipalPolicy -Id "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa" 
            $result."@odata.type" | should -Be "#microsoft.graph.policy"
        }
            # Header testcase get failed
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaServicePrincipalPolicy"

            $result = Get-EntraBetaServicePrincipalPolicy -Id "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa"
            # $A = $result.Parameters
            # write-host $result.Parameters
            $params = Get-Parameters -data $result.Parameters
            # $para = $params | ConvertTo-json | ConvertFrom-json
            # write-host $para
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}    