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
                "Id"                   = "wasssup snehal"
                "IsActive"             = $true
                "AdditionalProperties" = @{"@odata.context"="https://graph.microsoft.com/beta/`$metadata#directory/customSecurityAttributeDefinitions('Engineering_Projectt')/allowedValues/`$entity"}
                "Parameters"           = $args
            }
        )
    }    
    Mock -CommandName Get-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue" {
    Context "Test for Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue" {
        It "Should get query for given CustomSecurityAttributeDefinitionId" {
            $result = Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when CustomSecurityAttributeDefinitionId are empty" {
            { Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId } | Should -Throw "Missing an argument for parameter 'CustomSecurityAttributeDefinitionId'*"
        }

        It "Should fail when CustomSecurityAttributeDefinitionId is Invalid" {
            { Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId "" } | Should -Throw "Cannot bind argument to parameter 'CustomSecurityAttributeDefinitionId' because it is an empty string."
        }

        It "Should get a specific value for the Id" {
            $result = Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "wasssup snehal"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "wasssup snehal"
            $result.IsActive | Should -Be $true

            Should -Invoke -CommandName Get-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id are empty" {
            { Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is Invalid" {
            { Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Should get a specific value by filter" {
            $result = Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Filter "Id eq 'wasssup snehal'"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "wasssup snehal"
            $result.IsActive | Should -Be $true

            Should -Invoke -CommandName Get-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Filter are empty" {
            { Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Filter } | Should -Throw "Missing an argument for parameter 'Filter'*"
        }

        It "Should contain ObjectId in result" {
            $result = Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "wasssup snehal"
            $result.ObjectId | should -Be "wasssup snehal"
        } 

        It "Should contain AllowedValueId in parameters when passed Id to it" {
            $result = Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "wasssup snehal"
            $params = Get-Parameters -data $result.Parameters
            $params.AllowedValueId | Should -Be "wasssup snehal"

            Should -Invoke -CommandName Get-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain value in parameters when passed Filter to it" {
            $result = Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Filter "Id eq 'wasssup snehal'"
            $params = Get-Parameters -data $result.Parameters
            $params.Filter | Should -Not -BeNullOrEmpty
            $expectedFilter = "Id eq 'wasssup snehal'"
            $params.Filter | Should -Be $expectedFilter

            Should -Invoke -CommandName Get-MgBetaDirectoryCustomSecurityAttributeDefinitionAllowedValue -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue"

            $result = Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "wasssup snehal"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   

        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaCustomSecurityAttributeDefinitionAllowedValue -CustomSecurityAttributeDefinitionId Engineering_Projectt -Id "wasssup snehal" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}