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
                "PasswordCredentials" = @{
                    "StartDate"            = "17-Apr-24 7:32:41 AM"
                    "EndDate"              = "17-Apr-25 7:32:41 AM"
                    "CustomKeyIdentifier"  = ""
                    "DisplayName"          = ""
                    "EndDateTime"          = "17-Apr-25 7:32:41 AM"
                    "Key"                  = ""
                    "KeyId"                = "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
                    "StartDateTime"        = "17-Apr-24 7:32:41 AM"
                    "Hint"                 = "gjW"
                    "SecretText"           = ""
                    "AdditionalProperties" = @{}
                    "Parameters"           = $args
                }
            }
        )
    }
    Mock -CommandName Get-MgServicePrincipal -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
}
  
Describe "Get-EntraServicePrincipalPasswordCredential" {
    Context "Test for Get-EntraServicePrincipalPasswordCredential" {
        It "Should return specific principal password credential" {
            $ServicePrincipalId = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result = Get-EntraServicePrincipalPasswordCredential -ServicePrincipalId $ServicePrincipalId
            $result | Should -Not -BeNullOrEmpty
            $result.KeyId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            
            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should update the parameter with Alias" {
            $ServicePrincipalId = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result = Get-EntraServicePrincipalPasswordCredential -ObjectId $ServicePrincipalId
            $result | Should -Not -BeNullOrEmpty
            $result.KeyId | Should -Be "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
            
            Should -Invoke -CommandName Get-MgServicePrincipal -ModuleName Microsoft.Entra.Applications -Times 1
        }

        It "Should fail when ServicePrincipalId is empty" {
            $errorActionPreference = "Stop"
            { Get-EntraServicePrincipalPasswordCredential -ServicePrincipalId } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'*"
        }

        It "Should fail when ServicePrincipalId is invalid" {
            $errorActionPreference = "Stop"
            { Get-EntraServicePrincipalPasswordCredential -ServicePrincipalId "" } | Should -Throw "Cannot validate argument on parameter 'ServicePrincipalId'. The argument is null or empty. Provide an argument that is not null or empty, and then try the command again."
        }

        It "Should contain ServicePrincipalId in parameters when passed ServicePrincipalId to it" {
            $result = Get-EntraServicePrincipalPasswordCredential -ServicePrincipalId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $servicePrincipalPasswordCredential = $result | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $params = Get-Parameters -data $servicePrincipalPasswordCredential.Parameters
            $params.ServicePrincipalId | Should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalPasswordCredential"

            $result = Get-EntraServicePrincipalPasswordCredential -ServicePrincipalId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraServicePrincipalPasswordCredential"

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
                { Get-EntraServicePrincipalPasswordCredential -ObjectId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Debug } | Should -Not -Throw
            }
            finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

