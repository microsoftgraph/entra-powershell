# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Describe "Microsoft.Graph.Entra Module" {
    Context "On module import" {
        BeforeAll {    
            if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
                $ModulePath = ".\bin\Microsoft.Graph.Entra.psd1"
                Import-Module $ModulePath -force
                $ModuleName = "Microsoft.Graph.Entra"
                $PSModuleInfo = Get-Module $ModuleName
                
            }
        }

        It "Should have exported commands" {
            $PSModuleInfo | Should -Not -BeNullOrEmpty
            $PSModuleInfo.ExportedFunctions.Count | Should -Not -Be 0

        }

        It 'Should be compatible with PS core and desktop' {
            $PSModuleInfo.CompatiblePSEditions | Should -BeIn @("Core", "Desktop")
        }

        It 'Should point to script module' {
            $PSModuleInfo.RootModule | Should -BeLikeExactly "*$ModuleName.psm1"
        }

        It 'Should lock GUID' {
            $PSModuleInfo.Guid | Should -Be "3f58c85c-3729-4008-a81f-3338c2556d64"
        }

        It "Module import should not write to error and information streams" {
            $ps = [powershell]::Create()
            $ps.AddScript("Import-Module $ModulePath -ErrorAction SilentlyContinue").Invoke()

            $ps.Streams.Information.Count | Should -Be 0
            $ps.Streams.Error.Count | Should -Be 0
            $ps.Streams.Verbose.Count | Should -Be 0
            $ps.Streams.Warning.Count | Should -Be 0
            $ps.Streams.Progress.Count | Should -Be 0

            $ps.Dispose()
        }
    }
}
