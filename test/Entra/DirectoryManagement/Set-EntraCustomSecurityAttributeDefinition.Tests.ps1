# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    Mock -CommandName Invoke-GraphRequest -MockWith {} -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('CustomSecAttributeDefinition.Read.All', 'CustomSecAttributeDefinition.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}

Describe "Test for Set-EntraCustomSecurityAttributeDefinition" {
    
    It "Should return empty object" {
        $result = Set-EntraCustomSecurityAttributeDefinition -Id "Demo12_ProjectDatevaluevaluevalue12test" -Description "Test desc" -UsePreDefinedValuesOnly $false -Status "Available"
        $result | Should -BeNullOrEmpty
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
    }
    It "Should fail when ID is empty" {
        { Set-EntraCustomSecurityAttributeDefinition -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
    }
    It "Should fail when Id is null" {
        { Set-EntraCustomSecurityAttributeDefinition -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Set-EntraCustomSecurityAttributeDefinition -xyz } | Should -Throw "A parameter cannot be found that matches parameter name 'xyz'*"
    }
    It "Should contain 'User-Agent' header" {
        Mock -CommandName Invoke-GraphRequest -MockWith {$args} -ModuleName Microsoft.Entra.DirectoryManagement
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraCustomSecurityAttributeDefinition"
        $result = Set-EntraCustomSecurityAttributeDefinition -Id "Demo12_ProjectDatevaluevaluevalue12test" -Description "Test desc" -UsePreDefinedValuesOnly $false -Status "Available"
        $params = Get-Parameters -data $result
        $a= $params | ConvertTo-json | ConvertFrom-Json
        $a.headers.'User-Agent' | Should -Be $userAgentHeaderValue        
    }
    It "Should execute successfully without throwing an error " {
        # Disable confirmation prompts       
        $originalDebugPreference = $DebugPreference
        $DebugPreference = 'Continue'

        try {
            # Act & Assert: Ensure the function doesn't throw an exception
            { Set-EntraCustomSecurityAttributeDefinition -Id "Demo12_ProjectDatevaluevaluevalue12test" -Description "Test desc" -UsePreDefinedValuesOnly $false -Status "Available" } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    }
}

