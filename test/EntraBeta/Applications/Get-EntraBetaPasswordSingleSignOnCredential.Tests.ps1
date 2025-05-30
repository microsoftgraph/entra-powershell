# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Applications    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Credentials"          = @(
                    [PSCustomObject]@{ 
                        "Value"   = "test420"
                        "Type"    = "text"
                        "FieldId" = "param_emailOrUserName"
                    },
                    [PSCustomObject]@{  
                        "Value"   = "test420"
                        "Type"    = "password"
                        "FieldId" = "param_password"
                    }
                )
                "Id"                   = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                "AdditionalProperties" = @{"@odata.context" = "https://graph.microsoft.com/beta/`$metadata#microsoft.graph.passwordSingleSignOnCredentialSet" }
                "Parameters"           = $args
            }
        )
    }
    Mock -CommandName Get-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.Applications
}

Describe "Get-EntraBetaPasswordSingleSignOnCredential" {
    Context "Test for Get-EntraBetaPasswordSingleSignOnCredential" {
        It "Should gets the password sso credentials for the given ServicePrincipalId and PasswordSSOObjectId." {
            $result = Get-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"

            Should -Invoke -CommandName Get-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should fail when ServicePrincipalId is Invalid" {
            { Get-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55" } | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }

        It "Should fail when PasswordSSOObjectId parameter are empty" {
            { Get-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId } | Should -Throw "Missing an argument for parameter 'PasswordSSOObjectId'*"
        }

        It "Should contain ObjectId in result" {
            $result = Get-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
        } 

        It "Should contain ServicePrincipalId in parameters when passed ServicePrincipalId to it" {
            $result = Get-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $params = Get-Parameters -data $result.Parameters
            $params.ServicePrincipalId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc56"

            Should -Invoke -CommandName Get-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should contain BodyParameter in parameters when passed PasswordSSOObjectId to it" {
            $result = Get-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55" 
            $result | Should -Not -BeNullOrEmpty
            $result.Credentials[0].Value | should -Be 'test420'

            Should -Invoke -CommandName Get-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Entra.Beta.Applications -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPasswordSingleSignOnCredential"
            $result = Get-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPasswordSingleSignOnCredential"
            Should -Invoke -CommandName Get-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Entra.Beta.Applications -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }     

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaPasswordSingleSignOnCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

