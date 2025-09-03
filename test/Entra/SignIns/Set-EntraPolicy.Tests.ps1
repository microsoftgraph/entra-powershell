# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.SignIns) -eq $null){
        Import-Module Microsoft.Entra.SignIns
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    $scriptblock = {
        #Write-Host "Mocking set-EntraPolicy with parameters: $($args | ConvertTo-Json -Depth 3)"
        
        $response = @{
            '@odata.context' = 'https://graph.microsoft.com/v1.0/`$metadata#policies/homeRealmDiscoveryPolicies/`$entity'            
        }

        return $response
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Entra.SignIns
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @('Policy.ReadWrite.ApplicationConfiguration') } } -ModuleName Microsoft.Entra.SignIns
}

Describe "Test for Set-EntraPolicy" {

    It "Should return empty object" {
        $matches = @('permissionGrantPolicies','homeRealmDiscoveryPolicies')
        InModuleScope 'Microsoft.Entra.SignIns' -Parameters @{ Matches = $matches } {
            $result = Set-EntraPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" 
            
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.SignIns -Times 1
        }
    }

    It "Should fail when id is empty" {
        { Set-EntraPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
    }
    It "Should fail when Id is null" {
        { Set-EntraPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
    }
    It "Should fail when displaymane is null" {
        { Set-EntraPolicy -DisplayName } | Should -Throw "Missing an argument for parameter 'DisplayName'*"
    }
    It "Should fail when AlternativeIdentifier is null" {
        { Set-EntraPolicy -AlternativeIdentifier } | Should -Throw "Missing an argument for parameter 'AlternativeIdentifier'*"
    }
    It "Should fail when IsOrganizationDefault is null" {
        { Set-EntraPolicy -IsOrganizationDefault } | Should -Throw "Missing an argument for parameter 'IsOrganizationDefault'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Set-EntraPolicy -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }

    It "Should contain 'User-Agent' header" {
        $matches = @('permissionGrantPolicies','homeRealmDiscoveryPolicies')
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraPolicy"
        $customHeaders = New-Object 'system.collections.generic.dictionary[string,string]'
        $customHeaders["User-Agent"] = $userAgentHeaderValue
        InModuleScope 'Microsoft.Entra.SignIns' -Parameters @{ Matches = $matches; customHeaders = $customHeaders} {
            Set-EntraPolicy -Id "Engineering_Project"  -type "HomeRealmDiscoveryPolicy"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.SignIns -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $customHeaders["User-Agent"]
                $true
            }
        }
    }
    It "Should execute successfully without throwing an error" {
        $matches = @('permissionGrantPolicies','homeRealmDiscoveryPolicies')
        InModuleScope 'Microsoft.Entra.SignIns' -Parameters @{ Matches = $matches } {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Set-EntraPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }            
    } 
}


