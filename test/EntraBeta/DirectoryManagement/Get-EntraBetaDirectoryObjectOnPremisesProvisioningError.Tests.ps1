# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.Beta.DirectoryManagement        
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        $errors = @{
            "category"               = "PropertyConflict"
            "occurredDateTime"       =  "11/07/2024 23:11:06"
            "propertyCausingError"   =  "ProxyAddresses"
            "value"                  =  "SMTP:ConflictMail@contoso.com"
        }
        $valueObject = @{
            "id"                           = "2ba6fbc5-e7e0-4d6d-9878-a147632d75ea"
            "onPremisesSyncEnabled"        = $true
            "proxyAddresses"               = @("smtp:ConflictMail1@contoso.com", "smtp:ConflictMail2@contoso.com")
            "displayName"                  = "ConflictMail2"
            "mail"                         = $null
            "onPremisesProvisioningErrors" = @($errors)
        }

        $response = @{
            '@odata.context'        = 'https://graph.microsoft.com/beta/$metadata#contacts(Id,UserPrincipalName,DisplayName,Mail,ProxyAddresses,onPremisesProvisioningErrors,onPremisesSyncEnabled)'
            value                   = @($valueObject)
        }

        return @(
            $response
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('User.Read.All', 'Directory.Read.All', 'Group.Read.All', 'Contacts.Read')
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Get-EntraBetaDirectoryObjectOnPremisesProvisioningError" {
    Context "Test for Get-EntraBetaDirectoryObjectOnPremisesProvisioningError" {
        It "Should not return empty object" {
            $result = Get-EntraBetaDirectoryObjectOnPremisesProvisioningError 
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should not return empty object when TenantId is passed" {
            $result = Get-EntraBetaDirectoryObjectOnPremisesProvisioningError -TenantId "0000aaaa-11bb-cccc-dd22-eeeeee333333"
            $result | Should -Not -BeNullOrEmpty
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }
        It "Should fail when TenantId is null" {
            { Get-EntraBetaDirectoryObjectOnPremisesProvisioningError -TenantId } | Should -Throw "Missing an argument for parameter 'TenantId'*"
        }
        It "Should fail when TenantId is empty" {
            { Get-EntraBetaDirectoryObjectOnPremisesProvisioningError -TenantId "" } | Should -Throw "Cannot process argument transformation on parameter 'TenantId'.*"
        }
        It "Should fail when invalid paramter is passed" {
            { Get-EntraBetaDirectoryObjectOnPremisesProvisioningError -Demo } | Should -Throw "A parameter cannot be found that matches parameter name 'Demo'*"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirectoryObjectOnPremisesProvisioningError"
            $result = Get-EntraBetaDirectoryObjectOnPremisesProvisioningError
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDirectoryObjectOnPremisesProvisioningError"
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
                { Get-EntraBetaDirectoryObjectOnPremisesProvisioningError -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}