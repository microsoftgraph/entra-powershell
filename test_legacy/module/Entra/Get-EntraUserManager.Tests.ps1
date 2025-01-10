# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        # Write-Host "Mocking Get-EntraUserManager with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                Id                         = '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
                ageGroup                   = $null
                onPremisesLastSyncDateTime = $null
                creationType               = $null
                imAddresses                = @("test@contoso.com")
                preferredLanguage          = $null
                mail                       = "test@contoso.com"
                securityIdentifier         = "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
                identities                 = @(
                    @{
                        signInType       = "userPrincipalName"
                        issuer           = "contoso.com"
                        issuerAssignedId = "test@contoso.com"
                    }
                )
                Parameters                 = $args
            }
        )

    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraUserManager" {
    Context "Test for Get-EntraUserManager" {
        It "Should return specific User" {
            $result = Get-EntraUserManager -UserId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty
            $result.ageGroup | Should -BeNullOrEmpty
            $result.onPremisesLastSyncDateTime | Should -BeNullOrEmpty
            $result.creationType | Should -BeNullOrEmpty
            $result.imAddresses | Should -Be @("test@contoso.com")
            $result.preferredLanguage | Should -BeNullOrEmpty
            $result.mail | Should -Be "test@contoso.com"
            $result.securityIdentifier | Should -Be "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            $result.identities | Should -HaveCount 1
            $result.identities[0].signInType | Should -Be "userPrincipalName"
            $result.identities[0].issuer | Should -Be "contoso.com"
            $result.identities[0].issuerAssignedId | Should -Be "test@contoso.com"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should return specific User wit alias" {
            $result = Get-EntraUserManager -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty
            $result.ageGroup | Should -BeNullOrEmpty
            $result.onPremisesLastSyncDateTime | Should -BeNullOrEmpty
            $result.creationType | Should -BeNullOrEmpty
            $result.imAddresses | Should -Be @("test@contoso.com")
            $result.preferredLanguage | Should -BeNullOrEmpty
            $result.mail | Should -Be "test@contoso.com"
            $result.securityIdentifier | Should -Be "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
            $result.identities | Should -HaveCount 1
            $result.identities[0].signInType | Should -Be "userPrincipalName"
            $result.identities[0].issuer | Should -Be "contoso.com"
            $result.identities[0].issuerAssignedId | Should -Be "test@contoso.com"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when UserId is empty string value" {
            { Get-EntraUserManager -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }

        It "Should fail when UserId is empty" {
            { Get-EntraUserManager -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should contain UserId in parameters when passed UserId to it" {
            $result = Get-EntraUserManager -UserId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $params = Get-Parameters -data $result.Parameters
            $params.Uri | Should -Match "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserManager"

            $result = Get-EntraUserManager -UserId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserManager"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 

        It "Property parameter should work" {
            $result = Get-EntraUserManager -UserId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property Id 
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Property is empty" {
             { Get-EntraUserManager -UserId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }

        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraUserManager -UserId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}
