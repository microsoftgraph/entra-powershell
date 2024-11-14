# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

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
                "AdditionalProperties" = @{"@odata.context"="https://graph.microsoft.com/beta/`$metadata#microsoft.graph.passwordSingleSignOnCredentialSet"}
                "Parameters"           = $args
            }
        )
    }
    Mock -CommandName Get-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaPasswordSingleSignOnCredential" {
    Context "Test for Get-EntraBetaPasswordSingleSignOnCredential" {
        It "Should gets the password sso credentials for the given ObjectId and PasswordSSOObjectId." {
            $result = Get-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"

            Should -Invoke -CommandName Get-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is Invalid" {
            { Get-EntraBetaPasswordSingleSignOnCredential -ObjectId "" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55"} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when PasswordSSOObjectId parameter are empty" {
            { Get-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId  } | Should -Throw "Missing an argument for parameter 'PasswordSSOObjectId'*"
        }

        It "Should contain ObjectId in result" {
            $result = Get-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
        } 

        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            $result = Get-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $params = Get-Parameters -data $result.Parameters
            $params.ServicePrincipalId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc56"

            Should -Invoke -CommandName Get-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain BodyParameter in parameters when passed PasswordSSOObjectId to it" {
            $result = Get-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55" 
            $result | Should -Not -BeNullOrEmpty
            $result.Credentials[0].Value | should -Be 'test420'

            Should -Invoke -CommandName Get-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPasswordSingleSignOnCredential"
            $result= Get-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPasswordSingleSignOnCredential"
            Should -Invoke -CommandName Get-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { Get-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOObjectId "bbbbbbbb-1111-2222-3333-cccccccccc55" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}