# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @{
            responses = @(
                # Error responses (404)
                [PSCustomObject]@{
                    body   = [PSCustomObject]@{
                        error = [PSCustomObject]@{
                            code    = "Request_ResourceNotFound"
                            message = "Resource 'b9db38b9-e5b8-4b5e-ae78-9812230af58d' does not exist or one of its queried reference-property objects are not present."
                        }
                    }
                    id     = "b9db38b9-e5b8-4b5e-ae78-9812230af58d"
                    status = 404
                },
                [PSCustomObject]@{
                    body   = [PSCustomObject]@{
                        error = [PSCustomObject]@{
                            code    = "Request_ResourceNotFound"
                            message = "Resource 'da0c6f50-93ee-4b22-9bb9-c8454875d990' does not exist or one of its queried reference-property objects are not present."
                        }
                    }
                    id     = "da0c6f50-93ee-4b22-9bb9-c8454875d990"
                    status = 404
                },
                # Success responses (204)
                [PSCustomObject]@{
                    body   = $null
                    id     = "5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62"
                    status = 204
                },
                [PSCustomObject]@{
                    body   = $null
                    id     = "7bcd4298-a1a4-493e-85a7-9e1ab78c3e72"
                    status = 204
                }
            )
        }
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Users
    Mock -CommandName Get-EntraContext -MockWith { 
        @{
            Environment = "Global"
            Scopes      = @("User.ReadWrite.All") 
        }
    } -ModuleName Microsoft.Entra.Beta.Users
    Mock -CommandName Get-EntraEnvironment -MockWith { return @{
            GraphEndpoint = "https://graph.microsoft.com"
        } } -ModuleName Microsoft.Entra.Beta.Users
}

Describe "Set-EntraBetaUserSponsor" {
    Context "Test for Set-EntraBetaUserSponsor" {

        It "Should fail when UserId is empty" {
            { Set-EntraBetaUserSponsor -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should only allow User and Group for type" {
            { Set-EntraBetaUserSponsor -UserId "bedf70bd-0158-46ae-99ef-e7b5f5fc996f" -Type User -SponsorIds "5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62" } | Should -Not -Throw
            { Set-EntraBetaUserSponsor -UserId "bedf70bd-0158-46ae-99ef-e7b5f5fc996f" -Type Group -SponsorIds "5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62" } | Should -Not -Throw
            { Set-EntraBetaUserSponsor -UserId "bedf70bd-0158-46ae-99ef-e7b5f5fc996f" -Type Users -SponsorIds "5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62" } | 
            Should -Throw
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUserSponsor"

            $result = Set-EntraBetaUserSponsor -UserId "bedf70bd-0158-46ae-99ef-e7b5f5fc996f" -Type User -SponsorIds @("5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62", "b9db38b9-e5b8-4b5e-ae78-9812230af58d", "da0c6f50-93ee-4b22-9bb9-c8454875d990", "7bcd4298-a1a4-493e-85a7-9e1ab78c3e72")
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaUserSponsor"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It "Should accept both array and scalar values for SponsorIds parameter" {
            { Set-EntraBetaUserSponsor -Type User -UserId "bedf70bd-0158-46ae-99ef-e7b5f5fc996f" -SponsorIds "5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62" } | 
            Should -Not -Throw
            { Set-EntraBetaUserSponsor -Type User -UserId "bedf70bd-0158-46ae-99ef-e7b5f5fc996f" -SponsorIds @("5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62") } |
            Should -Not -Throw
            { Set-EntraBetaUserSponsor -Type Group -UserId "bedf70bd-0158-46ae-99ef-e7b5f5fc996f" -SponsorIds @("5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62") } | 
            Should -Not -Throw
            { Set-EntraBetaUserSponsor -Type Group -UserId "bedf70bd-0158-46ae-99ef-e7b5f5fc996f" -SponsorIds "5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62" } |
            Should -Not -Throw
        }

        It "Should not return anything for successful requests" {
            $result = Set-EntraBetaUserSponsor -UserId "bedf70bd-0158-46ae-99ef-e7b5f5fc996f" -Type User -SponsorIds @("5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62", "b9db38b9-e5b8-4b5e-ae78-9812230af58d", "da0c6f50-93ee-4b22-9bb9-c8454875d990", "7bcd4298-a1a4-493e-85a7-9e1ab78c3e72")
            
            $result.Id | Should -Not -Contain "5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62"
            $result.Id | Should -Not -Contain "7bcd4298-a1a4-493e-85a7-9e1ab78c3e72"
        }

        It "Should only return failed responses" {
            $result = Set-EntraBetaUserSponsor -UserId 8abd2e2d-1649-43f8-bb99-d95f0024f309 -Type User -SponsorIds @("5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62", "b9db38b9-e5b8-4b5e-ae78-9812230af58d", "da0c6f50-93ee-4b22-9bb9-c8454875d990", "7bcd4298-a1a4-493e-85a7-9e1ab78c3e72")
            $result | Should -Not -BeNullOrEmpty
            $result[0].Id | should -Be "b9db38b9-e5b8-4b5e-ae78-9812230af58d"
            $result[0].Error | should -Be "Resource 'b9db38b9-e5b8-4b5e-ae78-9812230af58d' does not exist or one of its queried reference-property objects are not present."

            $result[1].Id | should -Be "da0c6f50-93ee-4b22-9bb9-c8454875d990"
            $result[1].Error | should -Be "Resource 'da0c6f50-93ee-4b22-9bb9-c8454875d990' does not exist or one of its queried reference-property objects are not present."
        }
    }
}