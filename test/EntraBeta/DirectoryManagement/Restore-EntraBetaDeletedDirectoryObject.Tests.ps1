# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.Beta.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "@odata.type"       = "#microsoft.graph.user"
                "@odata.Context"    = 'https://graph.microsoft.com/v1.0/`$metadata#directoryObjects/`$entity'
                "displayName"       = "Mock-App"
                "jobTitle"          = "TestMock"
                "mail"              = "SawyerM@contoso.com"
                "mobilePhone"       = "9984534564"
                "userPrincipalName" = "SawyerM@contoso.com"
                "preferredLanguage" = "EN"
            }
        )
    } 

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('User.ReadWrite.All', 'AdministrativeUnit.ReadWrite.All', 'Application.ReadWrite.All', 'Group.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}
Describe "Restore-EntraBetaDeletedDirectoryObject" {
    Context "Restore-EntraBetaDeletedDirectoryObject" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
            { Restore-EntraBetaDeletedDirectoryObject -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 0
        }
        
        It "Should return specific MS deleted directory object" {
            $result = Restore-EntraBetaDeletedDirectoryObject -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should return specific MS deleted directory object with AutoReconcileProxyConflict" {
            $result = Restore-EntraBetaDeletedDirectoryObject -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -AutoReconcileProxyConflict
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should return specific MS deleted directory object with NewUserPrincipalName" {
            $result = Restore-EntraBetaDeletedDirectoryObject -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -NewUserPrincipalName 'SawyerM@contoso.com'
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when Id is empty" {
            { Restore-EntraBetaDeletedDirectoryObject -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }
        It "Should fail when Id is invalid" {
            { Restore-EntraBetaDeletedDirectoryObject -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Result should contain Alias properties" {
            $result = Restore-EntraBetaDeletedDirectoryObject -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
            $result.ObjectId | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result."@odata.type" |  should -Be "#microsoft.graph.user"
        }        
        It "Should contain 'User-Agent' header" {           
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Restore-EntraBetaDeletedDirectoryObject"
            Restore-EntraBetaDeletedDirectoryObject -Id "11112222-bbbb-3333-cccc-4444dddd5555"
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Restore-EntraBetaDeletedDirectoryObject"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Restore-EntraBetaDeletedDirectoryObject -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}    

