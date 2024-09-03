# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                   = "sss"
                "IsActive"             = $true
                "AdditionalProperties" = @{"@odata.context"="https://graph.microsoft.com/beta/`$metadata#directory/customSecurityAttributeDefinitions('Engineering_Projectt')/allowedValues/`$entity"}
                "Parameters"           = $args
            }
        )
    }    
    Mock -CommandName New-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Add-EntraBetacustomSecurityAttributeDefinitionAllowedValues" {
    Context "Test for Add-EntraBetacustomSecurityAttributeDefinitionAllowedValues" {
        It "Should update a specific value for the Id" {
            $result = Add-EntraBetacustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "sss" -IsActive $true
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "sss"
            $result.IsActive | Should -Be $true

            Should -Invoke -CommandName New-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when CustomSecurityAttributeDefinitionId are empty" {
            { Add-EntraBetacustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId  -Id "sss" -IsActive $true } | Should -Throw "Missing an argument for parameter 'CustomSecurityAttributeDefinitionId'*"
        }

        It "Should fail when CustomSecurityAttributeDefinitionId is Invalid" {
            { Add-EntraBetacustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId "" -Id "sss" -IsActive $true } | Should -Throw "Cannot bind argument to parameter 'CustomSecurityAttributeDefinitionId' because it is an empty string."
        }

        It "Should fail when Id are empty" {
            { Add-EntraBetacustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id -IsActive $true } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is Invalid" {
            { Add-EntraBetacustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "" -IsActive $true } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should fail when IsActive are empty" {
            { Add-EntraBetacustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "sss" -IsActive } | Should -Throw "Missing an argument for parameter 'IsActive'*"
        }

        It "Should fail when IsActive are invalid" {
            { Add-EntraBetacustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "sss" -IsActive dffg } | Should -Throw "Cannot process argument transformation on parameter 'IsActive'*"
        }

        It "Result should Contain ObjectId" {
            $result = Add-EntraBetacustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "sss" -IsActive $true
            $result.ObjectId | should -Be "sss"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraBetacustomSecurityAttributeDefinitionAllowedValues"
            
            $result = Add-EntraBetacustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "sss" -IsActive $true
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Add-EntraBetacustomSecurityAttributeDefinitionAllowedValues -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "sss" -IsActive $true -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}