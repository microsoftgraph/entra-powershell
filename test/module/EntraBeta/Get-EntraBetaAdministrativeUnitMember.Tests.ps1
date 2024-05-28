BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "bbbbbbbb-1111-2222-3333-cccccccccccc"
              "DeletedDateTime"              = $null
              "AdditionalProperties"         = @{
                                                  "@odata.type"          = "#microsoft.graph.user"
                                                  "displayName"          = "Mock-UnitMember"
                                                  "mailEnabled"          =  $True
                                                  "isManagementRestricted"=  $False
                                                  "renewedDateTime"      = "2023-10-18T07:21:48Z"
                                                  "mobilePhone"          = "425-555-0101"
                                                  "businessPhones"       = {"425-555-0101"}
                                                }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaAdministrativeUnitMember -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaAdministrativeUnitMember" {
Context "Test for Get-EntraBetaAdministrativeUnitMember" {
        It "Should return specific administrative unit member" {
            $result = Get-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.AdditionalProperties.DisplayName | Should -Be "Mock-UnitMember"
            $result.AdditionalProperties."@odata.type" | Should -Be "#microsoft.graph.user"

            Should -Invoke -CommandName Get-MgBetaAdministrativeUnitMember -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraBetaAdministrativeUnitMember -ObjectId   } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraBetaAdministrativeUnitMember -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return all administrative unit members" {
            $result = Get-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -All $true
            $result | Should -Not -BeNullOrEmpty            
            
            Should -Invoke -CommandName Get-MgBetaAdministrativeUnitMember -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }
         It "Should fail when All is invalid" {
            { Get-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -All XY } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }
        It "Should return top 1 administrative unit member" {
            $result = Get-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"

            Should -Invoke -CommandName Get-MgBetaAdministrativeUnitMember -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
         It "Should fail when Top is invalid" {
            { Get-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa" -Top XY } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        }
        It "Should contain AdministrativeUnitId in parameters when passed ObjectId to it" {    
            
            $result = Get-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa"
            $params = Get-Parameters -data $result.Parameters
            $params.AdministrativeUnitId | Should -Be "pppppppp-1111-1111-1111-aaaaaaaaaaaa"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAdministrativeUnitMember"

            $result = Get-EntraBetaAdministrativeUnitMember -ObjectId "pppppppp-1111-1111-1111-aaaaaaaaaaaa"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }
}   