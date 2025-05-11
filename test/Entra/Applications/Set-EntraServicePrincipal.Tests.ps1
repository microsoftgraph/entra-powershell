# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Applications) -eq $null){
        Import-Module Microsoft.Entra.Applications    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Applications
}

Describe "Set-EntraServicePrincipal"{
    Context "Test for Set-EntraServicePrincipal" {
        It "Should update the parameter" {
            $tags = @("Environment=Production", "Department=Finance", "Project=MNO")
            $result= Set-EntraServicePrincipal -ServicePrincipalId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -AccountEnabled $false -AppId "00001111-aaaa-2222-bbbb-3333cccc4444" -AppRoleAssignmentRequired $true -DisplayName "test11" -ServicePrincipalNames "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Tags $tags
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
        }   
        It "Should update the parameter with Alias" {
            $result= Set-EntraServicePrincipal -ObjectId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -AccountEnabled $false -AppId "00001111-aaaa-2222-bbbb-3333cccc4444" -AppRoleAssignmentRequired $true -DisplayName "test11" -ServicePrincipalNames "11bb11bb-cc22-dd33-ee44-55ff55ff55ff"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should update the LogoutUrl and ServicePrincipalType parameter" {
                $result= Set-EntraServicePrincipal -ServicePrincipalId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -LogoutUrl 'https://securescore.office.com/SignOut' -ServicePrincipalType "Application"
                $result | Should -BeNullOrEmpty
    
                Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
        }   
        It "Should update the Homepage, ReplyUrls and AlternativeNames parameter" {
            $result= Set-EntraServicePrincipal -ServicePrincipalId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Homepage 'https://HomePageurlss.com' -ReplyUrls 'https://admin.microsoft1.com' -AlternativeNames "updatetest"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
        } 
        It "Should update the KeyCredentials parameter" {
            $creds = New-Object Microsoft.Open.AzureAD.Model.KeyCredential
            $creds.CustomKeyIdentifier = [System.Text.Encoding]::UTF8.GetBytes("Test")
            $startdate = Get-Date -Year 2024 -Month 10 -Day 10
            $creds.StartDate = $startdate
            $creds.Type = "Symmetric"
            $creds.Usage = 'Sign'
            $creds.Value = [System.Text.Encoding]::UTF8.GetBytes("A")
            $creds.EndDate = Get-Date -Year 2025 -Month 12 -Day 20
            $result= Set-EntraServicePrincipal -ServicePrincipalId 6aa187e3-bbbb-4748-a708-fc380aa9eb17  -KeyCredentials $creds
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1
        }     
        It "Should fail when ServicePrincipalId is empty" {
            { Set-EntraServicePrincipal -ServicePrincipalId } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'.*"
        }
        It "Should fail when ServicePrincipalId is Invalid" {
            { Set-EntraServicePrincipal -ServicePrincipalId ""} | Should -Throw "Cannot bind argument to parameter 'ServicePrincipalId' because it is an empty string.*"
        }
        It "Should fail when non-mandatory is empty" {
            { Set-EntraServicePrincipal -ServicePrincipalId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -AppId  -Tags  -ReplyUrls -AccountEnabled -AlternativeNames -KeyCredentials -Homepage} | Should -Throw "Missing an argument for parameter*"
        }  
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraServicePrincipal"

            Set-EntraServicePrincipal -ServicePrincipalId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -LogoutUrl 'https://securescore.office.com/SignOut' -ServicePrincipalType "Application"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraServicePrincipal"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $tags = @("Environment=Production", "Department=Finance", "Project=MNO")
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraServicePrincipal -ServicePrincipalId "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -AccountEnabled $false -AppId "00001111-aaaa-2222-bbbb-3333cccc4444" -AppRoleAssignmentRequired $true -DisplayName "test11" -ServicePrincipalNames "11bb11bb-cc22-dd33-ee44-55ff55ff55ff" -Tags $tags -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
   }          
}

