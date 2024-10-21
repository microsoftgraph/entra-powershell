# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

# This class splits the larger Microsoft.Graph.Entra.psm1 or Microsoft.Graph.Entra.Beta.psm1 into separate files and also constructrs the submodule directories
class EntraModuleSplitter {
    [string]$Header

    EntraModuleSplitter() {
        $this.Header = @"
# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
"@
    }

    [void] CreateOutputDirectory([string]$directoryPath) {
        if (-not (Test-Path -Path $directoryPath)) {
            New-Item -ItemType Directory -Path $directoryPath | Out-Null
            Write-Host "[EntraModuleSplitter] Created directory: $directoryPath" -ForegroundColor Green
        }
    }

    [string] GetModuleFilePath([string]$source) {
        if ($source -eq 'Entra') {
            return "..\bin\Microsoft.Graph.Entra.psm1"
        } else {
            return "..\bin\Microsoft.Graph.Entra.Beta.psm1"
        }
    }

    [string] GetOutputDirectory([string]$source) {
        if ($source -eq 'Entra') {
            return "..\module\Entra"
        } else {
            return "..\module\EntraBeta"
        }
    }

    [PSCustomObject] ReadJsonFile([string]$jsonFilePath) {
        return Get-Content -Path $jsonFilePath | ConvertFrom-Json
    }

    [array] ExtractFunctions([string]$content) {
        $functions = @()
        $inFunction = $false
        $depth = 0
        $currentFunction = ""
        $currentFunctionName = ""

        foreach ($line in $content -split "`r?`n") {
            if (-not $inFunction) {
                if ($line -match "^function\s+([a-zA-Z0-9_-]+)") {
                    $inFunction = $true
                    $currentFunctionName = $matches[1]
                    $currentFunction = $line + "`n"
                    $depth = ($line -split "{").Count - ($line -split "}").Count
                    continue
                }
            } else {
                $currentFunction += $line + "`n"
                $depth += ($line -split "{").Count - ($line -split "}").Count

                if ($depth -eq 0) {
                    $functions += [pscustomobject]@{ Name = $currentFunctionName; Content = $currentFunction }
                    $inFunction = $false
                    $currentFunction = ""
                    $currentFunctionName = ""
                }
            }
        }

        return $functions
    }

    [void] ProcessFunction([pscustomobject]$function, [string]$specificFunctionName, [string]$moduleOutputDirectory, [PSCustomObject]$jsonContent, [string]$header, [string]$unmappedDirectory) {
        $functionName = $function.Name
        $functionContent = $function.Content
        $ps1Content = $header + "`n" + $functionContent

        # Check for specific function
        if ($functionName -eq $specificFunctionName) {
            $topLevelOutputPath = Join-Path -Path $moduleOutputDirectory -ChildPath "$specificFunctionName.ps1"
            Set-Content -Path $topLevelOutputPath -Value $ps1Content
            Write-Host "[EntraModuleSplitter] Created specific function file: $topLevelOutputPath" -ForegroundColor Cyan
            return
        }

        $isMapped = $false

        foreach ($key in $jsonContent.PSObject.Properties.Name) {
            if ($functionName -like "*Dir*") {
                $key = 'Directory'
            }

            if ($functionName -like "*$key*") {
                $keyDirectoryPath = if ($functionName -like "*Device*") {
                    Join-Path -Path $moduleOutputDirectory -ChildPath "Device"
                } else {
                    Join-Path -Path $moduleOutputDirectory -ChildPath $key
                }

                $this.CreateOutputDirectory($keyDirectoryPath)

                $outputFilePath = Join-Path -Path $keyDirectoryPath -ChildPath "$functionName.ps1"
                Set-Content -Path $outputFilePath -Value $ps1Content
                Write-Host "[EntraModuleSplitter] Created function file: $outputFilePath in $keyDirectoryPath" -ForegroundColor Green
                $isMapped = $true
                break
            }
        }

        if (-not $isMapped) {
            $unmappedFilePath = Join-Path -Path $unmappedDirectory -ChildPath "$functionName.ps1"
            Set-Content -Path $unmappedFilePath -Value $ps1Content
            Write-Host "[EntraModuleSplitter] Created unmapped function file: $unmappedFilePath in UnMappedFiles" -ForegroundColor Red
        }
    }
	


