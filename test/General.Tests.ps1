BeforeAll {
    Import-Module Microsoft.Graph.Compatibility.AzureAD
    Get-Module -Name Microsoft.Graph.Compatibility.AzureAD
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
        $module = Get-Module -Name Microsoft.Graph.Compatibility.AzureAD
        $module | Should -Not -Be $null
    }

    It 'Have more that zero exported functions' {
        $module = Get-Module -Name Microsoft.Graph.Compatibility.AzureAD
        $module.ExportedCommands.Keys.Count | Should -BeGreaterThan 0
    }

    It 'Known number translated commands' {
        $module = Get-Module -Name Microsoft.Graph.Compatibility.AzureAD
        $module.ExportedCommands.Keys.Count | Should -Be 150
    }

    It 'Known number of missing commands' {        
        $MISSING_CMDS.Count | Should -Be 79
    }

    It 'Running a simple command Set-CompatADAlias'{
        Set-CompatADAlias
        $Alias = Get-Alias -Name Get-AzureADUser
        $Alias | Should -Not -Be $null
    }
}