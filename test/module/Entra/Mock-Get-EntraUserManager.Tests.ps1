BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        # Write-Host "Mocking Get-EntraUserManager with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                Id                         = '412be9d1-1460-4061-8eed-cca203fcb215'
                ageGroup                   = $null
                onPremisesLastSyncDateTime = $null
                creationType               = $null
                imAddresses                = @("miriamg@m365x99297270.onmicrosoft.com")
                preferredLanguage          = $null
                mail                       = "MiriamG@M365x99297270.OnMicrosoft.com"
                securityIdentifier         = "S-1-12-1-649798363-1255893902-1277583799-1163042182"
                identities                 = @(
                    @{
                        signInType       = "userPrincipalName"
                        issuer           = "M365x99297270.onmicrosoft.com"
                        issuerAssignedId = "MiriamG@M365x99297270.OnMicrosoft.com"
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
            $result = Get-EntraUserManager -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
            $result | Should -Not -BeNullOrEmpty
            $result.ageGroup | Should -BeNullOrEmpty
            $result.onPremisesLastSyncDateTime | Should -BeNullOrEmpty
            $result.creationType | Should -BeNullOrEmpty
            $result.imAddresses | Should -Be @("miriamg@m365x99297270.onmicrosoft.com")
            $result.preferredLanguage | Should -BeNullOrEmpty
            $result.mail | Should -Be "MiriamG@M365x99297270.OnMicrosoft.com"
            $result.securityIdentifier | Should -Be "S-1-12-1-649798363-1255893902-1277583799-1163042182"
            $result.identities | Should -HaveCount 1
            $result.identities[0].signInType | Should -Be "userPrincipalName"
            $result.identities[0].issuer | Should -Be "M365x99297270.onmicrosoft.com"
            $result.identities[0].issuerAssignedId | Should -Be "MiriamG@M365x99297270.OnMicrosoft.com"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty string value" {
            { Get-EntraUserManager -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when ObjectId is empty" {
            { Get-EntraUserManager -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should contain UserId in parameters when passed ObjectId to it" {
            $result = Get-EntraUserManager -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
            $params = Get-Parameters -data $result.Parameters
            $params.Uri | Should -Match "412be9d1-1460-4061-8eed-cca203fcb215"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserManager"
            $result = Get-EntraUserManager -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }  

    }
}