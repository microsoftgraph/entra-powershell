# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<# BeforeAll {

    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.Users
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Users

} #>
BeforeAll {

    if ((Get-Module -Name Microsoft.Entra.Users) -eq $null) {
        Import-Module Microsoft.Entra.Users      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    # Mock Invoke-GraphRequest with realistic responses as PSCustomObjects
    Mock -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -MockWith {
        param($Uri, $Method, $Headers, $Body)

        if ($Uri -eq "/v1.0/directoryObjects/getAvailableExtensionProperties") {
            return [PSCustomObject]@{
                value = @(
                    [PSCustomObject]@{ name = "extension_12345_JobGroup" },
                    [PSCustomObject]@{ name = "extension_67890_Department" }
                )
            }
        }

        if ($Uri -match "/v1.0/users/.+\?\$select=.+") {
            return [PSCustomObject]@{
                id                          = "e92dec24-bcc4-414d-bc13-b0b5a6b97d45"
                userPrincipalName           = "sawyerM@contoso.com"
                createdDateTime             = "2024-03-07T03:10:41Z"
                employeeId                  = "123456"
                onPremisesDistinguishedName = "CN=SawyerM,OU=Users,DC=contoso,DC=com"
                identities                  = @()
                extension_12345_JobGroup    = "Job Group D"
                extension_67890_Department  = "Finance"
            }
        }

        # Default empty response for other URIs
        return [PSCustomObject]@{}
    }

    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("User.Read.All") } } -ModuleName Microsoft.Entra.Users
}

Describe "Tests for Get-EntraUserExtensions" {

    It "Should return empty object" {
        $result = Get-EntraUserExtensions -UserId "sawyerM@contoso.com"
        $result | Should -Not -BeNull
    }

    It "Should fail when UserId is missing" {
        { Get-EntraUserExtensions -UserId } | Should -Throw "Missing an argument for parameter 'UserId'. Specify a parameter of type 'System.String' and try again."
    }
    
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserExtensions"
        $result = Get-EntraUserExtensions -UserId "sawyerM@contoso.com"
        $result | Should -Not -BeNull
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Users -Times 1 -ParameterFilter {
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
            { Get-EntraUserExtensions -UserId "sawyerM@contoso.com" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}
