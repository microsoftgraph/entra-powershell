Import-Module Pester

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
#$config.Output.Verbosity = "Detailed"

Invoke-Pester -Configuration $config

# $results = Invoke-Pester -Script $mockScripts -EnableExit -OutputFile $testOutputFile -OutputFormat NUnitXml -PassThru -CodeCoverage .\bin\Microsoft.Graph.Entra.psm1

.\reportgenerator\ReportUnit.exe "$testOutputFile"

# $results.CodeCoverage.HitCommands | ConvertTo-Html | Out-File -FilePath "$PSScriptRoot\artifacts\HitCommands.html"
# if($results.CodeCoverage.MissedCommands -ne $null){ $results.CodeCoverage.MissedCommands | ConvertTo-Html | Out-File -FilePath "$PSScriptRoot\artifacts\MissedCommands.html"}
# $results.CodeCoverage.AnalyzedFiles | Out-File -FilePath "$PSScriptRoot\artifacts\AnalyzedFiles.txt"

# $Percentage = ($results.CodeCoverage.NumberOfCommandsExecuted / $results.CodeCoverage.NumberOfCommandsAnalyzed)*100
# $results.CodeCoverage | Add-Member Percentage ($Percentage | % { '{0:0.##}' -f $_ })
# $results.CodeCoverage | ConvertTo-Html  | Out-File -FilePath "$PSScriptRoot\artifacts\CoverageReport.html"