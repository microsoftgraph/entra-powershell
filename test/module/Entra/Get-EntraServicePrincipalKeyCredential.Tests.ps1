# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "KeyCredentials"                    = @{
                    "CustomKeyIdentifier"           = ""
                    "DisplayName"                   = ""
                    "EndDateTime"                   = "08-Feb-25 9:57:08 AM"
                    "Key"                           = ""
                    "KeyId"                         = "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
                    "StartDateTime"                 = "08-Feb-24 9:57:08 AM"
                    "Type"                          = "Symmetric"
                    "Usage"                         = "Sign"
                    "AdditionalProperties"          = @{}
                    "Parameters"                    = $args
                }    
            }
        )
    }
    Mock -CommandName Get-MgServicePrincipal -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraServicePrincipalKeyCredential" {
    Context "Test for Get-EntraServicePrincipalKeyCredential" {
        It "Should return specific principal key credential" {
            $objectId = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result = Get-EntraServicePrincipalKeyCredential -ObjectId $objectId
            $result | Should -Not -BeNullOrEmpty
            $result.KeyId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            $errorActionPreference = "Stop"
            { Get-EntraServicePrincipalKeyCredential -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        
        It "Should fail when ObjectId is invalid" {
            $errorActionPreference = "Stop"
            { Get-EntraServicePrincipalKeyCredential -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            $result = Get-EntraServicePrincipalKeyCredential -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $servicePrincipalKeyCredential = $result | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $params = Get-Parameters -data $servicePrincipalKeyCredential.Parameters
            $params.ServicePrincipalId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalKeyCredential"

            $result = Get-EntraServicePrincipalKeyCredential -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalKeyCredential"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                { Get-EntraServicePrincipalKeyCredential -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}