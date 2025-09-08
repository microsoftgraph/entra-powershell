# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        
        Import-Module Microsoft.Entra.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

$scriptblock = {
    return @(
        [PSCustomObject]@{
           "Id"                               = "00001111-aaaa-2222-bbbb-3333cccc4444" 
           "OnPremisesLastSyncDateTime"       = $null
           "OnPremisesSyncEnabled"            = $null
           "BusinessPhones"                   = {"425-555-0100"}
           "City"                             = "Luchthaven Schiphol"
           "DisplayName"                      = "Mock App"
           "MarketingNotificationEmails"      = {"mary@contoso.com", "john@contoso.com"}
           "State"                            = "Noord-Holland"
           "Street"                           = "Evert van de Beekstraat 354"
           "TechnicalNotificationMails"       = {"peter@contoso.com"}
           "TenantType"                       = "AAD"
           "AssignedPlans"                    = @{AssignedDateTime="04-12-2023 16:50:27"; CapabilityStatus="Enabled"; Service="MixedRealityCollaborationServices"; ServicePlanId="dcf9d2f4-772e-4434-b757-77a453cfbc02";
                                                    AdditionalProperties=""}
           "ProvisionedPlans"                 = @{CapabilityStatus="Enabled"; ProvisioningStatus="Success"; Service="exchange"; AdditionalProperties=""}
           "VerifiedDomains"                  = @{Capabilities="Email"; IsDefault="False"; IsInitial="True"; Name="M365x99297270.onmicrosoft.com"; Type="Managed"; AdditionalProperties=""}                                   
           "PrivacyProfile"                   = @{ContactEmail="alice@contoso.com"; StatementUrl="https://contoso.com/privacyStatement"; AdditionalProperties=""}
           "Parameters"                       = $args
          
        } 
    )

}

    Mock -CommandName Get-MgOrganization -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Organization.Read.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}


Describe "Get-EntraTenantDetail" {
    Context "Test for Get-EntraTenantDetail" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Get-EntraTenantDetail -All } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgOrganization -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }
        
        It "Should return all Tenant Detail" {
            $result = Get-EntraTenantDetail -All 
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgOrganization -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }   
        It "Should fail when All is invalid" {
            { Get-EntraTenantDetail -All XY } | Should -Throw "A positional parameter cannot be found that accepts argument 'xy'.*"
        }  
        It "Should return top Tenant Detail" {
            $result = Get-EntraTenantDetail -Top 1
            $result | Should -Not -BeNullOrEmpty
            
            Should -Invoke -CommandName Get-MgOrganization -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }   
        It "Should fail when Top is empty" {
            { Get-EntraTenantDetail -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraTenantDetail -Top "xyz" } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Property parameter should work" {
            $result = Get-EntraTenantDetail -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'Mock App'

            Should -Invoke -CommandName Get-MgOrganization -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraTenantDetail -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraTenantDetail"

            Get-EntraTenantDetail
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraTenantDetail"

            Should -Invoke -CommandName Get-MgOrganization -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraTenantDetail -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }   
}

