# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        
        #Write-Host "Mocking New-EntraUser with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                DisplayName                     = "demo004"
                Id                              = "sdjfksd-2343-n21kj"
                UserPrincipalName               = "SawyerM@contoso.com"
                AccountEnabled                  = "True"
                MailNickname                    = "demoUser"
                AgeGroup                        = "adult"
                Parameters                      = $args
                City                            = "New York" 
                ExternalUserStateChangeDateTime = "2024-05-02" 
                CompanyName                     = "ABC Inc" 
                PreferredLanguage               = "English" 
                FaxNumber                       = "123456789" 
                GivenName                       = "John" 
                mobilePhone                     = "987654321" 
                UsageLocation                   = "US" 
                PostalCode                      = "10001" 
                CreationType                    = "Manual" 
                ConsentProvidedForMinor         = "Yes" 
                onPremisesImmutableId           = "1234567890" 
                Country                         = "USA" 
                Department                      = "IT" 
                PasswordPolicies                = "Default" 
                JobTitle                        = "Engineer"
                ExternalUserState               = "Active" 
                UserType                        = "Member" 
                OtherMails                      = @("alternate@email.com")
                State                           = "NY" 
                StreetAddress                   = "123 Main St" 
                BusinessPhones                  = "987654321" 
                Surname                         = "Doe"
                Identities                      = @(
                    @{
                        Type  = "emailAddress"
                        Value = "example1@example.com"
                    }
                )
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users
}
  
Describe "New-EntraUser" {
    Context "Test for New-EntraUser" {

        It "Should return created User" {
            # Define Password Profile
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "test@1234"

            $result = New-EntraUser `
                -DisplayName "demo004" `
                -PasswordProfile $PasswordProfile `
                -UserPrincipalName "SawyerM@contoso.com" `
                -AccountEnabled $true `
                -MailNickName "demoUser" `
                -AgeGroup "adult" `
                -City "New York" `
                -ExternalUserStateChangeDateTime "2024-05-02" `
                -CompanyName "ABC Inc" `
                -PreferredLanguage "English" `
                -FaxNumber "123456789" `
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
                -UserState "Active" `
                -UserType "Member" `
                -OtherMails @("alternate@email.com") `
                -State "NY" `
                -StreetAddress "123 Main St" `
                -BusinessPhones "987654321" `
                -Surname "Doe"

            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be "demo004"
            $result.AccountEnabled | Should -Be $true
            $result.UserPrincipalName | Should -Be "SawyerM@contoso.com"
            $result.MailNickName | Should -Be "demoUser" 
            $result.AgeGroup | Should -Be "adult" 
            $result.City | Should -Be "New York"
            $result.ExternalUserStateChangeDateTime | Should -Be "2024-05-02"
            $result.CompanyName | Should -Be "ABC Inc"
            $result.PreferredLanguage | Should -Be "English"
            $result.FaxNumber | Should -Be "123456789"
            $result.GivenName | Should -Be "John"
            $result.Mobile | Should -Be "987654321"
            $result.UsageLocation | Should -Be "US"
            $result.PostalCode | Should -Be "10001"
            $result.CreationType | Should -Be "Manual"
            $result.ConsentProvidedForMinor | Should -Be "Yes"
            $result.ImmutableId | Should -Be "1234567890"
            $result.Country | Should -Be "USA"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when parameters are empty" {
            { New-EntraUser -DisplayName "" -AgeGroup "" -AccountEnabled -MailNickName "" -UserPrincipalName "" } | Should -Throw "Missing an argument for parameter*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraUser"
            # Define Password Profile
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "test@1234"

            $result = New-EntraUser -DisplayName "demo002" -PasswordProfile $PasswordProfile -UserPrincipalName "demo001@M365x99297270.OnMicrosoft.com" -AccountEnabled $true -MailNickName "demo002NickName" -AgeGroup "adult"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraUser"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }  
        }
        It "Should contain MobilePhone in parameters when passed Mobile to it" {
            # Define Password Profile
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "test@1234"
             
            $result = New-EntraUser -DisplayName "demo002" -PasswordProfile $PasswordProfile -UserPrincipalName "demo001@M365x99297270.OnMicrosoft.com" -AccountEnabled $true -MailNickName "demo002NickName" -AgeGroup "adult" -Mobile "1234567890"
            $params = Get-Parameters -data $result.Parameters
            ($params.Body | ConvertFrom-Json ).MobilePhone | Should -Be "1234567890"
        }   
        
        It "Should contain ExternalUserState, OnPremisesImmutableId, ExternalUserStateChangeDateTime, BusinessPhones" {
            # Define Password Profile
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "test@1234"

            # format like "yyyy-MM-dd HH:mm:ss"
            $userStateChangedOn = [System.DateTime]::Parse("2015-12-08 15:15:19")


            $result = New-EntraUser -DisplayName "demo002" -PasswordProfile $PasswordProfile `
                -UserPrincipalName "demo001@M365x99297270.OnMicrosoft.com" -AccountEnabled $true `
                -MailNickName "demo002NickName" -AgeGroup "adult" `
                -ExternalUserState "Active" `
                -ExternalUserStateChangeDateTime $userStateChangedOn `
                -ImmutableId "djkjsajsa-e32j2-2i32" `
                -BusinessPhones "1234567890"
            
            $params = Get-Parameters -data $result.Parameters
            
            $requestBody = $params.Body | ConvertFrom-Json

            $requestBody.BusinessPhones[0] | Should -Be "1234567890"

            $requestBody.ExternalUserState | Should -Be "Active"

            $requestBody.OnPremisesImmutableId | Should -Be "djkjsajsa-e32j2-2i32"

            $requestBody.ExternalUserStateChangeDateTime | Should -Be $userStateChangedOn
        }  
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            # Define Password Profile
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "test@1234"
 
            # format like "yyyy-MM-dd HH:mm:ss"
            $userStateChangedOn = [System.DateTime]::Parse("2015-12-08 15:15:19")
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { New-EntraUser -DisplayName "demo002" -PasswordProfile $PasswordProfile `
                        -UserPrincipalName "demo001@M365x99297270.OnMicrosoft.com" -AccountEnabled $true `
                        -MailNickName "demo002NickName" -AgeGroup "adult" `
                        -UserState "PendingAcceptance" `
                        -UserStateChangedOn $userStateChangedOn `
                        -ImmutableId "djkjsajsa-e32j2-2i32" `
                        -BusinessPhones "1234567890" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }  
    }
}

