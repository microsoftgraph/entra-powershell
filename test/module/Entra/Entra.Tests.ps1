Import-Module Pester
Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force

$testOutputFile = ".\TestReport\Entra\TestResults.xml"

$reportFolder = ".\TestReport\Entra"
if (!(test-path -path $reportFolder)) {new-item -path $reportFolder -itemtype directory}

$mockScripts = Get-ChildItem -Path ".\test\module\Entra\Mock-*.Tests.ps1" | ForEach-Object { $_.FullName }

$config = New-PesterConfiguration
$config.Run.Path = $mockScripts
$config.Run.PassThru = $true
$config.Run.Exit = $true
$config.CodeCoverage.Enabled = $true
$config.CodeCoverage.CoveragePercentTarget = 100
$config.CodeCoverage.Path = @('.\bin\Microsoft.Graph.Entra.psm1')
$config.TestResult.Enabled = $true
$config.TestResult.OutputPath = $testOutputFile
$config.Output.Verbosity = "Detailed"

Invoke-Pester -Configuration $config

.\reportgenerator\ReportUnit.exe "$testOutputFile"