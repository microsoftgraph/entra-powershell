# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Authentication)){
    Import-Module .\bin\Microsoft.Graph.Entra.Authentication.psd1 -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Applications)){
    Import-Module .\bin\Microsoft.Graph.Entra.Applications.psd1 -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.DirectoryManagement)){
    Import-Module .\bin\Microsoft.Graph.Entra.DirectoryManagement.psd1 -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Governance)){
    Import-Module .\bin\Microsoft.Graph.Entra.Governance.psd1 -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Users)){
    Import-Module .\bin\Microsoft.Graph.Entra.Users.psd1 -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Groups)){
    Import-Module .\bin\Microsoft.Graph.Entra.Groups.psd1 -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.Reports)){
    Import-Module .\bin\Microsoft.Graph.Entra.Reports.psd1 -Force
}
if($null -eq (Get-Module -Name Microsoft.Graph.Entra.SignIns)){
    Import-Module .\bin\Microsoft.Graph.Entra.SignIns.psd1 -Force
}

Import-Module Pester

#$psmPath = (Get-Module Microsoft.Graph.Entra.Applications).Path
$ps1FilesPath = join-path $psscriptroot "..\..\moduleVNext\Entra\Microsoft.Graph.Entra"
$testReportPath = join-path $psscriptroot "..\..\TestReport\Entra"
$mockScriptsPath = join-path $psscriptroot "..\..\testVNext\Entra\*\*.Tests.ps1"

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