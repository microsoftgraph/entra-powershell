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
                    "alternativeIdentifier"        = $null
                    "displayName"                  = "Mock application policy"
                    "type"                         = "HomeRealmDiscoveryPolicy"
                    "isOrganizationDefault"        = $false 
                    "createdDateTime"              = "16-08-2023 08:25:02"      
                    "Parameters"                   = $args                
                }
            
            )
            
        }

    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaApplicationPolicy" {
Context "Test for Get-EntraBetaApplicationPolicy" {
        It "Should return specific application policy" {
            $result = Get-EntraBetaApplicationPolicy -Id "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa" 
            $result | Should -Not -BeNullOrEmpty
            write-host $result
            $result.Id | Should -Be "bbbbbbbb-e731-4ec1-a4f6-pepepepa"
            $result.displayName | Should -Be "Mock application policy"
            $result.type | Should -be "HomeRealmDiscoveryPolicy"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraBetaApplicationPolicy -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Get-EntraBetaApplicationPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Result should Contain @odata.type" {
            $result = Get-EntraBetaApplicationPolicy -Id "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa" 
            $result."@odata.type" | should -Be "#microsoft.graph.policy"
        }
        It "Should contain 'User-Agent' header" {


            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationPolicy"
            
            $result = Get-EntraBetaApplicationPolicy -Id "pppppppp-b5d0-aaaa-ahbg-aaaaaaaa"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
    }
}    