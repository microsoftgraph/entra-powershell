# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<#
.SYNOPSIS
    Tests that all Entra modules can be successfully imported in PowerShell 5.1 and PowerShell 7+.

.DESCRIPTION
    This test validates cross-version compatibility by attempting to import each Entra module in both
    PowerShell 5.1 (Windows PowerShell) and PowerShell 7+ (PowerShell Core).
    
    This ensures modules work correctly across both environments, which is critical since:
    - PowerShell 5.1 has stricter parsing rules and different encoding handling
    - PowerShell 7+ is more lenient but is the recommended modern version
    
.NOTES
    PowerShell 5.1 is End of Life as of January 2024 but still widely used in enterprise environments.
#>

BeforeAll {
    $script:BinPath = Join-Path $PSScriptRoot '..' '..' 'bin'
    
    # Get all Entra module files (excluding Beta modules)
    $script:EntraModules = Get-ChildItem -Path $script:BinPath -Filter 'Microsoft.Entra.*.psm1' -File |
        Where-Object { $_.Name -notlike 'Microsoft.Entra.Beta.*' } |
        Select-Object -ExpandProperty FullName
    
    $script:AllModules = $script:EntraModules
    
    # Detect PowerShell version
    $script:CurrentPSVersion = $PSVersionTable.PSVersion.Major
    
    # Check if PowerShell 5.1 is available (Windows only)
    $script:PS51Available = $false
    if ($IsWindows -or $PSVersionTable.PSVersion.Major -eq 5) {
        try {
            $ps51Test = powershell.exe -Version 5.1 -Command '$PSVersionTable.PSVersion.Major' 2>&1
            if ($ps51Test -eq 5) {
                $script:PS51Available = $true
            }
        }
        catch {
            Write-Warning "PowerShell 5.1 not available for testing: $($_.Exception.Message)"
        }
    }
    
    # Function to test module import in current session
    function Test-ModuleImportCurrent {
        param([string]$ModulePath)
        
        try {
            # Suppress Add-Type errors (types already exist from previous imports)
            Import-Module $ModulePath -Force -ErrorAction Stop -WarningAction SilentlyContinue 2>$null
            Remove-Module (Get-Item $ModulePath).BaseName -Force -ErrorAction SilentlyContinue
            return $true
        }
        catch {
            return $_.Exception.Message
        }
    }
    
    # Function to test module import in PowerShell 5.1
    function Test-ModuleImportPS51 {
        param([string]$ModulePath)
        
        $command = @"
try {
    Import-Module '$ModulePath' -Force -ErrorAction Stop
    Remove-Module '$((Get-Item $ModulePath).BaseName)' -Force -ErrorAction SilentlyContinue
    Write-Output 'SUCCESS'
}
catch {
    Write-Output `$_.Exception.Message
}
"@
        
        try {
            $result = powershell.exe -Version 5.1 -Command $command 2>&1 | Out-String
            if ($result -match 'SUCCESS') {
                return $true
            }
            else {
                return $result.Trim()
            }
        }
        catch {
            return $_.Exception.Message
        }
    }
}

Describe "Entra Module Compatibility Tests" {
    
    Context "Module Discovery" {
        It "Should find Entra modules in bin directory" {
            $script:EntraModules | Should -Not -BeNullOrEmpty
            $script:EntraModules.Count | Should -BeGreaterThan 0
        }
        
        It "Should find expected number of Entra modules" {
            # Expected: 8 Entra modules (excluding Beta modules)
            $script:AllModules.Count | Should -BeGreaterThan 5
            Write-Host "  Found $($script:AllModules.Count) Entra modules" -ForegroundColor Cyan
        }
    }
    
    Context "Current PowerShell Version Compatibility (PS $($script:CurrentPSVersion))" {
        
        BeforeEach {
            # Clean up any previously loaded modules
            Get-Module Microsoft.Entra.* | Remove-Module -Force -ErrorAction SilentlyContinue
        }
        
        It "Should successfully import all Entra modules in current PowerShell version" {
            $failures = @()
            $successes = 0
            
            # Suppress Add-Type errors by redirecting stderr
            $ErrorActionPreference = 'Continue'
            
            foreach ($modulePath in $script:AllModules) {
                $moduleName = (Get-Item $modulePath).BaseName
                $result = Test-ModuleImportCurrent -ModulePath $modulePath
                
                if ($result -eq $true) {
                    $successes++
                    Write-Host "  ✓ $moduleName" -ForegroundColor Green
                }
                else {
                    $failures += @{
                        Module = $moduleName
                        Error = $result
                    }
                    Write-Host "  ✗ $moduleName" -ForegroundColor Red
                    Write-Host "    Error: $result" -ForegroundColor Red
                }
            }
            
            Write-Host ""
            Write-Host "  Results: $successes/$($script:AllModules.Count) modules imported successfully" -ForegroundColor $(if ($failures.Count -eq 0) { 'Green' } else { 'Yellow' })
            
            if ($failures.Count -gt 0) {
                $failureMessage = "Failed to import $($failures.Count) module(s):`n"
                foreach ($failure in $failures) {
                    $failureMessage += "  - $($failure.Module): $($failure.Error)`n"
                }
                throw $failureMessage
            }
            
            $failures.Count | Should -Be 0
        }
    }
    
    Context "PowerShell 5.1 Compatibility" {
        
        BeforeAll {
            if (-not $script:PS51Available) {
                Write-Host "  PowerShell 5.1 is not available on this system. PS 5.1 tests will be skipped." -ForegroundColor Yellow
            }
        }
        
        It "Should have PowerShell 5.1 available for testing" {
            if (-not $script:PS51Available) {
                Set-ItResult -Skipped -Because "PowerShell 5.1 is not available on this system"
            }
            $script:PS51Available | Should -Be $true
        }
        
        It "Should successfully import all Entra modules in PowerShell 5.1" {
            if (-not $script:PS51Available) {
                Set-ItResult -Skipped -Because "PowerShell 5.1 is not available on this system"
            }
            $failures = @()
            $successes = 0
            
            Write-Host "  Testing module imports in PowerShell 5.1..." -ForegroundColor Cyan
            
            foreach ($modulePath in $script:AllModules) {
                $moduleName = (Get-Item $modulePath).BaseName
                Write-Host "  Testing $moduleName..." -ForegroundColor Gray -NoNewline
                
                $result = Test-ModuleImportPS51 -ModulePath $modulePath
                
                if ($result -eq $true) {
                    $successes++
                    Write-Host " ✓" -ForegroundColor Green
                }
                else {
                    $failures += @{
                        Module = $moduleName
                        Error = $result
                    }
                    Write-Host " ✗" -ForegroundColor Red
                    Write-Host "    Error: $result" -ForegroundColor Red
                }
            }
            
            Write-Host ""
            Write-Host "  Results: $successes/$($script:AllModules.Count) modules imported successfully in PS 5.1" -ForegroundColor $(if ($failures.Count -eq 0) { 'Green' } else { 'Yellow' })
            
            if ($failures.Count -gt 0) {
                $failureMessage = "Failed to import $($failures.Count) module(s) in PS 5.1:`n"
                foreach ($failure in $failures) {
                    $failureMessage += "  - $($failure.Module): $($failure.Error)`n"
                }
                throw $failureMessage
            }
            
            $failures.Count | Should -Be 0
        }
    }
    
    Context "Module Metadata Validation" {
        
        It "Should validate all module manifest files exist" {
            $failures = @()
            $successes = 0
            
            foreach ($modulePath in $script:AllModules) {
                $moduleName = (Get-Item $modulePath).BaseName
                $manifestPath = $modulePath -replace '\.psm1$', '.psd1'
                
                if (-not (Test-Path $manifestPath)) {
                    $failures += @{
                        Module = $moduleName
                        Error = "Manifest file not found: $manifestPath"
                    }
                    Write-Host "  ✗ $moduleName - Missing manifest" -ForegroundColor Red
                }
                else {
                    $successes++
                    Write-Host "  ✓ $moduleName" -ForegroundColor Green
                }
            }
            
            Write-Host ""
            Write-Host "  Results: $successes/$($script:AllModules.Count) manifests exist" -ForegroundColor $(if ($failures.Count -eq 0) { 'Green' } else { 'Yellow' })
            
            if ($failures.Count -gt 0) {
                $failureMessage = "Failed to find $($failures.Count) manifest(s):`n"
                foreach ($failure in $failures) {
                    $failureMessage += "  - $($failure.Module): $($failure.Error)`n"
                }
                throw $failureMessage
            }
            
            $failures.Count | Should -Be 0
        }
        
        It "Should validate all module manifests can be parsed" {
            $failures = @()
            $successes = 0
            $warnings = @()
            
            foreach ($modulePath in $script:AllModules) {
                $moduleName = (Get-Item $modulePath).BaseName
                $manifestPath = $modulePath -replace '\.psm1$', '.psd1'
                
                if (-not (Test-Path $manifestPath)) {
                    continue
                }
                
                try {
                    # Test-ModuleManifest with ErrorAction Stop but allow warnings
                    $manifest = Test-ModuleManifest -Path $manifestPath -ErrorAction Stop -WarningAction SilentlyContinue -WarningVariable manifestWarnings
                    
                    # Check if warnings are about missing help files (non-critical)
                    $criticalError = $false
                    foreach ($warning in $manifestWarnings) {
                        if ($warning -match 'Help\.xml.*invalid') {
                            # Help file warnings are non-critical, track but don't fail
                            $warnings += @{
                                Module = $moduleName
                                Warning = $warning
                            }
                        }
                        else {
                            $criticalError = $true
                            break
                        }
                    }
                    
                    if (-not $criticalError) {
                        $successes++
                        Write-Host "  ✓ $moduleName" -ForegroundColor Green
                        if ($manifestWarnings.Count -gt 0) {
                            Write-Host "    Note: Missing help file (non-critical)" -ForegroundColor Gray
                        }
                    }
                    else {
                        $failures += @{
                            Module = $moduleName
                            Error = "Manifest has critical validation errors"
                        }
                        Write-Host "  ✗ $moduleName - Critical manifest errors" -ForegroundColor Red
                    }
                }
                catch {
                    # Only fail on actual parse errors, not help file issues
                    if ($_.Exception.Message -notmatch 'FileList.*Help\.xml') {
                        $failures += @{
                            Module = $moduleName
                            Error = $_.Exception.Message
                        }
                        Write-Host "  ✗ $moduleName - Cannot parse manifest" -ForegroundColor Red
                        Write-Host "    Error: $($_.Exception.Message)" -ForegroundColor Red
                    }
                    else {
                        # Help file issue - non-critical
                        $successes++
                        Write-Host "  ✓ $moduleName" -ForegroundColor Green
                        Write-Host "    Note: Missing help file (non-critical)" -ForegroundColor Gray
                        $warnings += @{
                            Module = $moduleName
                            Warning = "Missing help file"
                        }
                    }
                }
            }
            
            Write-Host ""
            Write-Host "  Results: $successes/$($script:AllModules.Count) manifests parsed successfully" -ForegroundColor $(if ($failures.Count -eq 0) { 'Green' } else { 'Yellow' })
            if ($warnings.Count -gt 0) {
                Write-Host "  Note: $($warnings.Count) module(s) have missing help files (non-critical)" -ForegroundColor Gray
            }
            
            if ($failures.Count -gt 0) {
                $failureMessage = "Failed to parse $($failures.Count) manifest(s):`n"
                foreach ($failure in $failures) {
                    $failureMessage += "  - $($failure.Module): $($failure.Error)`n"
                }
                throw $failureMessage
            }
            
            $failures.Count | Should -Be 0
        }
    }
    
    Context "Module Export Validation" {
        
        BeforeEach {
            # Clean up any previously loaded modules
            Get-Module Microsoft.Entra.* | Remove-Module -Force -ErrorAction SilentlyContinue
        }
        
        It "Should verify all Entra modules export cmdlets" {
            $failures = @()
            $successes = 0
            
            foreach ($modulePath in $script:AllModules) {
                $moduleName = (Get-Item $modulePath).BaseName
                
                try {
                    # Suppress Add-Type errors (types already exist from previous imports)
                    Import-Module $modulePath -Force -ErrorAction Stop -WarningAction SilentlyContinue 2>$null
                    $module = Get-Module $moduleName
                    
                    if ($module.ExportedCommands.Count -gt 0) {
                        $successes++
                        Write-Host "  ✓ $moduleName ($($module.ExportedCommands.Count) cmdlets)" -ForegroundColor Green
                    }
                    else {
                        $failures += @{
                            Module = $moduleName
                            Error = "Module exports 0 cmdlets"
                        }
                        Write-Host "  ✗ $moduleName - No exported cmdlets" -ForegroundColor Red
                    }
                    
                    Remove-Module $moduleName -Force -ErrorAction SilentlyContinue
                }
                catch {
                    $failures += @{
                        Module = $moduleName
                        Error = $_.Exception.Message
                    }
                    Write-Host "  ✗ $moduleName - Failed to load" -ForegroundColor Red
                }
            }
            
            Write-Host ""
            Write-Host "  Results: $successes/$($script:AllModules.Count) modules export cmdlets" -ForegroundColor $(if ($failures.Count -eq 0) { 'Green' } else { 'Yellow' })
            
            if ($failures.Count -gt 0) {
                $failureMessage = "Failed to validate exports for $($failures.Count) module(s):`n"
                foreach ($failure in $failures) {
                    $failureMessage += "  - $($failure.Module): $($failure.Error)`n"
                }
                throw $failureMessage
            }
            
            $failures.Count | Should -Be 0
        }
    }
}

AfterAll {
    # Clean up all loaded Entra modules
    Get-Module Microsoft.Entra.* | Remove-Module -Force -ErrorAction SilentlyContinue
}