    [void] SplitEntraModule([string]$Source = 'Entra') {
        # Determine file paths and output directories
        $psm1FilePath = $this.GetModuleFilePath($Source)
        $outputDirectory = $this.GetOutputDirectory($Source)
        $jsonFilePath = "..\module\mapping\moduleMapping.json"

        $this.CreateOutputDirectory($outputDirectory)
        $unmappedDirectory = Join-Path -Path $outputDirectory -ChildPath "UnMappedFiles"
        $this.CreateOutputDirectory($unmappedDirectory)

        $jsonContent = $this.ReadJsonFile($jsonFilePath)
        $moduleName = [System.IO.Path]::GetFileNameWithoutExtension($psm1FilePath)
        $moduleOutputDirectory = Join-Path -Path $outputDirectory -ChildPath $moduleName
        $this.CreateOutputDirectory($moduleOutputDirectory)

        $psm1Content = Get-Content -Path $psm1FilePath -Raw
        $functions = $this.ExtractFunctions($psm1Content)

        # Initialize a variable to track if the specific function is processed
        $specificFunctionName = if ($moduleName -eq "Microsoft.Graph.Entra") { "Enable-EntraAzureADAlias" } else { "Enable-EntraBetaAzureADAlias" }

        foreach ($function in $functions) {
            $this.ProcessFunction($function, $specificFunctionName, $moduleOutputDirectory, $jsonContent, $this.Header, $unmappedDirectory)
        }

        Write-Host "[EntraModuleSplitter] Splitting and organizing complete." -ForegroundColor Green
    }

    [void] ProcessEntraAzureADAliases([string]$Module = 'Entra') {
        # Set the start directory and alias file path based on the Module parameter
        $startDirectory, $aliasFilePath = $this.GetModuleDirectories($Module)

      
        # Get all subdirectories
        $directories = Get-ChildItem -Path $startDirectory -Directory

        # Store all mapped aliases across all directories
        $allMappedAliases = @()
        $mappedAliasesCount = 0

        # Get total alias lines from the alias file (ignoring comments and empty lines)
        $aliasFileContent = $this.GetFilteredAliasFileContent($aliasFilePath)
        $totalAliases = $aliasFileContent.Count

        foreach ($directory in $directories) {
            # Get the full path of the directory
            $directoryPath = $directory.FullName

            # Get .ps1 file names in the current directory
            $ps1FileNames = $this.GetPs1FileNames($directoryPath)

            if ($ps1FileNames.Count -gt 0) {
                # Filter alias lines based on the .ps1 file names
                $result = $this.FilterAliasLines($aliasFilePath, $ps1FileNames)

                $filteredLines = $result.FilteredLines
                $mappedAliases = $result.MappedAliases
                $mappedAliasesCount += $mappedAliases.Count

                # Add mapped aliases to the collection
                $allMappedAliases += $mappedAliases

                if ($filteredLines.Count -gt 0) {
                    # Create the target directory for this key if it doesn't exist
                    $targetSubDirectoryPath = Join-Path -Path $startDirectory -ChildPath $directory.Name
                    $this.CreateDirectory($targetSubDirectoryPath)

                    # Create the output file path in the target directory
                    $outputFilePath = Join-Path -Path $targetSubDirectoryPath -ChildPath "Enable-EntraAzureADAliases.ps1"

                    # Write the filtered lines to the output file in the target directory
                    $this.WriteFilteredLines($outputFilePath, $filteredLines, $this.Header)
                }
            }
        }

        # Calculate unmapped aliases and write them to a file
        $unMappedAliases = $this.WriteUnmappedAliases($aliasFileContent, $allMappedAliases, $startDirectory)

        # Display summary information
        $this.DisplaySummary($totalAliases, $mappedAliasesCount, $unMappedAliases.Count)

        Write-Host "[EntraModuleSplitter] Processing complete." -ForegroundColor Green
    }

    [string[]] GetModuleDirectories([string]$Module) {
        $startDirectory = if ($Module -eq 'EntraBeta') {
            "..\module\Entra\Microsoft.Graph.Entra.Beta\"
        } else {
            "..\module\EntraBeta\Entra-Modules\Microsoft.Graph.Entra\"
        }

        $aliasFileName = if ($Module -eq 'EntraBeta') {
            "Enable-EntraBetaAzureADAlias.ps1"
        } else {
            "Enable-EntraAzureADAlias.ps1"
        }

        $aliasFilePath = Join-Path -Path $startDirectory -ChildPath $aliasFileName

        return $startDirectory, $aliasFilePath
    }

