# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.CertificateBasedAuthentication) -eq $null) {
        Import-Module Microsoft.Entra.CertificateBasedAuthentication      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    # Define test data
    $script:psVersion = $PSVersionTable.PSVersion.ToString()
    $script:entraVersion = (Get-Module Microsoft.Entra.CertificateBasedAuthentication).Version.ToString()
    $script:testUserUpn = "test.user@contoso.com"
    $script:testUserId = "11111111-1111-1111-1111-111111111111"
    $script:nonExistentUserUpn = "nonexistent@contoso.com"
    $script:nonExistentUserId = "99999999-9999-9999-9999-999999999999"
    
    # Mock headers
    $script:expectedUserAgent = "PowerShell/$script:psVersion EntraPowershell/$script:entraVersion Get-EntraUserCBAAuthorizationInfo"
    
    # Mock Get-EntraContext to provide required permissions
    Mock -CommandName Get-EntraContext -MockWith { 
        @{
            Scopes = @("User.Read.All", "Directory.Read.All") 
        } 
    } -ModuleName Microsoft.Entra.CertificateBasedAuthentication
    
    # Mock New-EntraCustomHeaders
    Mock -CommandName New-EntraCustomHeaders -MockWith {
        param($Command)
        return @{
            "User-Agent" = $script:expectedUserAgent
        }
    } -ModuleName Microsoft.Entra.CertificateBasedAuthentication
    
    # Mock Invoke-MgGraphRequest for UPN lookup
    Mock -CommandName Invoke-MgGraphRequest -MockWith {
        param($Uri, $Method, $Headers)
        
        if ($Method -eq "GET" -and $Uri -match "userPrincipalName\seq\s'$script:testUserUpn'") {
            return @{
                value = @(
                    @{
                        id                = $script:testUserId
                        userPrincipalName = $script:testUserUpn
                        displayName       = "Test User"
                    }
                )
            }
        }
        elseif ($Method -eq "GET" -and $Uri -match "userPrincipalName\seq\s'$script:nonExistentUserUpn'") {
            return @{
                value = @()
            }
        }
        else {
            throw "Unexpected URI or method: $Method $Uri"
        }
    } -ParameterFilter { $Uri -match "filter=userPrincipalName" } -ModuleName Microsoft.Entra.CertificateBasedAuthentication
    
    # Mock Invoke-MgGraphRequest for ID lookup
    Mock -CommandName Invoke-MgGraphRequest -MockWith {
        param($Uri, $Method, $Headers)
        
        if ($Method -eq "GET" -and $Uri -match "id\seq\s'$script:testUserId'") {
            return @{
                value = @(
                    @{
                        id                = $script:testUserId
                        userPrincipalName = $script:testUserUpn
                        displayName       = "Test User"
                    }
                )
            }
        }
        elseif ($Method -eq "GET" -and $Uri -match "id\seq\s'$script:nonExistentUserId'") {
            return @{
                value = @()
            }
        }
        else {
            throw "Unexpected URI or method: $Method $Uri"
        }
    } -ParameterFilter { $Uri -match "filter=id" } -ModuleName Microsoft.Entra.CertificateBasedAuthentication
    
    # Mock Invoke-MgGraphRequest for authorization info
    Mock -CommandName Invoke-MgGraphRequest -MockWith {
        param($Uri, $Method, $Headers)
        
        if ($Method -eq "GET" -and $Uri -match "/users/$script:testUserId") {
            return @{
                id                = $script:testUserId
                displayName       = "Test User"
                userPrincipalName = $script:testUserUpn
                userType          = "Member"
                authorizationInfo = @{
                    certificateUserIds = @(
                        "X509:<PN>test.user@contoso.com",
                        "X509:<S>CN=Test User"
                    )
                }
            }
        }
        else {
            throw "Unexpected URI or method: $Method $Uri"
        }
    } -ParameterFilter { $Uri -match "select=id,displayName,userPrincipalName,userType,authorizationInfo" } -ModuleName Microsoft.Entra.CertificateBasedAuthentication
}

