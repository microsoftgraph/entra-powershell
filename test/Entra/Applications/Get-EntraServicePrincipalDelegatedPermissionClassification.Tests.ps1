# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Applications) -eq $null) {
        Import-Module Microsoft.Entra.Applications      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"             = "T2qU_E28O0GgkLLIYRPsTwE"
                "Classification" = "low"
                "PermissionId"   = "22cc22cc-dd33-ee44-ff55-66aa66aa66aa"
                "PermissionName" = "LicenseManager.AccessAsUser"
                "Parameters"     = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalDelegatedPermissionClassification -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Applications
}
  
Describe "Get-EntraServicePrincipalDelegatedPermissionClassification" {
    Context "Test for Get-EntraServicePrincipalDelegatedPermissionClassification" {
        It "Should return specific ServicePrincipalDelegatedPermissionClassification" {
            $result = Get-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "T2qU_E28O0GgkLLIYRPsTwE"

            Should -Invoke -CommandName Get-MgServicePrincipalDelegatedPermissionClassification -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ServicePrincipalId is invalid" {
            { Get-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "" } | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }
        It "Should fail when ServicePrincipalId is empty" {
            { Get-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'.*"
        }
        It "Should return specific ServicePrincipalDelegatedPermissionClassification when Id passed to it" {
            $result = Get-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id 'T2qU_E28O0GgkLLIYRPsTwE'
            $params = Get-Parameters -data $result.Parameters 
            $params.DelegatedPermissionClassificationId | should -Be "T2qU_E28O0GgkLLIYRPsTwE"
        } 
        It "Should fail when Id is invalid" {
            { Get-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id "" } | Should -Throw "Cannot validate argument on parameter 'Id'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }  
        It "Should fail when Id is empty" {
            { Get-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Id } | Should -Throw "Missing an argument for parameter 'Id'.*"
        } 
        It "Should return specific ServicePrincipalDelegatedPermissionClassification when applied filter to it" {
            $result = Get-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Filter "PermissionName eq 'LicenseManager.AccessAsUser'"
            $result.PermissionName | should -Be "LicenseManager.AccessAsUser"
            $result.ObjectId | should -Be "T2qU_E28O0GgkLLIYRPsTwE"
        }  
        It "Should fail when Filter is empty" {
            { Get-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Filter } | Should -Throw "Missing an argument for parameter 'Filter'.*"
        } 
        It "Property parameter should work" {
            $result = Get-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Property PermissionName
            $result | Should -Not -BeNullOrEmpty
            $result.PermissionName | Should -Be 'LicenseManager.AccessAsUser'

            Should -Invoke -CommandName Get-MgServicePrincipalDelegatedPermissionClassification -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when Property is empty" {
            { Get-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }  
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalDelegatedPermissionClassification"

            $result = Get-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalDelegatedPermissionClassification"

            Should -Invoke -CommandName Get-MgServicePrincipalDelegatedPermissionClassification -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Get-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-bbbb-cccc-1111-222222222222" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

