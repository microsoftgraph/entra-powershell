BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        #Write-Host "Mocking New-EntraUser with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              DisplayName     = "demo004"
              Id = "sdjfksd-2343-n21kj"
              UserPrincipalName = "demo004@M365x99297270.OnMicrosoft.com"
              AccountEnabled = "True"
              MailNickname = "demoUser"
              AgeGroup  = "adult"
              Parameters = $args
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraUser" {
    Context "Test for New-EntraUser" {
        It "Should return created User" {
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "test@1234"
            $result = New-EntraUser -DisplayName "demo004" -PasswordProfile $PasswordProfile  -UserPrincipalName "demo004@M365x99297270.OnMicrosoft.com" -AccountEnabled $true -MailNickName "demoUser" -AgeGroup "adult"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be "demo004"
            $result.AccountEnabled | should -Be "True"
            $result.UserPrincipalName | should -Be "demo004@M365x99297270.OnMicrosoft.com"
            $result.MailNickName | should -Be "demoUser" 
            $result.AgeGroup | should -Be "adult" 

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when parameters are empty" {
            { New-EntraUser -DisplayName "" -AgeGroup "" -AccountEnabled -MailNickName "" -UserPrincipalName ""  } | Should -Throw "Missing an argument for parameter*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraUser"
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "test@1234"
            $result = New-EntraUser -DisplayName "demo002" -PasswordProfile $PasswordProfile -UserPrincipalName "demo001@M365x99297270.OnMicrosoft.com" -AccountEnabled $true -MailNickName "demo002NickName" -AgeGroup "adult"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }   
    }
}