BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $PSScriptRoot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                               = "90deae61-b9bf-4063-8b18-a4e64adc51f6"
                    "onPremisesImmutableId"            = $null
                    "deletedDateTime"                  = $null
                    "onPremisesSyncEnabled"            = $null
                    "OnPremisesLastSyncDateTime"       = $null
                    "onPremisesProvisioningErrors"     = @{}
                    "mobilePhone"                      = "425-555-0100"
                    "BusinessPhones"                   = @("425-555-0100")
                    "ExternalUserState"                = $null
                    "ExternalUserStateChangeDateTime"  = $null
                    "Parameters"                       = $args
                }
            )
        }
    }
    

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}



Describe "Get-EntraUserDirectReport" {
    Context "Test for Get-EntraUserDirectReport" {
        It "Should return specific user direct report" {
            $result = Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '90deae61-b9bf-4063-8b18-a4e64adc51f6'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraUserDirectReport -ObjectId   } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraUserDirectReport -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        }
        It "Should return all user direct reports" {
            $result = Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf" -All $true
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '90deae61-b9bf-4063-8b18-a4e64adc51f6'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf" -All  } | Should -Throw "Missing an argument for parameter 'All'*"
        }
        It "Should fail when All is invalid" {
            { Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf" -All xyz } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }
        It "Should return top 1 user direct report" {
            $result = Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '90deae61-b9bf-4063-8b18-a4e64adc51f6'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when top is empty" {
            { Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf" -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when top is invalid" {
            { Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Result should contain Alias property" {
            $result = Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf"
            $result.ObjectId | should -Be "90deae61-b9bf-4063-8b18-a4e64adc51f6"
            $result.DeletionTimestamp | should -Be $null
            $result.DirSyncEnabled | should -Be $null
            $result.ImmutableId | should -Be $null
            $result.LastDirSyncTime | should -Be $null
            $result.Mobile | should -Be "425-555-0100"
            $result.ProvisioningErrors | Should -BeNullOrEmpty
            $result.TelephoneNumber | should -Be "425-555-0100"
            $result.UserState | should -Be $null
            $result.UserStateChangedOn | should -Be $null

        }
        It "Should contain UserId in parameters when passed ObjectId to it" { 

            $result = Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf"
            $params = Get-Parameters -data $result.Parameters
            $para= $params | ConvertTo-json | ConvertFrom-Json
            $para.URI  | Should -Match "c300541f-2c03-49cb-b25b-72f09cb29abf"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserDirectReport"

            $result = Get-EntraUserDirectReport -ObjectId "c300541f-2c03-49cb-b25b-72f09cb29abf"
            $params = Get-Parameters -data $result.Parameters
            $para= $params | ConvertTo-json | ConvertFrom-Json
            $para.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }


    }

}