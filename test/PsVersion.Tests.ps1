Describe 'PowerShell Version Check' {
    It 'Version 5.1 or Greater' {
        $semanticVersion = $PSVersionTable.PSVersion
        $version = $semanticVersion.Major + ($semanticVersion.Minor * 0.1)
        $version | Should -BeGreaterOrEqual 5.1
    }
}