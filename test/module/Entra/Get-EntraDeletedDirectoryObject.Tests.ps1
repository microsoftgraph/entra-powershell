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
                "Id"                   = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
                "AdditionalProperties" = @{DisplayName="Test-App";}
                "DeletedDateTime"      = "2/2/2024 5:33:56 AM"
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName Get-MgDirectoryDeletedItem -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraDeletedDirectoryObject"{
    It "Should fail when Id is empty" {
        { Get-EntraDeletedDirectoryObject -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id'*"
    }
    It "Should fail when Id is null" {
        { Get-EntraDeletedDirectoryObject -Id  } | Should -Throw "Missing an argument for parameter 'Id'*"
    }
    It "Should fail when invalid parameter is passed" {
        { Get-EntraDeletedDirectoryObject -DisplayName "abc" } | Should -Throw "A parameter cannot be found that matches parameter name 'DisplayName'*"
    }
    It "Result should Contain ObjectId" {
        $result = Get-EntraDeletedDirectoryObject -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result.ObjectId | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
    }
    It "Should contain DirectoryObjectId in parameters when passed Id to it" {              
        $result = Get-EntraDeletedDirectoryObject -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $params = Get-Parameters -data $result.Parameters
        $params.DirectoryObjectId | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
    }
    It "Property parameter should work" {
        $result = Get-EntraDeletedDirectoryObject -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -Property Id 
        $result | Should -Not -BeNullOrEmpty
        $result.Id | Should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"

        Should -Invoke -CommandName Get-MgDirectoryDeletedItem -ModuleName Microsoft.Graph.Entra -Times 1
    }

    It "Should fail when Property is empty" {
         {Get-EntraDeletedDirectoryObject -Id "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"  -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedDirectoryObject"
        $result =  Get-EntraDeletedDirectoryObject -Id  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
        $result | Should -Not -BeNullOrEmpty
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeletedDirectoryObject"    
        Should -Invoke -CommandName Get-MgDirectoryDeletedItem -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
            { Get-EntraDeletedDirectoryObject -Id  "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -Debug } | Should -Not -Throw
        } finally {
            # Restore original confirmation preference            
            $DebugPreference = $originalDebugPreference        
        }
    } 
}