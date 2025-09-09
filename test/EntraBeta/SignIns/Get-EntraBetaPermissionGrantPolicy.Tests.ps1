# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.SignIns) -eq $null) {
        Import-Module Microsoft.Entra.Beta.SignIns   
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"              = "microsoft-all-application-permissions"
                "DeletedDateTime" = "2/8/2024 6:39:16 AM"
                "Description"     = "Includes all application permissions (app roles), for all APIs, for any client application."
                "DisplayName"     = "All application"
                "Excludes"        = @{}
                "Includes"        = @("00aa00aa-bb11-cc22-dd33-44ee44ee44ee")
                "Parameters"      = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaPolicyPermissionGrantPolicy -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.SignIns

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Policy.Read.PermissionGrant')
    }} -ModuleName Microsoft.Entra.Beta.SignIns
}
  
Describe "Get-EntraBetaPermissionGrantPolicy" {
    Context "Test for Get-EntraBetaPermissionGrantPolicy" {
        It "Should return specific PermissionGrantPolicy" {
            $result = Get-EntraBetaPermissionGrantPolicy -Id "microsoft-all-application-permissions"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "microsoft-all-application-permissions"

            Should -Invoke -CommandName Get-MgBetaPolicyPermissionGrantPolicy  -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraBetaPermissionGrantPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when Id is empty" {
            { Get-EntraBetaPermissionGrantPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'. Specify a parameter of type 'System.String' and try again."
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaPermissionGrantPolicy -Id "microsoft-all-application-permissions"
            $result.ObjectId | should -Be "microsoft-all-application-permissions"
        }     
        It "Should contain PermissionGrantPolicyId in parameters when passed ObjectId to it" {              
            $result = Get-EntraBetaPermissionGrantPolicy -Id "microsoft-all-application-permissions"
            $params = Get-Parameters -data $result.Parameters
            $params.PermissionGrantPolicyId | Should -Be "microsoft-all-application-permissions"
        }
        It "Property parameter should work" {
            $result = Get-EntraBetaPermissionGrantPolicy -Id "microsoft-all-application-permissions" -Property DisplayName
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | Should -Be 'All application'

            Should -Invoke -CommandName Get-MgBetaPolicyPermissionGrantPolicy -ModuleName Microsoft.Entra.Beta.SignIns -Times 1
        }
        It "Should fail when Property is empty" {
             { Get-EntraBetaPermissionGrantPolicy -Id "microsoft-all-application-permissions" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPermissionGrantPolicy"

            $result = Get-EntraBetaPermissionGrantPolicy -Id "microsoft-all-application-permissions"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaPermissionGrantPolicy"

            Should -Invoke -CommandName Get-MgBetaPolicyPermissionGrantPolicy -ModuleName Microsoft.Entra.Beta.SignIns -Times 1 -ParameterFilter {
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
                { Get-EntraBetaPermissionGrantPolicy -Id "microsoft-all-application-permissions" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

