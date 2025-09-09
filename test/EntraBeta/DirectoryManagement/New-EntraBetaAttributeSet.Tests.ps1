# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.Beta.DirectoryManagement    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                      = "bbbbbbbb-1111-2222-3333-cccccccccc55"
              "Description"             = "New AttributeSet"
              "MaxAttributesPerSet"     = 21
              "AdditionalProperties"    = @{"[@odata.context" = 'https://graph.microsoft.com/beta/`$metadata#directory/attributeSets/`$entity'}
              "Parameters"              = $args
            }
        )
    }
    Mock -CommandName  New-MgBetaDirectoryAttributeSet -MockWith $scriptblock -ModuleName Microsoft.Entra.Beta.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @("CustomSecAttributeDefinition.ReadWrite.All")
    }} -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "New-EntraBetaAttributeSet" {
    Context "Test for New-EntraBetaAttributeSet" {
        It "Should throw when not connected and not invoke SDK" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.Beta.DirectoryManagement
            { New-EntraBetaAttributeSet -AttributeSetId "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet 21 } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName New-MgBetaDirectoryAttributeSet -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 0
        }
        
        It "Should create new attribute set" {
            $result = New-EntraBetaAttributeSet -AttributeSetId "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet 21
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccc55'
            $result.Description | should -Be "New AttributeSet"
            $result.MaxAttributesPerSet | should -Be 21

            Should -Invoke -CommandName  New-MgBetaDirectoryAttributeSet -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }

        It "Should create new attribute set with alias" {
            $result = New-EntraBetaAttributeSet -Id "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet 21
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'bbbbbbbb-1111-2222-3333-cccccccccc55'
            $result.Description | should -Be "New AttributeSet"
            $result.MaxAttributesPerSet | should -Be 21

            Should -Invoke -CommandName  New-MgBetaDirectoryAttributeSet -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
        }

        It "Should fail when AttributeSetId is empty" {
            { New-EntraBetaAttributeSet -AttributeSetId  -Description "New AttributeSet" -MaxAttributesPerSet 21 } | Should -Throw "Missing an argument for parameter 'AttributeSetId'*"
        }

        It "Should fail when Description is empty" {
            { New-EntraBetaAttributeSet -AttributeSetId "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description  -MaxAttributesPerSet 21 } | Should -Throw "Missing an argument for parameter 'Description'*"
        }

        It "Should fail when MaxAttributesPerSet is empty" {
            { New-EntraBetaAttributeSet -AttributeSetId "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet  } | Should -Throw "Missing an argument for parameter 'MaxAttributesPerSet'*"
        }

        It "Should fail when MaxAttributesPerSet is invalid" {
            { New-EntraBetaAttributeSet -AttributeSetId "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet "XYZ" } | Should -Throw "Cannot process argument transformation on parameter 'MaxAttributesPerSet'*"
        }

        It "Result should Contain ObjectId" {
            $result = New-EntraBetaAttributeSet -AttributeSetId "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet 21
            $result.ObjectId | should -Be "bbbbbbbb-1111-2222-3333-cccccccccc55"
        } 

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAttributeSet"

            $result = New-EntraBetaAttributeSet -AttributeSetId "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet 21
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraBetaAttributeSet"

            Should -Invoke -CommandName New-MgBetaDirectoryAttributeSet -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
                { New-EntraBetaAttributeSet -AttributeSetId "bbbbbbbb-1111-2222-3333-cccccccccc55" -Description "New AttributeSet" -MaxAttributesPerSet 21 -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}

