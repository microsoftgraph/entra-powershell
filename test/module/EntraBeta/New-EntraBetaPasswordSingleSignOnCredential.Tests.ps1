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
                        "Value"   = "test1"
                        "Type"    = "text"
                        "FieldId" = "param_emailOrUserName"
                    },
                    [PSCustomObject]@{  
                        "Value"   = "test1"
                        "Type"    = "password"
                        "FieldId" = "param_password"
                    }
                )
                "Id"                   = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                "AdditionalProperties" = @{"@odata.context"='https://graph.microsoft.com/beta/$metadata#microsoft.graph.passwordSingleSignOnCredentialSet'}
                "Parameters"           = $args
            }
        )
    }
    Mock -CommandName New-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaPasswordSingleSignOnCredential" {
    Context "Test for New-EntraBetaPasswordSingleSignOnCredential" {
        It "Should creates the password sso credentials for the given ObjectId and PasswordSSOObjectId." {
            $params = @{
                id = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test1"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test1"
                    }
                )
            }
            $result = New-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOCredential $params
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"

            Should -Invoke -CommandName New-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { $params = @{
                id = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test1"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test1"
                    }
                )
            }
            New-EntraBetaPasswordSingleSignOnCredential -ObjectId -PasswordSSOCredential $params} | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is Invalid" {
            { $params = @{
                id = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test1"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test1"
                    }
                )
            }
            New-EntraBetaPasswordSingleSignOnCredential -ObjectId "" -PasswordSSOCredential $params} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when PasswordSSOCredential parameter are empty" {
            { New-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOCredential  } | Should -Throw "Missing an argument for parameter 'PasswordSSOCredential'*"
        }

        It "Should fail when PasswordSSOCredential parameter are Invalid" {
            { New-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOCredential "" } | Should -Throw "Cannot process argument transformation on parameter 'PasswordSSOCredential'*"
        }

        It "Should contain ObjectId in result" {
            $params = @{
                id = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test1"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test1"
                    }
                )
            }
            $result = New-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOCredential $params
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
        } 

        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            $params = @{
                id = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test1"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test1"
                    }
                )
            }
            $result = New-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOCredential $params
            $params = Get-Parameters -data $result.Parameters
            $params.ServicePrincipalId | Should -Be "bbbbbbbb-1111-2222-3333-cccccccccc56"

            Should -Invoke -CommandName New-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain BodyParameter in parameters when passed PasswordSSOCredential to it" {
            $params = @{
                id = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test1"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test1"
                    }
                )
            }
            $result = New-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOCredential $params
            $value = $params.credentials | ConvertTo-Json 
            $result | Should -Not -BeNullOrEmpty
            $value | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName New-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaPasswordSingleSignOnCredential"

            $params = @{
                id = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test1"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test1"
                    }
                )
            }
            $result = New-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOCredential $params
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaPasswordSingleSignOnCredential"

            Should -Invoke -CommandName New-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }  

        It "Should execute successfully without throwing an error " {
            $params = @{
                id = "bbbbbbbb-1111-2222-3333-cccccccccc55"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test1"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test1"
                    }
                )
            }

            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { New-EntraBetaPasswordSingleSignOnCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccc56" -PasswordSSOCredential $params -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}