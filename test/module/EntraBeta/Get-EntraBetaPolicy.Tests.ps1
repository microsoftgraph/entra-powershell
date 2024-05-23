BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "deletedDateTime"       = $null
                "id"                    = "364e07d3-529b-4ffc-96be-56bbacf34ace"
                "displayName"           = "New update"
                "definition"            = @(
                                            @{
                                                "activityBasedTimeoutPolicies" = @{
                                                    "AlternateLoginIDLookup" = $true
                                                    "IncludedUserIds" = @("UserID")
                                                }
                                            }
                                         )
                "isOrganizationDefault" = $false
                "Type"                  = "HomeRealmDiscoveryPolicy"
                "Parameters"            = $args
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaPolicy" {
    Context "Test for Get-EntraBetaPolicy" {
        It "Should retrieve the Id of the policy you want to" {
            $result = Get-EntraBetaPolicy -Id "364e07d3-529b-4ffc-96be-56bbacf34ace"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraBetaPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should return all policy" {
            $group = Get-EntraBetaPolicy -All $true
            $group | Should -Not -BeNullOrEmpty            

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraBetaPolicy -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }  

        It "Should fail when All is invalid" {
            { Get-EntraBetaPolicy -All "" } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }     

        It "Should return top policy" {
            $top = Get-EntraBetaPolicy -Top 5
            $top | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }  

        It "Should fail when top is empty" {
            { Get-EntraBetaPolicy -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPolicy"

            $result = Get-EntraBetaPolicy -Id "364e07d3-529b-4ffc-96be-56bbacf34ace"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Contain $userAgentHeaderValue
        }    
    }
}