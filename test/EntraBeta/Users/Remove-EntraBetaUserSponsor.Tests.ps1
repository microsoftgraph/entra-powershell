# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.Users) -eq $null) {
        Import-Module Microsoft.Entra.Beta.Users    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Beta.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Beta.Users
}

Describe "Remove-EntraBetaUserSponsor" {
    Context "Test for Remove-EntraBetaUserSponsor" {
        It "Should throw when not connected and not invoke graph call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.Users
            { Remove-EntraBetaUserSponsor -UserId "bbbbbbbb-1111-2222-3333-cccccccccccc" -SponsorId "367412e8-7403-454c-b5d9-680fff0afff7" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 0
        }
        
        It "Should fail when UserId is empty string value" {
            { Remove-EntraBetaUserSponsor -UserId "" -SponsorId "367412e8-7403-454c-b5d9-680fff0afff7" } | 
            Should -Throw "Cannot validate argument on parameter 'UserId'. UserId must be a valid email address or GUID."
        }

        It "Should fail when UserId is empty" {
            { Remove-EntraBetaUserSponsor -UserId } | 
            Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should fail when SponsorId is empty string value" {
            { Remove-EntraBetaUserSponsor -UserId "aef74418-9a67-47e2-a956-490cfd0e7765" -SponsorId "" } | 
            Should -Throw "Cannot process argument transformation on parameter 'SponsorId'. Cannot convert value*"
        }

        It "Should fail when SponsorId is empty" {
            { Remove-EntraBetaUserSponsor -UserId "aef74418-9a67-47e2-a956-490cfd0e7765" -SponsorId } | 
            Should -Throw "Missing an argument for parameter 'SponsorId'. Specify a parameter of type 'System.Guid' and try again."
        }

        It "Should call Invoke-GraphRequest with correct parameters" {
            $userId = "aef74418-9a67-47e2-a956-490cfd0e7765"
            $sponsorId = "367412e8-7403-454c-b5d9-680fff0afff7"
            
            Remove-EntraBetaUserSponsor -UserId $userId -SponsorId $sponsorId
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -Exactly
        }

        It "Should accept DirectoryObjectId as alias for SponsorId" {
            $userId = "aef74418-9a67-47e2-a956-490cfd0e7765"
            $dirObjectId = "367412e8-7403-454c-b5d9-680fff0afff7"
            
            Remove-EntraBetaUserSponsor -UserId $userId -DirectoryObjectId $dirObjectId
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.Users -Times 1 -Exactly
        }
    }
}