    [string] GetHeader() {
        return $this.Header
    }

    [string[]] GetPs1FileNames([string]$directory) {
    $files = Get-ChildItem -Path $directory -Filter "*.ps1" | ForEach-Object {
        [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
    }

    # Return the array of file names, or an empty array if no files are found
    return $files
}


    [PSCustomObject] FilterAliasLines([string]$aliasFilePath, [string[]]$ps1FileNames) {
        $aliasFileContent = $this.GetFilteredAliasFileContent($aliasFilePath)

        $filteredLines = @()
        $mappedAliases = @()

        foreach ($line in $aliasFileContent) {
            foreach ($fileName in $ps1FileNames) {
                if ($line -like "*$fileName*") {
                    $filteredLines += $line
                    $mappedAliases += $line  # Track mapped alias
                    break  # Exit the inner loop if a match is found
                }
            }
        }

        return @{FilteredLines = $filteredLines; MappedAliases = $mappedAliases}
    }

    [string[]] GetFilteredAliasFileContent([string]$aliasFilePath) {
        $fileContents= Get-Content -Path $aliasFilePath | Where-Object { 
            $_.Trim() -ne "" -and -not ($_.Trim().StartsWith("#")) 
        }
		
		return $fileContents
    }

    [void] WriteFilteredLines([string]$outputFilePath, [string[]]$filteredLines, [string]$header) {
        $functionWrapperStart = "`nfunction Enable-EntraAzureADAliases {" + "`n"
        $functionWrapperEnd = "`n`n}"

        $fileContent = $header + $functionWrapperStart + ($filteredLines -join "`n") + $functionWrapperEnd

        Set-Content -Path $outputFilePath -Value $fileContent
        Write-Host "[EntraModuleSplitter] Filtered lines have been written and wrapped inside Enable-EntraAzureADAliases function to $outputFilePath" -ForegroundColor Green
    }

    [string[]] WriteUnmappedAliases([string[]]$aliasFileContent, [string[]]$allMappedAliases, [string]$targetDirectory) {
        $allMappedAliases = $allMappedAliases | Sort-Object -Unique  # Ensure uniqueness
        $unMappedAliases = $aliasFileContent | Where-Object { $allMappedAliases -notcontains $_ }

        # Remove the first and last lines if applicable
        if ($unMappedAliases.Count -gt 2) {
            $unMappedAliases = $unMappedAliases[1..($unMappedAliases.Count - 2)]
        } else {
            $unMappedAliases = @()  # Ensure it returns an empty array if fewer than 2 lines
        }

        if ($unMappedAliases.Count -gt 0) {
            $unmappedFilePath = Join-Path -Path $targetDirectory -ChildPath "UnMappedAliases.psd1"
            Set-Content -Path $unmappedFilePath -Value $unMappedAliases
            Write-Host "[EntraModuleSplitter] Unmapped aliases have been written to $unmappedFilePath" -ForegroundColor Yellow
        } else {
            Write-Host "[EntraModuleSplitter] No unmapped aliases found." -ForegroundColor Blue
        }

        return $unMappedAliases  # Ensure this line returns the unmapped aliases
    }

    [void] CreateDirectory([string]$path) {
        if (-not (Test-Path -Path $path)) {
            New-Item -Path $path -ItemType Directory | Out-Null
            Write-Host "[EntraModuleSplitter] Created directory: $path" -ForegroundColor Yellow
        }
    }

    [void] DisplaySummary([int]$totalAliases, [int]$mappedAliasesCount, [int]$unMappedAliasesCount) {
        Write-Host "[EntraModuleSplitter] Total Alias Lines (excluding comments and blanks): $totalAliases" -ForegroundColor Blue
        Write-Host "[EntraModuleSplitter] Mapped Aliases: $mappedAliasesCount" -ForegroundColor Blue
        Write-Host "[EntraModuleSplitter] UnMapped Aliases: $unMappedAliasesCount" -ForegroundColor Red
    }
}