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
              "Id"                      = "bbbbbbbb-1111-2222-3333-cccccccccc55"
              "Description"             = "New AttributeSet"
              "MaxAttributesPerSet"     = 21
              "AdditionalProperties"    = @{"[@odata.context" = 'https://graph.microsoft.com/beta/$metadata#directory/attributeSets/$entity'}
              "Parameters"              = $args
            }
        )
    }
    Mock -CommandName  New-MgBetaDirectoryAttributeSet -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "New-EntraBetaAttributeSet" {
    Context "Test for New-EntraBetaAttributeSet" {
        It "Should create new attribute set" {
            $result = New-EntraBetaAttributeSet -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet 21
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccc55'
            $result.Description | should -Be "New AttributeSet"
            $result.MaxAttributesPerSet | should -Be 21

            Should -Invoke -CommandName  New-MgBetaDirectoryAttributeSet -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }

        It "Should fail when Id is empty" {
            { New-EntraBetaAttributeSet -Id  -Description "New AttributeSet" -MaxAttributesPerSet 21 } | Should -Throw "Missing an argument for parameter 'Id'*"
        }

        It "Should fail when Description is empty" {
            { New-EntraBetaAttributeSet -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description  -MaxAttributesPerSet 21 } | Should -Throw "Missing an argument for parameter 'Description'*"
        }

        It "Should fail when MaxAttributesPerSet is empty" {
            { New-EntraBetaAttributeSet -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet  } | Should -Throw "Missing an argument for parameter 'MaxAttributesPerSet'*"
        }

        It "Should fail when MaxAttributesPerSet is invalid" {
            { New-EntraBetaAttributeSet -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet "XYZ" } | Should -Throw "Cannot process argument transformation on parameter 'MaxAttributesPerSet'*"
        }

        It "Result should Contain ObjectId" {
            $result = New-EntraBetaAttributeSet -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet 21
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAttributeSet"

            $result = New-EntraBetaAttributeSet -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet 21
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAttributeSet"

            Should -Invoke -CommandName New-MgBetaDirectoryAttributeSet -ModuleName Microsoft.Graph.Entra.Beta -Times 1 -ParameterFilter {
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
                { New-EntraBetaAttributeSet -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet 21 -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}