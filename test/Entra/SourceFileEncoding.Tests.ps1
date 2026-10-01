# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

# Regression guard for issue #1603.
#
# The module .psm1 files are assembled by concatenating the per-cmdlet .ps1 source
# files under module/. When a source file contains non-ASCII characters (for example
# the arrow "->", an em dash, or a check mark) and is saved without a UTF-8 BOM,
# Windows PowerShell 5.1 decodes the bytes using the system ANSI code page instead of
# UTF-8. The mis-decoded multi-byte characters turn into stray quote characters that
# unbalance the surrounding strings, so Import-Module fails with parser errors such as
# "Missing closing ')' in expression" and "The string is missing the terminator".
#
# PowerShell 7 (Core) reads BOM-less files as UTF-8, which is why the CI test runs and
# every day-to-day PowerShell 7 user import the module without error while the module
# is broken on Windows PowerShell 5.1. Keeping the shipped source ASCII-only makes the
# generated .psm1 parse identically under every encoding.

Describe "Module source file encoding (Windows PowerShell 5.1 import safety)" {
    BeforeDiscovery {
        $moduleRoot = Join-Path $PSScriptRoot '..' '..' 'module'
        $script:SourceFileCases = @()
        if (Test-Path -Path $moduleRoot) {
            $script:SourceFileCases = Get-ChildItem -Path $moduleRoot -Recurse -Filter '*.ps1' -File |
                ForEach-Object { @{ FullName = $_.FullName; Name = $_.Name } }
        }
    }

    It "Should resolve the module source directory" {
        (Join-Path $PSScriptRoot '..' '..' 'module') | Should -Exist
    }

    It "Should discover module source files to validate" {
        $moduleRoot = Join-Path $PSScriptRoot '..' '..' 'module'
        @(Get-ChildItem -Path $moduleRoot -Recurse -Filter '*.ps1' -File).Count | Should -BeGreaterThan 0
    }

    It "'<Name>' should not contain non-ASCII characters" -ForEach $script:SourceFileCases {
        $bytes = [System.IO.File]::ReadAllBytes($FullName)
        $nonAsciiCount = @($bytes | Where-Object { $_ -gt 0x7F }).Count
        $nonAsciiCount | Should -Be 0 -Because "$Name must be ASCII-only so Windows PowerShell 5.1 imports the module regardless of a BOM (issue #1603)"
    }
}
