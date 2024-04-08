Import-Module Pester

$testOutputFile = ".\TestReport\EntraBeta\TestResults.xml"

$reportFolder = ".\TestReport\EntraBeta"
if (!(test-path -path $reportFolder)) {new-item -path $reportFolder -itemtype directory}

$mockScripts = Get-ChildItem -Path ".\test\module\EntraBeta\Mock-*.Tests.ps1" | ForEach-Object { $_.FullName }

$config = New-PesterConfiguration
$config.Run.Path = $mockScripts
$config.Run.PassThru = $true
$config.Run.Exit = $true
$config.CodeCoverage.Enabled = $true
$config.CodeCoverage.CoveragePercentTarget = 100
$config.CodeCoverage.Path = @('.\bin\Microsoft.Graph.Entra.Beta.psm1')
$config.TestResult.Enabled = $true
$config.TestResult.OutputPath = $testOutputFile

Invoke-Pester -Configuration $config

.\reportgenerator\ReportUnit.exe "$testOutputFile"