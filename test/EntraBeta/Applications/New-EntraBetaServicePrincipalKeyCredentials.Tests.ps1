# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $response = @{
        "@odata.context"      = 'https://graph.microsoft.com/v1.0/$metadata#microsoft.graph.keyCredential'
        "customKeyIdentifier" = $null
        "endDateTime"         = "01/15/2027 14:22:00"
        "key"                 = $null
        "keyId"               = "aaaaaaaa-0b0b-1c1c-2d2d-333333"
        "startDateTime"       = "01/15/2025 14:22:00"
        "type"                = "AsymmetricX509Cert"
        "usage"               = "Verify"
    }

    Mock -CommandName Invoke-MgGraphRequest -MockWith { $response } -ModuleName Microsoft.Entra.Beta.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "New-EntraBetaServicePrincipalKeyCredential" {
    Context "Test for New-EntraBetaServicePrincipalKeyCredential" {

         It "Should fail when ServicePrincipalId is null" {
            { New-EntraBetaServicePrincipalKeyCredential -ServicePrincipalId  -Value "U29mdHdhcmU=" -Type "AsymmetricX509Cert" -Usage "Verify" -Proof "c29tZVByb29m"  } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'*"
        }

        It "Should fail when ServicePrincipalId is empty" {
            { New-EntraBetaServicePrincipalKeyCredential -ServicePrincipalId ""} | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }

        It "Should return created service principal key credential when ServicePrincipalId is valid and all required parameters are provided" {
            $result = New-EntraBetaServicePrincipalKeyCredential -ServicePrincipalId "aaaaaaaa-2222-1111-1111-cccccccccccc" -Value "U29mdHdhcmU=" -Type "AsymmetricX509Cert" -Usage "Verify" -Proof "c29tZVByb29m"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should fail when key type is X509CertAndPassword and PasswordCredential hasn't been provided" {
            { New-EntraBetaServicePrincipalKeyCredential -ServicePrincipalId "aaaaaaaa-2222-1111-1111-cccccccccccc" -Value "U29mdHdhcmU=" -Type "X509CertAndPassword" -Usage "Sign" -Proof "test" } | Should -Throw "The 'CustomKeyIdentifier' property is required for keys of type X509CertAndPassword"
        }

        It "Should return created service principal key credential when PasswordCredential is provided for key type X509CertAndPassword" {
            $result = New-EntraBetaServicePrincipalKeyCredential -ServicePrincipalId "aaaaaaaa-2222-1111-1111-cccccccccccc" -Value "U29mdHdhcmU=" -Type "X509CertAndPassword" -Usage "Sign" -Proof "c29tZVByb29m" -PasswordCredential "MySecretPassword"
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaServicePrincipalKeyCredential"
            $result =  New-EntraBetaServicePrincipalKeyCredential -ServicePrincipalId "aaaaaaaa-2222-1111-1111-cccccccccccc"  -Value "U29mdHdhcmU=" -Type "AsymmetricX509Cert" -Usage "Verify" -Proof "c29tZVByb29m"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaServicePrincipalKeyCredential"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { New-EntraBetaServicePrincipalKeyCredential -ServicePrincipalId "aaaaaaaa-2222-1111-1111-cccccccccccc" -Value "U29mdHdhcmU=" -Type "AsymmetricX509Cert" -Usage "Verify" -Proof "c29tZVByb29m" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference
                $DebugPreference = $originalDebugPreference
            }
        }
    }

}