# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

# This class builds the submodules i.e. generate the .psm1 file, help-xml and .psd1 file
class EntraModuleBuilder {
    [string]$headerText

    EntraModuleBuilder() {
        $this.headerText = @"
# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved. 
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
Set-StrictMode -Version 5 
"@

    $this.BasePath = (join-path $PSScriptRoot '../module/Entra/') 
    $this.OutputDirectory = (join-path $PSScriptRoot '../bin/') 
    }

    [string] ResolveStartDirectory([string]$directory) {
        return Resolve-Path -Path $directory
    }

    [bool] CheckTypedefsFile([string]$typedefsFilePath) {
        if (-not (Test-Path -Path $typedefsFilePath)) {
            Write-Host "[EntraModuleBuilder] Error: Typedefs.txt file not found at $typedefsFilePath" -ForegroundColor Red
            return $false
        } else {
            Write-Host "[EntraModuleBuilder] Typedefs.txt found at $typedefsFilePath" -ForegroundColor Cyan
            return $true
        }
    }

    [void] EnsureDestinationDirectory([string]$destDirectory) {
        if (-not (Test-Path -Path $destDirectory)) {
            New-Item -ItemType Directory -Path $destDirectory | Out-Null
            Write-Host "[EntraModuleBuilder] Created destination directory: $destDirectory" -ForegroundColor Green
        }
    }

    [string[]] RemoveHeader([string[]]$content) {
        $inHeader = $false
        $filteredContent = @()

        foreach ($line in $content) {
            $trimmedLine = $line.Trim()

            if ($trimmedLine -eq '# ------------------------------------------------------------------------------') {
                $inHeader = -not $inHeader
                continue
            }

            if (-not $inHeader) {
                $filteredContent += $line
            }
        }

        return $filteredContent
    }

    [void] ProcessSubDirectory([string]$currentDirPath, [string]$currentDirName, [string]$parentDirName, [string]$destDirectory, [string]$typedefsFilePath) {
        Write-Host "[EntraModuleBuilder] Processing directory: $currentDirPath" -ForegroundColor Yellow

        $psm1FileName = "$parentDirName.$currentDirName.psm1"
        $psm1FilePath = Join-Path -Path $destDirectory -ChildPath $psm1FileName

        Write-Host "[EntraModuleBuilder] Creating .psm1 file: $psm1FilePath" -ForegroundColor Green

        $psm1Content = $this.headerText + "`n"  # Add a newline after the header
        $ps1Files = Get-ChildItem -Path $currentDirPath -Filter "*.ps1"

        if ($ps1Files.Count -eq 0) {
            Write-Host "[EntraModuleBuilder] Warning: No .ps1 files found in directory $currentDirPath" -ForegroundColor Yellow
        }

        $enableEntraFiles = @()
        $otherFiles = @()

        foreach ($ps1File in $ps1Files) {
            if ($ps1File.Name -like "Enable-Entra*") {
                $enableEntraFiles += $ps1File
            } else {
                $otherFiles += $ps1File
            }
        }

        foreach ($ps1File in $otherFiles) {
            Write-Host "[EntraModuleBuilder] Appending content from file: $($ps1File.Name)" -ForegroundColor Cyan
            $fileContent = Get-Content -Path $ps1File.FullName
            $cleanedContent = $this.RemoveHeader($fileContent)
            $psm1Content += $cleanedContent -join "`n"
        }

        foreach ($ps1File in $enableEntraFiles) {
            Write-Host "[EntraModuleBuilder] Appending content from file: $($ps1File.Name)" -ForegroundColor Cyan
            $fileContent = Get-Content -Path $ps1File.FullName
            $cleanedContent = $this.RemoveHeader($fileContent)
            $psm1Content += $cleanedContent -join "`n"
        }

        Write-Host "[EntraModuleBuilder] Appending content from Typedefs.txt" -ForegroundColor Cyan
        $typedefsContent = Get-Content -Path $typedefsFilePath -Raw
        $psm1Content += "`n# Typedefs`n" + $typedefsContent

        Write-Host "[EntraModuleBuilder] Writing .psm1 file to disk: $psm1FilePath" -ForegroundColor Green
        Set-Content -Path $psm1FilePath -Value $psm1Content

        Write-Host "[EntraModuleBuilder] Module file created: $psm1FilePath" -ForegroundColor Green
    }

