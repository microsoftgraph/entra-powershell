# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Set-MgUserPhotoContent -MockWith {} -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Set-EntraUserThumbnailPhoto" {
    Context "Test for Set-EntraUserThumbnailPhoto" {
        It "Should return specific User" {
            $result = Set-EntraUserThumbnailPhoto -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -FilePath 'D:\UserThumbnailPhoto.jpg'
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Set-MgUserPhotoContent -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should return specific User with alias" {
            $result = Set-EntraUserThumbnailPhoto -ObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -FilePath 'D:\UserThumbnailPhoto.jpg'
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName Set-MgUserPhotoContent -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when UserId is empty string value" {
            { Set-EntraUserThumbnailPhoto -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }

        It "Should fail when UserId is empty" {
            { Set-EntraUserThumbnailPhoto -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should fail when RefObjectId is invalid" {
            { Set-EntraUserThumbnailPhoto -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" RefObjectId "" } | Should -Throw "A positional parameter cannot be found that accepts argument*"
        }

        It "Should contain UserId in parameters when passed ObjectId to it" {
            Mock -CommandName Set-MgUserPhotoContent -MockWith { $args } -ModuleName Microsoft.Entra.Users

            $result = Set-EntraUserThumbnailPhoto -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -FilePath 'D:\UserThumbnailPhoto.jpg'
            $params = Get-Parameters -data $result
            $params.UserId | Should -Match "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        }

        It "Should contain InFile in parameters" {
            Mock -CommandName Set-MgUserPhotoContent -MockWith { $args } -ModuleName Microsoft.Entra.Users

            $result = Set-EntraUserThumbnailPhoto -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -FilePath 'D:\UserThumbnailPhoto.jpg'
            $params = Get-Parameters -data $result
            $params.InFile | Should -Match "UserThumbnailPhoto.jpg"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserThumbnailPhoto"
             
            Set-EntraUserThumbnailPhoto -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -FilePath 'D:\UserThumbnailPhoto.jpg'
    
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserThumbnailPhoto"
    
            Should -Invoke -CommandName Set-MgUserPhotoContent -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
                { Set-EntraUserThumbnailPhoto -UserId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -FilePath 'D:\UserThumbnailPhoto.jpg'-Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}

