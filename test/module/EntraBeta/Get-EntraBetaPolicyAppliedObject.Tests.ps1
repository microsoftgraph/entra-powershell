BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    

$scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                           = "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa"
                    "DeletedDateTime"              = $null
                    "@odata.type"                   = "#microsoft.graph.servicePrincipal"
                    "keyCredentials"               = "System.Collections.Hashtable"
                    "appId"                        = "0e2f044c-def9-4f98-8c82-41606d311450"
                    "servicePrincipalNames"        = "Mock service principal"
                    "displayName"                  = "Mock policy Object"
                    "type"                         = "HomeRealmDiscoveryPolicy"
                    "preferredSingleSignOnMode"    = "password"
                    "createdDateTime"              = "16-08-2023 08:25:02"   
                    "Parameters"                   = $args                    
                }
            )
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaPolicyAppliedObject" {
Context "Test for Get-EntraBetaPolicyAppliedObject" {
        It "Should return policy applied object" {
            $result = Get-EntraBetaPolicyAppliedObject -Id "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa"  
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa"
            $result.displayName | Should -Be "Mock policy Object"
            $result.servicePrincipalNames | Should -be "Mock service principal"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraBetaPolicyAppliedObject -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraBetaPolicyAppliedObject -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Result should Contain @odata.type" {
            $result = Get-EntraBetaPolicyAppliedObject -Id "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa" 
            $result."@odata.type" | should -Be "#microsoft.graph.servicePrincipal"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPolicyAppliedObject"
            
            $result = Get-EntraBetaPolicyAppliedObject -Id "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa" 
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
    }
}