    [void] CreateSubModuleFile([string]$startDirectory, [string]$typedefsFilePath) {
        Write-Host "[EntraModuleBuilder] Starting CreateSubModuleFile script..." -ForegroundColor Green

        $resolvedStartDirectory = $this.ResolveStartDirectory($startDirectory)

        if (-not ($this.CheckTypedefsFile($typedefsFilePath))) {
            return
        }

        if (-not (Test-Path -Path $resolvedStartDirectory)) {
            Write-Host "[EntraModuleBuilder] Error: Start directory not found: $resolvedStartDirectory" -ForegroundColor Red
            return
        } else {
            Write-Host "[EntraModuleBuilder] Processing directories inside: $resolvedStartDirectory" -ForegroundColor Cyan
        }

        $subDirectories = Get-ChildItem -Path $resolvedStartDirectory -Directory

        $parentDirPath = Get-Item $resolvedStartDirectory
        $parentDirName = $parentDirPath.Name

        $destDirectory = Join-Path -Path (Get-Location) -ChildPath "..\bin\"
        $this.EnsureDestinationDirectory($destDirectory)

        foreach ($subDir in $subDirectories) {
            $this.ProcessSubDirectory($subDir.FullName, $subDir.Name, $parentDirName, $destDirectory, $typedefsFilePath)
        }

        Write-Host "[EntraModuleBuilder] CreateSubModuleFile script completed." -ForegroundColor Green
    }

    [void] WriteModuleManifest($module) {
    # Get all subdirectories in the base path
    $BasePath=$this.BasePath
    $OutputFolder=$this.outputDirectory

    $subDirectories = Get-ChildItem -Path $BasePath -Directory
    $settingPath = "../module/"+$module+"/config/ModuleMetadata.json"
    foreach ($subDir in $subDirectories) {
        # Define module name based on sub-directory name
        $moduleName = $subDir.Name

        # Log the start of processing for this module
        Write-Host "[EntraModuleBuilder] Processing module: $moduleName" -ForegroundColor Blue

        # Update paths specific to this sub-directory
       
        $files = @("$moduleName.psd1", "$moduleName.psm1", "$moduleName-Help.xml")
        $content = Get-Content -Path $settingPath | ConvertFrom-Json

        # Define PSData block based on the contents of the ModuleMetadata.json file
        $PSData = @{
            Tags = $($content.tags)
            LicenseUri = $($content.licenseUri)
            ProjectUri = $($content.projectUri)
            IconUri = $($content.iconUri)
            ReleaseNotes = $($content.releaseNotes)
            Prerelease = $null
        }

        # Set the manifest path and functions to export
        $manifestPath = Join-Path $OutputFolder "$moduleName.psd1"
        $functions = $this.ModuleMap.CommandsList + "Enable-EntraAzureADAlias" + "Get-EntraUnsupportedCommand"
        
        # Collect required modules
        $requiredModules = @()
        foreach ($module in $content.requiredModules) {
            $requiredModules += @{ModuleName = $module; RequiredVersion = $content.requiredModulesVersion}
        }

        # Module manifest settings
        $moduleSettings = @{
            Path = $manifestPath
            GUID = $($content.guid)
            ModuleVersion = "$($content.version)"
            FunctionsToExport = $functions
            CmdletsToExport = @()
            AliasesToExport = @()
            Author = $($content.authors)
            CompanyName = $($content.owners)
            FileList = $files
            RootModule = "$moduleName.psm1"
            Description = 'Microsoft Graph Entra PowerShell.'
            DotNetFrameworkVersion = $([System.Version]::Parse('4.7.2'))
            PowerShellVersion = $([System.Version]::Parse('5.1'))
            CompatiblePSEditions = @('Desktop', 'Core')
            RequiredModules = $requiredModules
            NestedModules = @()
        }

        # Add prerelease info if it exists
        if ($null -ne $content.Prerelease) {
            $PSData.Prerelease = $content.Prerelease
        }

        # Update any load message for this module if necessary
        $this.LoadMessage = $this.LoadMessage.Replace("{VERSION}", $content.version)

        # Create and update the module manifest
        Write-Host "[EntraModuleBuilder] Creating manifest for $moduleName at $manifestPath" -ForegroundColor Green
        New-ModuleManifest @moduleSettings
        Update-ModuleManifest -Path $manifestPath -PrivateData $PSData

        # Log completion for this module
        Write-Host "[EntraModuleBuilder] Manifest for $moduleName created successfully" -ForegroundColor Green
    }
}



}

