# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Beta.Authentication)){
    Import-Module Microsoft.Graph.Entra.Beta.Authentication -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Beta.Applications)){
    Import-Module Microsoft.Graph.Entra.Beta.Applications -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Beta.DirectoryManagement)){
    Import-Module Microsoft.Graph.Entra.Beta.DirectoryManagement -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Beta.Governance)){
    Import-Module Microsoft.Graph.Entra.Beta.Governance -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Beta.Users)){
    Import-Module Microsoft.Graph.Entra.Beta.Users -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Beta.Groups)){
    Import-Module Microsoft.Graph.Entra.Beta.Groups -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Beta.Reports)){
    Import-Module Microsoft.Graph.Entra.Beta.Reports -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Beta.SignIns)){
    Import-Module Microsoft.Graph.Entra.Beta.SignIns -Force
}

Import-Module Pester

#$psmPath = (Get-Module Microsoft.Graph.Entra.Beta).Path
$ps1FilesPath = join-path $psscriptroot "..\..\moduleVNext\EntraBeta\Microsoft.Graph.Entra"
$testReportPath = join-path $psscriptroot "..\..\TestReport\EntraBeta"
$mockScriptsPath = join-path $psscriptroot "..\..\testVNext\EntraBeta\*\*.Tests.ps1"

$testOutputFile = "$testReportPath\TestResults.xml"
if (!(test-path -path $testReportPath)) {new-item -path $testReportPath -itemtype directory}

$mockScripts = Get-ChildItem -Path $mockScriptsPath -Exclude "EntraBeta.Tests.ps1" | ForEach-Object { $_.FullName }

$config = New-PesterConfiguration
$config.Run.Path = $mockScripts
$config.Run.PassThru = $true
$config.Run.Exit = $true
$config.CodeCoverage.Enabled = $false
$config.CodeCoverage.CoveragePercentTarget = 100
# $config.CodeCoverage.Path = $psmPath
$config.CodeCoverage.Path = $ps1FilesPath
$config.TestResult.Enabled = $true
$config.TestResult.OutputPath = $testOutputFile
$config.Output.Verbosity = "Detailed"

Invoke-Pester -Configuration $config