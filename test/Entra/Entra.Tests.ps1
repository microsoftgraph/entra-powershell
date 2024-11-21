# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

if($null -eq (Get-Module -Name Microsoft.Entra.Authentication)){
    Import-Module Microsoft.Entra.Authentication -Force
}
if($null -eq (Get-Module -Name Microsoft.Entra.Applications)){
    Import-Module Microsoft.Entra.Applications -Force
}
if($null -eq (Get-Module -Name Microsoft.Entra.DirectoryManagement)){
    Import-Module Microsoft.Entra.DirectoryManagement -Force
}
if($null -eq (Get-Module -Name Microsoft.Entra.Governance)){
    Import-Module Microsoft.Entra.Governance -Force
}
if($null -eq (Get-Module -Name Microsoft.Entra.Users)){
    Import-Module Microsoft.Entra.Users -Force
}
if($null -eq (Get-Module -Name Microsoft.Entra.Groups)){
    Import-Module Microsoft.Entra.Groups -Force
}
if($null -eq (Get-Module -Name Microsoft.Entra.Reports)){
    Import-Module Microsoft.Entra.Reports -Force
}
if($null -eq (Get-Module -Name Microsoft.Entra.SignIns)){
    Import-Module Microsoft.Entra.SignIns -Force
}

Import-Module Pester

#$psmPath = (Get-Module Microsoft.Entra.Applications).Path
$ps1FilesPath = join-path $psscriptroot "..\..\module\Entra\Microsoft.Entra"
$testReportPath = join-path $psscriptroot "..\..\TestReport\Entra"
$mockScriptsPath = join-path $psscriptroot "..\..\test\Entra\*\*.Tests.ps1"

$testOutputFile = "$testReportPath\TestResults.xml"
if (!(test-path -path $testReportPath)) {new-item -path $testReportPath -itemtype directory}

$mockScripts = Get-ChildItem -Path $mockScriptsPath -Exclude "Entra.Tests.ps1" | ForEach-Object { $_.FullName }

$config = New-PesterConfiguration
$config.Run.Path = $mockScripts
$config.Run.PassThru = $true
$config.Run.Exit = $true
$config.CodeCoverage.Enabled = $true
$config.CodeCoverage.CoveragePercentTarget = 100
#$config.CodeCoverage.Path = $psmPath
$config.CodeCoverage.Path = $ps1FilesPath
$config.TestResult.Enabled = $true
$config.TestResult.OutputPath = $testOutputFile
$config.Output.Verbosity = "Detailed"

Invoke-Pester -Configuration $config