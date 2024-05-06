BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        # Write-Host "Mocking Get-EntraUserOwnedObject with parameters: $($args | ConvertTo-Json -Depth 3)"

        return @{
            value = @(
                @{
                    Id                    = "02228a68-e98d-4b37-bc69-e2eaf8d324e9e"
                    applicationTemplateId = "1cdcd90d-0bf2-4bb8-bc20-a3f5b30b251e"
                    appId                 = "8886ad7b-1795-4542-9808-c85859d97f23"
                    displayName           = "ToGraph_443DEM"
                    signInAudience        = "AzureADMyOrg"
                    publisherDomain       = "M365x99297270.onmicrosoft.com"
                    Parameters            = $args
                }
            )
        }
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraUserOwnedObject" {
    Context "Test for Get-EntraUserOwnedObject" {
        It "Should return specific User" {
            $result = Get-EntraUserOwnedObject -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "02228a68-e98d-4b37-bc69-e2eaf8d324e9e"
            $result.applicationTemplateId | Should -Be "1cdcd90d-0bf2-4bb8-bc20-a3f5b30b251e"
            $result.appId | Should -Be "8886ad7b-1795-4542-9808-c85859d97f23"
            $result.signInAudience | Should -Be "AzureADMyOrg"
            $result.publisherDomain | Should -Be "M365x99297270.onmicrosoft.com"
            $result.DisplayName | Should -Be "ToGraph_443DEM"


            should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty string value" {
            { Get-EntraUserOwnedObject -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraUserOwnedObject -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should return top user" {
            $result = Get-EntraUserOwnedObject -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top 1
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        }    

        It "Should fail when top is empty" {
            { Get-EntraUserOwnedObject -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }  

        It "Should fail when top is invalid" {
            { Get-EntraUserOwnedObject -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top HH } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }  

        It "Should contain UserId in parameters when passed ObjectId to it" {
            $result = Get-EntraUserOwnedObject -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.Uri | Should -Match "fd560167-ff1f-471a-8d74-3b0070abcea1"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserOwnedObject"
            $result = Get-EntraUserOwnedObject -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }  

    }
}