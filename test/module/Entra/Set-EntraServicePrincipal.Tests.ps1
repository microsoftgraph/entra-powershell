BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    Mock -CommandName Update-MgServicePrincipal -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Set-EntraServicePrincipal"{
    Context "Test for " {
        It "Should update the parameter" {
            $tags = @("Environment=Production", "Department=Finance", "Project=MNO")
            $result= Set-EntraServicePrincipal -ObjectId "6aa187e3-bbbb-4748-a708-fc380aa9eb17" -AccountEnabled $false -AppId "c5d1b05d-2257-465d-bbe4-a2ad50f09b81" -AppRoleAssignmentRequired $true -DisplayName "test11" -ServicePrincipalNames "c5d1b05d-2257-465d-bbe4-a2ad50f09b81" -Tags $tags
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }   
        It "Should update the LogoutUrl and ServicePrincipalType parameter" {
                $result= Set-EntraServicePrincipal -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -LogoutUrl 'https://securescore.office.com/SignOut' -ServicePrincipalType "Application"
                $result | Should -BeNullOrEmpty
    
                Should -Invoke -CommandName Update-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }   
        It "Should update the Homepage, ReplyUrls and AlternativeNames parameter" {
            $result= Set-EntraServicePrincipal -ObjectId "2dccbb5e-5e71-4ff1-905f-44862bb50909" -Homepage 'https://HomePageurlss.com' -ReplyUrls 'https://admin.microsoft1.com' -AlternativeNames "updatetest"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
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
            $result= Set-EntraServicePrincipal -ObjectId 6aa187e3-bbbb-4748-a708-fc380aa9eb17  -KeyCredentials $creds
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Update-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }     
        It "Should fail when ObjectId is empty" {
            { Set-EntraServicePrincipal -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'.*"
        }
        It "Should fail when ObjectId is Invalid" {
            { Set-EntraServicePrincipal -ObjectId ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        }
        It "Should fail when non-mandatory is empty" {
            { Set-EntraServicePrincipal -ObjectId "6aa187e3-bbbb-4748-a708-fc380aa9eb17" -AppId  -Tags  -ReplyUrls -AccountEnabled -AlternativeNames -KeyCredentials -Homepage} | Should -Throw "Missing an argument for parameter*"
        }
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName Update-MgServicePrincipal -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Set-EntraServicePrincipal -ObjectId "6aa187e3-bbbb-4748-a708-fc380aa9eb17"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "6aa187e3-bbbb-4748-a708-fc380aa9eb17"
        }   
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Update-MgServicePrincipal -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraServicePrincipal"

            $tags = @("Environment=Production", "Department=Finance", "Project=MNO")
            $result= Set-EntraServicePrincipal -ObjectId "6aa187e3-bbbb-4748-a708-fc380aa9eb17" -AccountEnabled $false -AppId "c5d1b05d-2257-465d-bbe4-a2ad50f09b81" -AppRoleAssignmentRequired $true -DisplayName "test11" -ServicePrincipalNames "c5d1b05d-2257-465d-bbe4-a2ad50f09b81" -Tags $tags
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
   }          
}