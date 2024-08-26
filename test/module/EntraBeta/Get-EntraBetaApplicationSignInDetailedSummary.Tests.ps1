BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "bbbbbbbb-1111-2222-3333-cccccccccccc"
              "AppId"                        = "dddddddd-1111-2222-3333-aaaaaaaaaaaa"
              "AppDisplayName"               = "Mock Portal"
              "AggregatedEventDateTime"      = "29-05-2024 00:00:00"
              "SignInCount"                  = "3"
              "Status"                       = @{
                                                  "AdditionalDetails"    = $null
                                                  "ErrorCode"            = "0"
                                                  "FailureReason"        = $null
                                                  "AdditionalProperties" = $null
                                                }
              "AdditionalProperties"         = @{}                           
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaReportApplicationSignInDetailedSummary -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaApplicationSignInDetailedSummary" {
Context "Test for Get-EntraBetaApplicationSignInDetailedSummary" {
        It "Should return specific application signed in detailed summary by filter" {
            $result = Get-EntraBetaApplicationSignInDetailedSummary -Filter "appDisplayName eq 'Mock Portal'"
            $result | Should -Not -BeNullOrEmpty
            $result.AppDisplayName | Should -Be "Mock Portal"
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.AppId | Should -Be "dddddddd-1111-2222-3333-aaaaaaaaaaaa"

            Should -Invoke -CommandName Get-MgBetaReportApplicationSignInDetailedSummary -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when filter is empty" {
            { Get-EntraBetaApplicationSignInDetailedSummary -Filter  } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }
        It "Should return top 1 application signed in detailed summary" {
            $result = Get-EntraBetaApplicationSignInDetailedSummary -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Get-MgBetaReportApplicationSignInDetailedSummary -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaApplicationSignInDetailedSummary -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraBetaApplicationSignInDetailedSummary -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaApplicationSignInDetailedSummary"

            $result = Get-EntraBetaApplicationSignInDetailedSummary -Filter "appDisplayName eq 'Mock Portal'"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}