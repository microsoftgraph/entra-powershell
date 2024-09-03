# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Beta)){
    Import-Module Microsoft.Graph.Entra.Beta
}

Import-Module Pester

$psmPath = (Get-Module Microsoft.Graph.Entra.Beta).Path
$testReportPath = join-path $psscriptroot "..\..\..\TestReport\EntraBeta"
$mockScriptsPath = join-path $psscriptroot "..\..\..\test\module\EntraBeta\*.Tests.ps1"

$testOutputFile = "$testReportPath\TestResults.xml"
if (!(test-path -path $testReportPath)) {new-item -path $testReportPath -itemtype directory}

$mockScripts = Get-ChildItem -Path $mockScriptsPath -Exclude "EntraBeta.Tests.ps1" | ForEach-Object { $_.FullName }

$config = New-PesterConfiguration
$config.Run.Path = $mockScripts
$config.Run.PassThru = $true
$config.Run.Exit = $true
$config.CodeCoverage.Enabled = $false
$config.CodeCoverage.CoveragePercentTarget = 100
$config.CodeCoverage.Path = $psmPath
$config.TestResult.Enabled = $true
$config.TestResult.OutputPath = $testOutputFile
$config.Output.Verbosity = "Detailed"

Invoke-Pester -Configuration $config