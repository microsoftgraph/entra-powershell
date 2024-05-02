BeforeAll{
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        # Write-Host "Mocking Get-EntraUser with parameters: $($args | ConvertTo-Json -Depth 3)"

        return @(
            [PSCustomObject]@{
                Id = "fd560167-ff1f-471a-8d74-3b0070abcea1"
                ExternalUserState = $null
                ExternalUserStateChangeDateTime = $null
                mobilePhone = "123456789"
                DeletedDateTime = $null
                AssignedLicenses = $null
                AssignedPlans = $null
                PasswordProfile = $null
                DisplayName = "Conf Room Adams"
                Parameters = $args
            }
        )

    }

    Mock -CommandName Get-MgUser -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraUser"{
    Context "Test for Get-EntraUser" {
        It "Should return specific User" {
            $result = Get-EntraUser -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea11"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result.UserState | should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"

            should -Invoke -CommandName Get-MgUser -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty string value" {
           {Get-EntraUser -ObjectId ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when ObjectId is empty" {
            {Get-EntraUser -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'. Specify a parameter of type 'System.String' and try again."
         }

         It "Should return all contact" {
            $result = Get-EntraUser -All $true
            $result | Should -Not -BeNullOrEmpty            

            Should -Invoke -CommandName Get-MgUser  -ModuleName Microsoft.Graph.Entra -Times 1
        }

         It "Should fail when All is empty" {
            { Get-EntraUser -All } | Should -Throw "Missing an argument for parameter 'All'*"
        }

        It "Should fail when All is invalid" {
            { Get-EntraContact -All XY } | Should -Throw  "Cannot process argument transformation on parameter 'All'*"
        }  

        It "Should return top user" {
            $result = Get-EntraUser -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgUser  -ModuleName Microsoft.Graph.Entra -Times 1
        }    

        It "Should fail when top is empty" {
            { Get-EntraUser -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraUser -Top HH } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Should return specific user by filter" {
            $result = Get-EntraUser -Filter "DisplayName eq 'Conf Room Adams'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Conf Room Adams'

            Should -Invoke -CommandName Get-MgUser  -ModuleName Microsoft.Graph.Entra -Times 1
        } 

        It "Should fail when Missing an argument for parameter Filter" {
            { Get-EntraUser -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        } 

        It "Should contain UserId in parameters when passed ObjectId to it" {
            $result = Get-EntraUser -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Match "fd560167-ff1f-471a-8d74-3b0070abcea1"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUser"
            $result = Get-EntraUser -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }  

    }
}