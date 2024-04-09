$modulePath = join-path $psscriptroot "..\..\..\bin\Microsoft.Graph.Entra.psm1"
$testReportPath = join-path $psscriptroot "..\..\..\TestReport\Entra"
$mockScriptsPath = join-path $psscriptroot "..\..\..\test\module\Entra\Mock-*.Tests.ps1"


Import-Module Pester
Import-Module $modulePath -Force
#Import-Module Microsoft.Graph.Entra

$testOutputFile = "$testReportPath\TestResults.xml"
if (!(test-path -path $testReportPath)) {new-item -path $testReportPath -itemtype directory}

$mockScripts = Get-ChildItem -Path $mockScriptsPath | ForEach-Object { $_.FullName }

$config = New-PesterConfiguration
$config.Run.Path = $mockScripts
$config.Run.PassThru = $true
$config.Run.Exit = $true
$config.CodeCoverage.Enabled = $true
$config.CodeCoverage.CoveragePercentTarget = 100
$config.CodeCoverage.Path = $modulePath
$config.TestResult.Enabled = $true
$config.TestResult.OutputPath = $testOutputFile
$config.Output.Verbosity = "Detailed"

Invoke-Pester -Configuration $config

.\reportgenerator\ReportUnit.exe "$testOutputFile"