if($null -eq (Get-Module -Name Microsoft.Graph.Entra)){
    Import-Module Microsoft.Graph.Entra
}

Import-Module Pester

$psmPath = (Get-Module Microsoft.Graph.Entra).Path
$testReportPath = join-path $psscriptroot "..\..\..\TestReport\Entra"
$mockScriptsPath = join-path $psscriptroot "..\..\..\test\module\Entra\Mock-*.Tests.ps1"
$reportGenPath = join-path $psscriptroot "..\..\..\reportgenerator\ReportUnit.exe"


Write-Host 'psmPath: '$psmPath
Write-Host 'testReportPath: '$testReportPath
Write-Host 'mockScriptsPath: '$mockScriptsPath
Write-Host 'reportGenPath: '$reportGenPath



$testOutputFile = "$testReportPath\TestResults.xml"
if (!(test-path -path $testReportPath)) {new-item -path $testReportPath -itemtype directory}

$mockScripts = Get-ChildItem -Path $mockScriptsPath | ForEach-Object { $_.FullName }

$config = New-PesterConfiguration
$config.Run.Path = $mockScripts
$config.Run.PassThru = $true
$config.Run.Exit = $true
$config.CodeCoverage.Enabled = $true
$config.CodeCoverage.CoveragePercentTarget = 100
$config.CodeCoverage.Path = $psmPath
$config.TestResult.Enabled = $true
$config.TestResult.OutputPath = $testOutputFile
$config.Output.Verbosity = "Detailed"

Invoke-Pester -Configuration $config

#& "$reportGenPath" "$testOutputFile"