# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Remove-EntraUserSponsor" {
    Context "Test for Remove-EntraUserSponsor" {
        It "should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Users
            $userId = "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $dirObjectId = "ec5b1c17-940b-47c3-9e8e-6c7e71b9c1ca"
            { Remove-EntraUserSponsor -UserId $userId -DirectoryObjectId $dirObjectId } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 0
        }
        
        It "Should fail when UserId is empty string value" {
            { Remove-EntraUserSponsor -UserId "" -SponsorId "sponsor123" } | 
            Should -Throw "Cannot validate argument on parameter 'UserId'. UserId must be a valid email address or GUID."
        }

        It "Should fail when UserId is empty" {
            { Remove-EntraUserSponsor -UserId } | 
            Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should fail when SponsorId is empty string value" {
            { Remove-EntraUserSponsor -UserId "user123" -SponsorId "" } | 
            Should -Throw "Cannot validate argument on parameter 'UserId'. UserId must be a valid email address or GUID."
        }

        It "Should fail when SponsorId is empty" {
            { Remove-EntraUserSponsor -UserId "user123" -SponsorId } | 
            Should -Throw "Missing an argument for parameter 'SponsorId'. Specify a parameter of type 'System.Guid' and try again."
        }

        It "Should call Invoke-GraphRequest with correct parameters" {
            $userId = "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $sponsorId = "ec5b1c17-940b-47c3-9e8e-6c7e71b9c1ca"
            
            Remove-EntraUserSponsor -UserId $userId -SponsorId $sponsorId
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -Exactly
        }

        It "Should accept DirectoryObjectId as alias for SponsorId" {
            $userId = "ec5813fb-346e-4a33-a014-b55ffee3662b"
            $dirObjectId = "ec5b1c17-940b-47c3-9e8e-6c7e71b9c1ca"
            
            Remove-EntraUserSponsor -UserId $userId -DirectoryObjectId $dirObjectId
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -Exactly
        }
    }
}