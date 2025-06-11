# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if ((Get-Module -Name Microsoft.Entra.Beta.DirectoryManagement) -eq $null) {
        Import-Module Microsoft.Entra.Beta.DirectoryManagement      
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $mockDeletedDirectoryObject = {
        return @(
            [PSCustomObject]@{
                Id                   = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                AdditionalProperties = @{
                    '@odata.context'  = 'https://graph.microsoft.com/beta/$metadata#directoryObjects/$entity'
                    '@odata.type'     = '#microsoft.graph.group'
                    'createdDateTime' = '2025-02-07T08:09:31Z'
                    'creationOptions' = @("Option1", "Option2")
                }
                DeletedDateTime      = (Get-Date).AddDays(-1)
                Parameters           = $args
            }
        )
    }
    
    Mock -CommandName Get-MgBetaDirectoryDeletedItem -MockWith $mockDeletedDirectoryObject -ModuleName Microsoft.Entra.Beta.DirectoryManagement
}

Describe "Get-EntraBetaDeletedDirectoryObject" {
    It "Result should return DeletedDirectoryObject using alias" {
        $result = Get-EntraBetaDeletedDirectoryObject -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result.Id | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
    }
    It "Should fail when DirectoryObjectId is empty" {
        { Get-EntraBetaDeletedDirectoryObject -DirectoryObjectId "" } | Should -Throw "Cannot bind argument to parameter 'DirectoryObjectId'*"
    }
    It "Should fail when DirectoryObjectId is null" {
        { Get-EntraBetaDeletedDirectoryObject -DirectoryObjectId } | Should -Throw "Missing an argument for parameter 'DirectoryObjectId'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Get-EntraBetaDeletedDirectoryObject -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'*"
    }
    It "Result should Contain ObjectId" {
        $result = Get-EntraBetaDeletedDirectoryObject -DirectoryObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result.ObjectId | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
    }    

    It "Property parameter should work" {
        $result = Get-EntraBetaDeletedDirectoryObject -DirectoryObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -Property Id 
        $result | Should -Not -BeNullOrEmpty
        $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

        Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItem -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1
    }

    It "Should fail when Property is empty" {
        { Get-EntraBetaDeletedDirectoryObject -DirectoryObjectId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaDeletedDirectoryObject"
        $result = Get-EntraBetaDeletedDirectoryObject -DirectoryObjectId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty    
        Should -Invoke -CommandName Get-MgBetaDirectoryDeletedItem -ModuleName Microsoft.Entra.Beta.DirectoryManagement -Times 1 -ParameterFilter {
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
            { Get-EntraBetaDeletedDirectoryObject -DirectoryObjectId  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
        }
        finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}