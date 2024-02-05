# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Describe "Microsoft.Graph.Entra Module" {
    Context "On module import" {
        BeforeAll {
            if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
                Import-Module Microsoft.Graph.Entra
            }
        }

        It "Should have exported commands" {
            $PSModuleInfo = Get-Module Microsoft.Graph.Entra
            $PSModuleInfo | Should -Not -BeNullOrEmpty
            $PSModuleInfo.ExportedFunctions.Count | Should -Not -Be 0

        }

        It 'Should be compatible with PS core and desktop' {
            $PSModuleInfo = Get-Module Microsoft.Graph.Entra
            $PSModuleInfo.CompatiblePSEditions | Should -BeIn @("Core", "Desktop")
        }

        It 'Should point to script module' {
            $PSModuleInfo = Get-Module Microsoft.Graph.Entra
            $PSModuleInfo.RootModule | Should -BeLikeExactly "*Microsoft.Graph.Entra.psm1"
        }

        It 'Should lock GUID' {
            $PSModuleInfo = Get-Module Microsoft.Graph.Entra
            $PSModuleInfo.Guid | Should -Be "742dccd1-bf4b-46a0-a3f2-14e0bb508233"
        }

        It "Module import should not write to error and information streams" {
            $ps = [powershell]::Create()
            $ps.AddScript("Import-Module Microsoft.Graph.Entra -ErrorAction SilentlyContinue").Invoke()
            "Checking Information stream" | Out-Host
            $ps.Streams.Information.Count | Should -Be 0
            "Checking Error stream" | Out-Host
            $ps.Streams.Error.Count | Should -Be 0
            "Checking Verbose stream" | Out-Host
            $ps.Streams.Verbose.Count | Should -Be 0
            "Checking Debug stream" | Out-Host
            $ps.Streams.Warning.Count | Should -Be 0
            "Checking Progress stream" | Out-Host
            $ps.Streams.Progress.Count | Should -Be 0

            $ps.Dispose()
        }
    }
}
