BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                DisplayName                = "demo004"
                Id                         = "sdjfksd-2343-n21kj"
                UserPrincipalName          = "demo004@M365x99297270.OnMicrosoft.com"
                AccountEnabled             = "True"
                MailNickname               = "demoUser"
                AgeGroup                   = "adult"
                City                       = "New York" 
                UserStateChangedOn         = "2024-05-02" 
                CompanyName                = "ABC Inc" 
                PreferredLanguage          = "English" 
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
                UserState                  = "Active" 
                UserType                   = "Member" 
                OtherMails                 = @("alternate@email.com") 
                State                      = "NY" 
                StreetAddress              = "123 Main St" 
                TelephoneNumber            = "987654321" 
                Surname                    = "Doe" 
                ShowInAddressList          = $True
                Parameters                 = $args
            }
        )
    }

    Mock -CommandName New-MgBetaUser -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaUser"{
    Context "Test for New-EntraBetaUser" {
        It "Should return created User"{
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "test@1234"

           $result = New-EntraBetaUser `
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
                -TelephoneNumber "987654321" `
                -Surname "Doe" `
                -ShowInAddressList $True
                

            $result | Should -Not -BeNullOrEmpty

            $result.DisplayName | should -Be "demo004"
            $result.Id | should -Be "sdjfksd-2343-n21kj" 
            
            Should -Invoke -CommandName New-MgBetaUser -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should contain ExternalUserState, MobilePhone, OnPremisesImmutableId, ExternalUserStateChangeDateTime, BusinessPhones" {
            # Define Password Profile
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "test@1234"

            # format like "yyyy-MM-dd HH:mm:ss"
            $userStateChangedOn = [System.DateTime]::Parse("2015-12-08 15:15:19")


            $result = New-EntraBetaUser -DisplayName "demo002" -PasswordProfile $PasswordProfile `
                -UserPrincipalName "demo001@M365x99297270.OnMicrosoft.com" -AccountEnabled $true `
                -MailNickName "demo002NickName" -AgeGroup "adult" `
                -UserState "PendingAcceptance" `
                -UserStateChangedOn $userStateChangedOn `
                -Mobile "123111221" `
                -ImmutableId "djkjsajsa-e32j2-2i32" `
                -TelephoneNumber "1234567890"

            $params = Get-Parameters -data $result.Parameters

            $params.BusinessPhones[0] | Should -Be "1234567890"

            $params.MobilePhone | Should -Be "123111221"

            $params.ExternalUserState | Should -Be "PendingAcceptance"

            $params.OnPremisesImmutableId | Should -Be "djkjsajsa-e32j2-2i32"

            $params.ExternalUserStateChangeDateTime | Should -Be $userStateChangedOn
        }  

        It "Should fail when DisplayName is empty" {
            { New-EntraBetaUser -DisplayName "" } | Should -Throw "Cannot bind argument to parameter*"
        }

        It "Should fail when invalid parameter is passed" {
            { New-EntraBetaUser -Power "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'Power'*"
        }

        It "Should contain 'User-Agent' header" {
            $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
            $PasswordProfile.Password = "test@1234"

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaUser"
            $result = New-EntraBetaUser -DisplayName "demo004" -PasswordProfile $PasswordProfile  -AccountEnabled $true 
            $params = Get-Parameters -data $result.Parameters
            $params.Headers."User-Agent" | Should -Be $userAgentHeaderValue
        }
    }
}