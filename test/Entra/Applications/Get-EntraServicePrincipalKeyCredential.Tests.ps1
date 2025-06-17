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
                "KeyCredentials" = @{
                    "CustomKeyIdentifier"  = ""
                    "DisplayName"          = ""
                    "EndDateTime"          = "08-Feb-25 9:57:08 AM"
                    "Key"                  = ""
                    "KeyId"                = "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
                    "StartDateTime"        = "08-Feb-24 9:57:08 AM"
                    "Type"                 = "Symmetric"
                    "Usage"                = "Sign"
                    "AdditionalProperties" = @{}
                    "Parameters"           = $args
                }    
            }
        )
    }
    Mock -CommandName Get-MgServicePrincipal -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Application.Read.All") } } -ModuleName Microsoft.Entra.Applications
}
  
Describe "Get-EntraServicePrincipalKeyCredential" {
    Context "Test for Get-EntraServicePrincipalKeyCredential" {
        It "Should return specific principal key credential" {
            $servicePrincipalObjectId = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result = Get-EntraServicePrincipalKeyCredential -ServicePrincipalId $servicePrincipalObjectId
            $result | Should -Not -BeNullOrEmpty
            $result.KeyId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should update the parameter with Alias" {
            $servicePrincipalObjectId = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result = Get-EntraServicePrincipalKeyCredential -ObjectId $servicePrincipalObjectId
            $result | Should -Not -BeNullOrEmpty
            $result.KeyId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Should fail when ServicePrincipalId is empty" {
            $errorActionPreference = "Stop"
            { Get-EntraServicePrincipalKeyCredential -ServicePrincipalId } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'*"
        }
        
        It "Should fail when ServicePrincipalId is invalid" {
            $errorActionPreference = "Stop"
            { Get-EntraServicePrincipalKeyCredential -ServicePrincipalId "" } | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }

        It "Should contain ServicePrincipalId in parameters when passed ServicePrincipalId to it" {
            $result = Get-EntraServicePrincipalKeyCredential -ServicePrincipalId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $servicePrincipalKeyCredential = $result | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $params = Get-Parameters -data $servicePrincipalKeyCredential.Parameters
            $params.ServicePrincipalId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalKeyCredential"

            $result = Get-EntraServicePrincipalKeyCredential -ServicePrincipalId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalKeyCredential"

            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
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
                { Get-EntraServicePrincipalKeyCredential -ServicePrincipalId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }    
    }
}

