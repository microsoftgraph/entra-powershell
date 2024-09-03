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
              "Id"                      = "newdemo201"
              "Description"             = "new test"
              "MaxAttributesPerSet"     = 22
              "AdditionalProperties"    = @{"[@odata.context" = "https://graph.microsoft.com/beta/`$metadata#directory/attributeSets/`$entity"}
              "Parameters"              = $args
            }
        )
    }
    Mock -CommandName  Get-MgBetaDirectoryAttributeSet -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaAttributeSet" {
    Context "Test for Get-EntraBetaAttributeSet" {
        It "Should get attribute set by Id" {
            $result = Get-EntraBetaAttributeSet -Id "newdemo201"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'newdemo201'
            $result.Description | should -Be "new test"
            $result.MaxAttributesPerSet | should -Be 22

            Should -Invoke -CommandName  Get-MgBetaDirectoryAttributeSet -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { Get-EntraBetaAttributeSet -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Id is invalid" {
            { Get-EntraBetaAttributeSet -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }

        It "Result should Contain ObjectId" {
            $result = Get-EntraBetaAttributeSet -Id "newdemo201"
            $result.ObjectId | should -Be "newdemo201"
        } 

        It "Should contain AttributeSetId in parameters when passed Id to it" {
            $result = Get-EntraBetaAttributeSet -Id "newdemo201"
            $params = Get-Parameters -data $result.Parameters
            $params.AttributeSetId | Should -Be "newdemo201"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaAttributeSet"

            $result = Get-EntraBetaAttributeSet -Id "newdemo201"
            $params = Get-Parameters -data $result.Parameters
            $params.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }    
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'
    
            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Get-EntraBetaAttributeSet -Id "newdemo201" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}