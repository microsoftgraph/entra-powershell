# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
}

Describe 'PowerShell Version Check' {
    It 'Version 5.1 or Greater' {
        $semanticVersion = $PSVersionTable.PSVersion
        $version = $semanticVersion.Major + ($semanticVersion.Minor * 0.1)
        $version | Should -BeGreaterOrEqual 5.1
    }
}

Describe 'Module checks' {
    It 'Module imported' {                
        $module = Get-Module -Name Microsoft.Graph.Entra
        $module | Should -Not -Be $null
    }

    It 'Have more that zero exported functions' {
        $module = Get-Module -Name Microsoft.Graph.Entra
        $module.ExportedCommands.Keys.Count | Should -BeGreaterThan 0
    }

    # It 'Known number translated commands' {
    #     $module = Get-Module -Name Microsoft.Graph.Entra
    #     $module.ExportedCommands.Keys.Count | Should -Be 222
    # }

    It 'Running a simple command Enable-EntraAzureADAlias'{
        Enable-EntraAzureADAlias
        $Alias = Get-Alias -Name Get-AzureADUser
        $Alias | Should -Not -Be $null
    }
}