BeforeAll {
    Import-Module Microsoft.Graph.Compatibility.AzureAD
}

Describe 'PowerShell Version Check' {
    It 'Version 5.1 or Greater' {
        $semanticVersion = $PSVersionTable.PSVersion
        $version = $semanticVersion.Major + ($semanticVersion.Minor * 0.1)
        $version | Should -BeGreaterOrEqual 5.1
    }
}

Describe 'Module checks' {
    It 'Import Module' {                
        $module = Get-Module -Name Microsoft.Graph.Compatibility.AzureAD
        $module | Should -Not -Be $null
    }

    It 'Have more that zero exported functions' {
        $module.ExportedFunctions.Count | Should -BeGreaterThan 0
    }
}