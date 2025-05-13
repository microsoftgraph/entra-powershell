# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {
    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users

    $scriptblock = {
        # Write-Host "Mocking Set-EntraUserLicense with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                userPrincipalName = "test122@M365x99297270.OnMicrosoft.com"
                preferredLanguage = "EN"
                mobilePhone       = "9984534564"
                displayName       = "SNEHALtest"
                givenName         = "test12"
                mail              = "test122@M365x99297270.OnMicrosoft.com"
                '@odata.context'  = "https://graph.microsoft.com/v1.0/`$metadata#users/`$entity"
                id                = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
                jobTitle          = "testqa"
                officeLocation    = "test"
                businessPhones    = @("8976546787")
                surname           = "KTETSs"            
                Parameters        = $args
            }
        )

    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.ReadWrite.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Set-EntraUserLicense" {
    Context "Test for Set-EntraUserLicense" {
        It "Should return specific User" {
            $addLicensesArray = [PSCustomObject]@{
                skuId = "66aa66aa-bb77-cc88-dd99-00ee00ee00ee"
            }
            $Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
            $Licenses.AddLicenses = $addLicensesArray
            $result = Set-EntraUserLicense -UserId 1139c016-f606-45f0-83f7-40eb2a552a6f -AssignedLicenses $Licenses

            $result | Should -Not -BeNullOrEmpty
            $result.userPrincipalName | Should -Be "test122@M365x99297270.OnMicrosoft.com"
            $result.preferredLanguage | Should -Be "EN"
            $result.mobilePhone | Should -Be "9984534564"
            $result.displayName | Should -Be "SNEHALtest"
            $result.givenName | Should -Be "test12"
            $result.mail | Should -Be "test122@M365x99297270.OnMicrosoft.com"
            $result.'@odata.context' | Should -Be "https://graph.microsoft.com/v1.0/`$metadata#users/`$entity"
            $result.id | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.jobTitle | Should -Be "testqa"
            $result.officeLocation | Should -Be "test"
            $result.businessPhones | Should -Be @("8976546787")
            $result.surname | Should -Be "KTETSs"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1
        }

        It "Should fail when UserId is empty string value" {
            { Set-EntraUserLicense -UserId "" } | Should -Throw "Cannot bind argument to parameter 'UserId' because it is an empty string."
        }

        It "Should fail when UserId is empty" {
            { Set-EntraUserLicense -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
        }

        It "Should fail when AssignedLicenses is empty" {
            { Set-EntraUserLicense -UserId '00aa00aa-bb11-cc22-dd33-44ee44ee44ee' -AssignedLicenses } | Should -Throw "Missing an argument for parameter 'AssignedLicenses'. Specify a parameter of type 'Microsoft.Open.AzureAD.Model.AssignedLicenses' and try again."
        }

        It "Should contain UserId in parameters when passed UserId to it" {
            $addLicensesArray = [PSCustomObject]@{
                skuId = "66aa66aa-bb77-cc88-dd99-00ee00ee00ee"
            }
            $Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
            $Licenses.AddLicenses = $addLicensesArray
            $result = Set-EntraUserLicense -UserId '00aa00aa-bb11-cc22-dd33-44ee44ee44ee' -AssignedLicenses $Licenses
    
            $params = Get-Parameters -data $result.Parameters
            $params.Uri | Should -Match "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserLicense"
            $addLicensesArray = [PSCustomObject]@{
                skuId = "66aa66aa-bb77-cc88-dd99-00ee00ee00ee"
            }
            $Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
            $Licenses.AddLicenses = $addLicensesArray
             
            Set-EntraUserLicense -UserId '00aa00aa-bb11-cc22-dd33-44ee44ee44ee' -AssignedLicenses $Licenses
    
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraUserLicense"
    
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
            $addLicensesArray = [PSCustomObject]@{
                skuId = "66aa66aa-bb77-cc88-dd99-00ee00ee00ee"
            }
            $Licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses
            $Licenses.AddLicenses = $addLicensesArray
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraUserLicense -UserId '00aa00aa-bb11-cc22-dd33-44ee44ee44ee' -AssignedLicenses $Licenses -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }

    }
}

