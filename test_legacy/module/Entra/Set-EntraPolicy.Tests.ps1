# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    $scriptblock = {
        #Write-Host "Mocking set-EntraPolicy with parameters: $($args | ConvertTo-Json -Depth 3)"
        
        $response = @{
            '@odata.context' = 'https://graph.microsoft.com/v1.0/$metadata#policies/homeRealmDiscoveryPolicies/$entity'            
        }

        return $response
    }
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Test for Set-EntraPolicy" {

    It "Should return empty object" {
        $result = Set-EntraPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" 
        
        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
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
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraPolicy"

        Set-EntraPolicy -Id "Engineering_Project"  -type "HomeRealmDiscoveryPolicy"

        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraPolicy"

        Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
            $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
            $true
        }
    }
    It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraPartnerInformation"

            Set-EntraPartnerInformation -PartnerSupportUrl "http://www.test1.com" -PartnerCommerceUrl "http://www.test1.com" -PartnerHelpUrl "http://www.test1.com" -PartnerSupportEmails "contoso@example.com" -PartnerSupportTelephones "2342" -TenantId b73cc049-a025-4441-ba3a-8826d9a68ecc

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Set-EntraPartnerInformation"

            Should -Invoke -CommandName Invoke-MgGraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Set-EntraPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccccc" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
        }
    } 
}

