# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        #Write-Host "Mocking New-EntraPolicy with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "DisplayName"     = "demoClaimstest"
                "Id"              = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "Type"     = "claimsMappingPolicies"
                "IsOrganizationDefault"     = "False"
                "Definition" = "definition-value"
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraPolicy" {
    Context "Test for New-EntraPolicy" {        

        It "Should return created policy" {
            $result = New-EntraPolicy -Definition  @(
                "definition-value"
            ) -DisplayName "Claimstest" -Type "claimsMappingPolicies" -IsOrganizationDefault $false -AlternativeIdentifier "1f587daa-d6fc-433f-88ee-ccccccccc111"
            $result | Should -Not -BeNullOrEmpty           
            $result.DisplayName | should -Be "demoClaimstest"
            $result.Id | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result.IsOrganizationDefault | should -Be "False"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when parameters are invalid" {
            { New-EntraPolicy -Definition "" -DisplayName "" -Type "" -IsOrganizationDefault "" -AlternativeIdentifier "" } | Should -Throw "Cannot bind argument to parameter*"
        }
        It "Should fail when parameters are empty" {
            { New-EntraPolicy -Definition -DisplayName  -Type -IsOrganizationDefault  -AlternativeIdentifier } | Should -Throw "Missing an argument for parameter*"
        }
        It "Result should Contain Id" {            
            $result = New-EntraPolicy -Definition @('{ "definition": [ "{\"ClaimsMappingPolicy\":{\"Version\":1,\"IncludeBasicClaimSet\":\"true\",\"ClaimsSchema\":[{\"Source\":\"user\",\"ID\":\"userPrincipalName\",\"SAMLClaimType\":\"http://xyz.xmlsoap.org/ws/2005/05/pqr/claims/name\",\"JwtClaimType\":\"xyz\"},{\"Source\":\"user\",\"ID\":\"displayName\",\"SAMLClaimType\":\"http://xxx.yyy.com/identity/claims/displayname\",\"JwtClaimType\":\"ppp\"}]}}" ], "displayName": "test Claims Issuance Policy", "isOrganizationDefault": false }') -DisplayName "Claimstest" -Type "claimsMappingPolicies" -IsOrganizationDefault $false -AlternativeIdentifier "1f587daa-d6fc-433f-88ee-ccccccccc111"
            $result.Id | should -Be "bbbbbbbb-1111-2222-3333-cccccccccccc"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraPolicy"
            $result = New-EntraPolicy -Definition @('{ "definition": [ "{\"ClaimsMappingPolicy\":{\"Version\":1,\"IncludeBasicClaimSet\":\"true\",\"ClaimsSchema\":[{\"Source\":\"user\",\"ID\":\"userPrincipalName\",\"SAMLClaimType\":\"http://xyz.xmlsoap.org/ws/2005/05/pqr/claims/name\",\"JwtClaimType\":\"xyz\"},{\"Source\":\"user\",\"ID\":\"displayName\",\"SAMLClaimType\":\"http://xxx.yyy.com/identity/claims/displayname\",\"JwtClaimType\":\"ppp\"}]}}" ], "displayName": "test Claims Issuance Policy", "isOrganizationDefault": false }') -DisplayName "Claimstest" -Type "claimsMappingPolicies" -IsOrganizationDefault $false -AlternativeIdentifier "1f587daa-d6fc-433f-88ee-ccccccccc111"
            $result | Should -Not -BeNullOrEmpty
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraPolicy"
            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { New-EntraPolicy -Definition @('{ "definition": [ "{\"ClaimsMappingPolicy\":{\"Version\":1,\"IncludeBasicClaimSet\":\"true\",\"ClaimsSchema\":[{\"Source\":\"user\",\"ID\":\"userPrincipalName\",\"SAMLClaimType\":\"http://xyz.xmlsoap.org/ws/2005/05/pqr/claims/name\",\"JwtClaimType\":\"xyz\"},{\"Source\":\"user\",\"ID\":\"displayName\",\"SAMLClaimType\":\"http://xxx.yyy.com/identity/claims/displayname\",\"JwtClaimType\":\"ppp\"}]}}" ], "displayName": "test Claims Issuance Policy", "isOrganizationDefault": false }') -DisplayName "Claimstest" -Type "claimsMappingPolicies" -IsOrganizationDefault $false -AlternativeIdentifier "1f587daa-d6fc-433f-88ee-ccccccccc111" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }     
    }
}