Describe "Get-EntraUserCBAAuthorizationInfo" {

    Context "Parameter validation" {
        It "Should have mandatory UserId parameter" {
            (Get-Command Get-EntraUserCBAAuthorizationInfo).Parameters['UserId'].Attributes | 
            Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] } |
            Select-Object -First 1 | 
            ForEach-Object { $_.Mandatory } | Should -BeTrue
        }

        It "Should fail when UserId is missing" {
            { Get-EntraUserCBAAuthorizationInfo -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should have optional Raw parameter" {
            (Get-Command Get-EntraUserCBAAuthorizationInfo).Parameters['Raw'].Attributes | 
            Where-Object { $_ -is [System.Management.Automation.ParameterAttribute] } |
            Select-Object -First 1 | 
            ForEach-Object { $_.Mandatory } | Should -BeFalse
        }
    }

    Context "User lookup" {
        It "Should look up user by UPN" {
            { Get-EntraUserCBAAuthorizationInfo -UserId $script:testUserUpn } | Should -Not -Throw
            
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.CertificateBasedAuthentication -ParameterFilter {
                $Uri -match "filter=userPrincipalName\seq\s'$script:testUserUpn'" -and $Method -eq "GET"
            } -Times 1 -Exactly
        }
        
        It "Should look up user by ID" {
            { Get-EntraUserCBAAuthorizationInfo -UserId $script:testUserId } | Should -Not -Throw
            
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.CertificateBasedAuthentication -ParameterFilter {
                $Uri -match "filter=id\seq\s'$script:testUserId'" -and $Method -eq "GET"
            } -Times 1 -Exactly
        }
    }
    
    Context "Authorization info retrieval" {
        It "Should retrieve authorization info" {
            { Get-EntraUserCBAAuthorizationInfo -UserId $script:testUserUpn } | Should -Not -Throw
            
            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Entra.CertificateBasedAuthentication -ParameterFilter {
                $Uri -match "/users/$script:testUserId\?.*select=.*authorizationInfo" -and $Method -eq "GET"
            } -Times 1 -Exactly
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserCBAAuthorizationInfo"
            $result = Get-EntraUserCBAAuthorizationInfo -UserId $script:testUserUpn
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.CertificateBasedAuthentication -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        
    }
    
    Context "Response processing" {
        It "Should return raw response when -Raw is specified" {
            $result = Get-EntraUserCBAAuthorizationInfo -UserId $script:testUserUpn -Raw
            
            $result | Should -Not -BeNull
            $result.authorizationInfo | Should -Not -BeNull
            $result.authorizationInfo.certificateUserIds | Should -HaveCount 2
            $result.authorizationInfo.certificateUserIds[0] | Should -Be "X509:<PN>test.user@contoso.com"
            $result.authorizationInfo.certificateUserIds[1] | Should -Be "X509:<S>CN=Test User"
        }
        
        It "Should return structured output by default" {
            $result = Get-EntraUserCBAAuthorizationInfo -UserId $script:testUserUpn
            
            $result | Should -Not -BeNull
            $result.Id | Should -Be $script:testUserId
            $result.UserPrincipalName | Should -Be $script:testUserUpn
            $result.DisplayName | Should -Be "Test User"
            $result.UserType | Should -Be "Member"
            $result.AuthorizationInfo | Should -Not -BeNull
            $result.AuthorizationInfo.CertificateUserIds | Should -HaveCount 2
        }
        
        It "Should parse certificate IDs correctly" {
            $result = Get-EntraUserCBAAuthorizationInfo -UserId $script:testUserUpn
            
            $principalNameCert = $result.AuthorizationInfo.CertificateUserIds | Where-Object { $_.Type -eq "PN" } | Select-Object -First 1
            $principalNameCert | Should -Not -BeNull
            $principalNameCert.TypeName | Should -Be "PrincipalName"
            $principalNameCert.Value | Should -Be "test.user@contoso.com"
            $principalNameCert.OriginalString | Should -Be "X509:<PN>test.user@contoso.com"
            
            $subjectCert = $result.AuthorizationInfo.CertificateUserIds | Where-Object { $_.Type -eq "S" } | Select-Object -First 1
            $subjectCert | Should -Not -BeNull
            $subjectCert.TypeName | Should -Be "Subject"
            $subjectCert.Value | Should -Be "CN=Test User"
            $subjectCert.OriginalString | Should -Be "X509:<S>CN=Test User"
        }
    }

}
