BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Update-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {} -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Set-EntraBetaMSPasswordSingleSignOnCredential" {
    Context "Test for Set-EntraBetaMSPasswordSingleSignOnCredential" {
        It "Should sets the password sso credentials for the given ObjectId and PasswordSSOObjectId." {
            $params = @{
                id = "ff6f6a54-189e-4534-8269-e2dec3bc5249"
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
            $result = Set-EntraBetaMSPasswordSingleSignOnCredential -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -PasswordSSOCredential $params
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgBetaServicePrincipalPasswordSingleSignOnCredential -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { $params = @{
                id = "ff6f6a54-189e-4534-8269-e2dec3bc5249"
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
            Set-EntraBetaMSPasswordSingleSignOnCredential -ObjectId -PasswordSSOCredential $params} | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectId is Invalid" {
            { $params = @{
                id = "ff6f6a54-189e-4534-8269-e2dec3bc5249"
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
            Set-EntraBetaMSPasswordSingleSignOnCredential -ObjectId "" -PasswordSSOCredential $params} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when PasswordSSOCredential parameter are empty" {
            { Set-EntraBetaMSPasswordSingleSignOnCredential -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -PasswordSSOCredential  } | Should -Throw "Missing an argument for parameter 'PasswordSSOCredential'*"
        }

        It "Should fail when PasswordSSOCredential parameter are Invalid" {
            { Set-EntraBetaMSPasswordSingleSignOnCredential -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -PasswordSSOCredential "" } | Should -Throw "Cannot process argument transformation on parameter 'PasswordSSOCredential'*"
        }

        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $params = @{
                id = "ff6f6a54-189e-4534-8269-e2dec3bc5249"
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
            $result = Set-EntraBetaMSPasswordSingleSignOnCredential -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -PasswordSSOCredential $params
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "cc7fcc82-ac1b-4785-af47-2ca3b7052886"
        }

        It "Should contain BodyParameter in parameters when passed PasswordSSOCredential to it" {
            Mock -CommandName Update-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta
        
            $params = @{
                id = "ff6f6a54-189e-4534-8269-e2dec3bc5249"
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
            $result = Set-EntraBetaMSPasswordSingleSignOnCredential -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -PasswordSSOCredential $params
            $value = $params.credentials | ConvertTo-Json 
            $expectedObject = $value | ConvertFrom-Json
            $actualObject = ($result.Credentials | ConvertTo-Json -Depth 10 | ConvertFrom-Json)
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
            Mock -CommandName Update-MgBetaServicePrincipalPasswordSingleSignOnCredential -MockWith {$args} -ModuleName Microsoft.Graph.Entra.Beta

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraBetaMSPasswordSingleSignOnCredential"
            $params = @{
                id = "ff6f6a54-189e-4534-8269-e2dec3bc5249"
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
            $result = Set-EntraBetaMSPasswordSingleSignOnCredential -ObjectId "cc7fcc82-ac1b-4785-af47-2ca3b7052886" -PasswordSSOCredential $params
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   
    }
}
