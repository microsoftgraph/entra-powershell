# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @{
        responses = @(
            # Error responses (404)
            [PSCustomObject]@{
                body = [PSCustomObject]@{
                    error = [PSCustomObject]@{
                        code = "Request_ResourceNotFound"
                        message = "Resource 'b9db38b9-e5b8-4b5e-ae78-9812230af58d' does not exist or one of its queried reference-property objects are not present."
                    }
                }
                id = "b9db38b9-e5b8-4b5e-ae78-9812230af58d"
                status = 404
            },
            [PSCustomObject]@{
                body = [PSCustomObject]@{
                    error = [PSCustomObject]@{
                        code = "Request_ResourceNotFound"
                        message = "Resource 'da0c6f50-93ee-4b22-9bb9-c8454875d990' does not exist or one of its queried reference-property objects are not present."
                    }
                }
                id = "da0c6f50-93ee-4b22-9bb9-c8454875d990"
                status = 404
            },
            # Success responses (204)
            [PSCustomObject]@{
                body = $null
                id = "5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62"
                status = 204
            },
            [PSCustomObject]@{
                body = $null
                id = "7bcd4298-a1a4-493e-85a7-9e1ab78c3e72"
                status = 204
            }
        )
    }
}
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
}

Describe "Set-EntraUserSponsor" {
    Context "Test for Set-EntraUserSponsor" {
        It "Should fail when UserId is empty string value" {
            { Set-EntraUserSponsor -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }

        It "Should fail when UserId is empty" {
            { Set-EntraUserSponsor -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should not allow -User and -Group to be used together" {
            { Set-EntraUserSponsor -User -Group -UserId "user-123" -SponsorIds @("sponsor-1") } | 
                Should -Throw  "Parameter set cannot be resolved using the specified named parameters. One or more parameters issued cannot be used together or an insufficient number of parameters were provided."
        }

        It "Should accept both array and scalar values for SponsorIds parameter" {
            { Set-EntraUserSponsor -User -UserId "test-user" -SponsorIds "5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62" } | 
                Should -Not -Throw
            
            { Set-EntraUserSponsor -Group -UserId "test-user" -SponsorIds @("5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62") } | 
                Should -Not -Throw
        }

        It "Should not return anything for successful requests" {
            $result = Set-EntraUserSponsor -UserId 8abd2e2d-1649-43f8-bb99-d95f0024f309  -User  -SponsorIds @("5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62","b9db38b9-e5b8-4b5e-ae78-9812230af58d", "da0c6f50-93ee-4b22-9bb9-c8454875d990", "7bcd4298-a1a4-493e-85a7-9e1ab78c3e72")
            
            $result.Id | Should -Not -Contain "5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62"
            $result.Id | Should -Not -Contain "7bcd4298-a1a4-493e-85a7-9e1ab78c3e72"
        }

        It "Should only return failed responses" {
            $result = Set-EntraUserSponsor -UserId 8abd2e2d-1649-43f8-bb99-d95f0024f309  -User  -SponsorIds @("5e8f2da1-2138-4e6b-8d96-f3c5a5bc7f62","b9db38b9-e5b8-4b5e-ae78-9812230af58d","da0c6f50-93ee-4b22-9bb9-c8454875d990", "7bcd4298-a1a4-493e-85a7-9e1ab78c3e72")
            $result | Should -Not -BeNullOrEmpty
            $result[0].Id | should -Be "b9db38b9-e5b8-4b5e-ae78-9812230af58d"
            $result[0].Error | should -Be "Resource 'b9db38b9-e5b8-4b5e-ae78-9812230af58d' does not exist or one of its queried reference-property objects are not present."

            $result[1].Id | should -Be "da0c6f50-93ee-4b22-9bb9-c8454875d990"
            $result[1].Error | should -Be "Resource 'da0c6f50-93ee-4b22-9bb9-c8454875d990' does not exist or one of its queried reference-property objects are not present."
        }
    }
}