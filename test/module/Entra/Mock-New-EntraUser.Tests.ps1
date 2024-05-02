BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        
        #Write-Host "Mocking New-EntraUser with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                DisplayName                = "demo004"
                Id                         = "sdjfksd-2343-n21kj"
                UserPrincipalName          = "demo004@M365x99297270.OnMicrosoft.com"
                AccountEnabled             = "True"
                MailNickname               = "demoUser"
                AgeGroup                   = "adult"
                Parameters                 = $args
                City                       = "New York" 
                UserStateChangedOn         = "2024-05-02" 
                CompanyName                = "ABC Inc" 
                PreferredLanguage          = "English" 
                FacsimileTelephoneNumber   = "123456789" 
                GivenName                  = "John" 
                Mobile                     = "987654321" 
                UsageLocation              = "US" 
                PostalCode                 = "10001" 
                CreationType               = "Manual" 
                ConsentProvidedForMinor    = "Yes" 
                ImmutableId                = "1234567890" 
                Country                    = "USA" 
                Department                 = "IT" 
                PasswordPolicies           = "Default" 
                JobTitle                   = "Engineer" 
                IsCompromised              = $false 
                UserState                  = "Active" 
                UserType                   = "Member" 
                OtherMails                 = @("alternate@email.com") 
                PhysicalDeliveryOfficeName = "Office A" 
                State                      = "NY" 
                StreetAddress              = "123 Main St" 
                TelephoneNumber            = "987654321" 
                Surname                    = "Doe" 
                ShowInAddressList          = $true
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraUser" {
    Context "Test for New-EntraUser" {
        # Define Password Profile
        $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
        $PasswordProfile.Password = "test@1234"

        It "Should return created User" {
            $result = New-EntraUser `
                -DisplayName "demo004" `
                -PasswordProfile $PasswordProfile `
                -UserPrincipalName "demo004@M365x99297270.OnMicrosoft.com" `
                -AccountEnabled $true `
                -MailNickName "demoUser" `
                -AgeGroup "adult" `
                -City "New York" `
                -UserStateChangedOn "2024-05-02" `
                -CompanyName "ABC Inc" `
                -PreferredLanguage "English" `
                -FacsimileTelephoneNumber "123456789" `
                -GivenName "John" `
                -Mobile "987654321" `
                -UsageLocation "US" `
                -PostalCode "10001" `
                -CreationType "Manual" `
                -ConsentProvidedForMinor "Yes" `
                -ImmutableId "1234567890" `
                -Country "USA" `
                -Department "IT" `
                -PasswordPolicies "Default" `
                -JobTitle "Engineer" `
                -IsCompromised $false `
                -UserState "Active" `
                -UserType "Member" `
                -OtherMails @("alternate@email.com") `
                -PhysicalDeliveryOfficeName "Office A" `
                -State "NY" `
                -StreetAddress "123 Main St" `
                -TelephoneNumber "987654321" `
                -Surname "Doe" `
                -ShowInAddressList $true

            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "demo004"
            $result.AccountEnabled | Should -Be $true
            $result.UserPrincipalName | Should -Be "demo004@M365x99297270.OnMicrosoft.com"
            $result.MailNickName | Should -Be "demoUser" 
            $result.AgeGroup | Should -Be "adult" 
            $result.City | Should -Be "New York"
            $result.UserStateChangedOn | Should -Be "2024-05-02"
            $result.CompanyName | Should -Be "ABC Inc"
            $result.PreferredLanguage | Should -Be "English"
            $result.FacsimileTelephoneNumber | Should -Be "123456789"
            $result.GivenName | Should -Be "John"
            $result.Mobile | Should -Be "987654321"
            $result.UsageLocation | Should -Be "US"
            $result.PostalCode | Should -Be "10001"
            $result.CreationType | Should -Be "Manual"
            $result.ConsentProvidedForMinor | Should -Be "Yes"
            $result.ImmutableId | Should -Be "1234567890"
            $result.Country | Should -Be "USA"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when parameters are empty" {
            { New-EntraUser -DisplayName "" -AgeGroup "" -AccountEnabled -MailNickName "" -UserPrincipalName "" } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraUser"
            $result = New-EntraUser -DisplayName "demo002" -PasswordProfile $PasswordProfile -UserPrincipalName "demo001@M365x99297270.OnMicrosoft.com" -AccountEnabled $true -MailNickName "demo002NickName" -AgeGroup "adult" -PostalCode "10001"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
            ($params.Body | ConvertFrom-Json ).PostalCode | Should -Be "10001"
        }  
        
        It "Should contain 'Postal Code'" {
            $result = New-EntraUser -DisplayName "demo002" -PasswordProfile $PasswordProfile -UserPrincipalName "demo001@M365x99297270.OnMicrosoft.com" -AccountEnabled $true -MailNickName "demo002NickName" -AgeGroup "adult" -PostalCode "10001"
            $params = Get-Parameters -data $result.Parameters
            ($params.Body | ConvertFrom-Json ).PostalCode | Should -Be "10001"
        }   
    }
}