# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaPasswordSingleSignOnCredential" {
    Context "Test for Set-EntraBetaPasswordSingleSignOnCredential" {
        It "Should sets the password sso credentials for the given ObjectId and PasswordSSOObjectId." {
            $params = @{
                id = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test420"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test2420"
                    }
                )
            }
            $result = Set-EntraBetaPasswordSingleSignOnCredential -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PasswordSSOCredential $params
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { $params = @{
                id = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test420"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test2420"
                    }
                )
            }
            Set-EntraBetaPasswordSingleSignOnCredential -ObjectId -PasswordSSOCredential $params} | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is Invalid" {
            { $params = @{
                id = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test420"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test2420"
                    }
                )
            }
            Set-EntraBetaPasswordSingleSignOnCredential -ObjectId "" -PasswordSSOCredential $params} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when PasswordSSOCredential parameter are empty" {
            { Set-EntraBetaPasswordSingleSignOnCredential -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PasswordSSOCredential  } | Should -Throw "Missing an argument for parameter 'PasswordSSOCredential'*"
        }

        It "Should fail when PasswordSSOCredential parameter are Invalid" {
            { Set-EntraBetaPasswordSingleSignOnCredential -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PasswordSSOCredential "" } | Should -Throw "Cannot process argument transformation on parameter 'PasswordSSOCredential'*"
        }

        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $params = @{
                id = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test420"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test2420"
                    }
                )
            }
            $result = Set-EntraBetaPasswordSingleSignOnCredential -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PasswordSSOCredential $params
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }

        It "Should contain BodyParameter in parameters when passed PasswordSSOCredential to it" {
            Mock -CommandName Update-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
        
            $params = @{
                id = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test420"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test2420"
                    }
                )
            }
            $result = Set-EntraBetaPasswordSingleSignOnCredential -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PasswordSSOCredential $params
            $value = $params.credentials | ConvertTo-Json 
            $resultParams = Get-Parameters -data $result
            $expectedObject = $value | ConvertFrom-Json
            $actualObject = ($resultParams.BodyParameter.Credentials | ConvertTo-Json -Depth 10 | ConvertFrom-Json)
            $expectedObject | ForEach-Object {
                $property = $_
                $actualProperty = $actualObject | Where-Object { $_.fieldId -eq $property.fieldId }
                $actualProperty | Should -Not -BeNullOrEmpty
                $actualProperty | Should -BeLike "*$($property.value)*"
                $actualProperty | Should -BeLike "*$($property.type)*"
                $actualProperty | Should -BeLike "*$($property.fieldId)*"
            }
        }
        
        It "Should contain 'User-Agent' header" {

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaPasswordSingleSignOnCredential"
            $params = @{
                id = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test420"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test2420"
                    }
                )
            }
            $result = Set-EntraBetaPasswordSingleSignOnCredential -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PasswordSSOCredential $params
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaPasswordSingleSignOnCredential"
            Should -Invoke -CommandName Update-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }  
        
        It "Should execute successfully without throwing an error " {
            $params = @{
                id = "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
                credentials = @(
                    @{
                        fieldId = "param_emailOrUserName"
                        type = "text"
                        value = "test420"
                    }
                    @{
                        fieldId = "param_password"
                        type = "password"
                        value = "test2420"
                    }
                )
            }
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraBetaPasswordSingleSignOnCredential -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -PasswordSSOCredential $params -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }    
}
