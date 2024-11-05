# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

. ../build/common-functions.ps1
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
            Log-Message "[EntraModuleSplitter] Created directory: $directoryPath" -Level 'SUCCESS'
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
            return "..\moduleVNext\Entra\"
        } else {
            return "..\moduleVNext\EntraBeta\"
        }
    }

    [PSCustomObject] ReadJsonFile([string]$jsonFilePath) {
        return Get-Content -Path $jsonFilePath | ConvertFrom-Json -AsHashTable
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

    [void] ProcessFunction([pscustomobject]$function, [string]$specificFunctionName, [string]$moduleOutputDirectory, [PSCustomObject]$moduleMapping, [string]$header, [string]$unmappedDirectory) {
    $functionName = $function.Name
    $functionContent = $function.Content

    # Append the function contents to the header
    $ps1Content = $header + "`n" + $functionContent

    # Add the Enable-Entra*AzureADAlias function to the root of the module directory
    if ($functionName -eq $specificFunctionName) {
        $topLevelOutputPath = Join-Path -Path $moduleOutputDirectory -ChildPath "$specificFunctionName.ps1"
        Set-Content -Path $topLevelOutputPath -Value $ps1Content
        Log-Message "[EntraModuleSplitter] Created specific function file: $topLevelOutputPath" -Level 'INFO'
        return
    }
	
	 # Function has been mapped to a directory
    $isMapped = $false

    if($moduleMapping.ContainsKey($functionName) -and (-not($moduleMapping.$functionName -eq 'Migration' -or $moduleMapping.$functionName -eq 'Invitations'))){

        $subModuleDirectoryName = $moduleMapping.$functionName

        # Create the subModule Directory
        $subModuleDirectory = Join-Path $moduleOutputDirectory -ChildPath "$subModuleDirectoryName"


        # Create the directory if it doesn't exist
        $this.CreateOutputDirectory($subModuleDirectory)

        # Write the main function to the appropriate directory
        $outputFilePath = Join-Path -Path $subModuleDirectory -ChildPath "$functionName.ps1"
        Set-Content -Path $outputFilePath -Value $ps1Content
        Log-Message "[EntraModuleSplitter] Created function file: $outputFilePath in $subModuleDirectory" -Level 'SUCCESS'

        $isMapped = $true
	}

    # Account for unmapped files
    if (-not $isMapped -and $functionName -ne 'New-EntraCustomHeaders') {
        $unmappedFilePath = Join-Path -Path $unmappedDirectory -ChildPath "$functionName.ps1"
        Set-Content -Path $unmappedFilePath -Value $ps1Content
        Log-Message "[EntraModuleSplitter] Created unmapped function file: $unmappedFilePath in UnMappedFiles" -Level 'ERROR'
    }
}


    [void] AddFunctionsToAllDirectories([string]$moduleOutputDirectory, [PSCustomObject[]]$functionContents) {
    # Get all directories under the module output directory
    $subDirectories = Get-ChildItem -Path $moduleOutputDirectory -Directory

    foreach ($subDir in $subDirectories) {
        foreach ($functionContent in $functionContents) {
            # Construct the full path for the function file
            $functionName = $functionContent.Name
            $headerPs1Content = $this.Header + "`n" + $functionContent.Content
            $functionFilePath = Join-Path -Path $subDir.FullName -ChildPath "$functionName.ps1"

            # Write the function to the specified file
            Set-Content -Path $functionFilePath -Value $headerPs1Content
            Log-Message "[EntraModuleSplitter] Added $functionName function to: $functionFilePath"
        }
    }
}

[void] SplitEntraModule([string]$Module = 'Entra') {

       $JsonFilePath=if($Module -eq 'Entra'){
          '../moduleVNext/Entra/config/moduleMapping.json'
       }else{
         '../moduleVNext/EntraBeta/config/moduleMapping.json'
       }
		# Determine file paths and output directories
		$psm1FilePath = $this.GetModuleFilePath($Module)
		$outputDirectory = $this.GetOutputDirectory($Module)

		$this.CreateOutputDirectory($outputDirectory)
		$unmappedDirectory = Join-Path -Path $outputDirectory -ChildPath "UnMappedFiles"
		$this.CreateOutputDirectory($unmappedDirectory)

		$jsonContent = $this.ReadJsonFile($JsonFilePath)
		$moduleName = [System.IO.Path]::GetFileNameWithoutExtension($psm1FilePath)
		$moduleOutputDirectory = Join-Path -Path $outputDirectory -ChildPath $moduleName
        Log-Message "ModuleOutputDirectry $moduleOutputDirectory" -Level 'ERROR'
		$this.CreateOutputDirectory($moduleOutputDirectory)

        Log-Message 'PSM1 Path $psm1FilePath' -Level 'WARNING'
		$psm1Content = Get-Content -Path $psm1FilePath -Raw
		$functions = $this.ExtractFunctions($psm1Content)

		# Get the function contents for both New-EntraCustomHeaders and Get-EntraUnsupportedCommand
		$functionNames = @("New-EntraCustomHeaders", "Get-EntraUnsupportedCommand")
		$functionContents = $functions | Where-Object { $functionNames -contains $_.Name }

		# Initialize a variable to track if the specific function is processed
		$specificFunctionName = if ($moduleName -eq "Microsoft.Graph.Entra") { "Enable-EntraAzureADAlias" } else { "Enable-EntraBetaAzureADAliases" }

		foreach ($function in $functions) {
               $this.ProcessFunction($function, $specificFunctionName, $moduleOutputDirectory, $jsonContent, $this.Header, $unmappedDirectory)
		}

		# Call the new method to add functions to all directories
		$this.AddFunctionsToAllDirectories($moduleOutputDirectory, $functionContents)

		Log-Message "[EntraModuleSplitter] Splitting and organizing complete." -Level 'SUCCESS'
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
        $totalAliases = if($aliasFileContent){
            $aliasFileContent.Count
        }else{
            0
        }

        foreach ($directory in $directories) {
            # Skip the 'Migration' sub-directory
            if ($directory.Name -eq 'Migration' -or $directory.Name -eq 'Invitations') {
                Log-Message "Skipping $directory.Name directory." -Level 'INFO'
                continue
            }
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

        Log-Message "[EntraModuleSplitter] Processing complete." -Level 'SUCCESS'
    }

    [string[]] GetModuleDirectories([string]$Module) {
        $startDirectory = if ($Module -eq 'EntraBeta') {
            "..\moduleVNext\EntraBeta\Microsoft.Graph.Entra.Beta\"
        } else {
            "..\moduleVNext\Entra\Microsoft.Graph.Entra\"
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
        Log-Message "[EntraModuleSplitter] Filtered lines have been written and wrapped inside Enable-EntraAzureADAliases function to $outputFilePath" -Level 'SUCCESS'
    }

    [string[]] WriteUnmappedAliases([string[]]$aliasFileContent, [string[]]$allMappedAliases, [string]$targetDirectory) {
        $allMappedAliases = $allMappedAliases | Sort-Object -Unique  # Ensure uniqueness
        $unMappedAliases = $aliasFileContent | Where-Object { $allMappedAliases -notcontains $_ }

        # Remove the first and last lines if applicable
        if ($unMappedAliases -and $unMappedAliases.Count -gt 2) {
            $unMappedAliases = $unMappedAliases[1..($unMappedAliases.Count - 2)]
        } else {
            $unMappedAliases = @()  # Ensure it returns an empty array if fewer than 2 lines
        }

        if ($unMappedAliases.Count -gt 0) {
            $unmappedFilePath = Join-Path -Path $targetDirectory -ChildPath "UnMappedAliases.psd1"
            Set-Content -Path $unmappedFilePath -Value $unMappedAliases
            Log-Message "[EntraModuleSplitter] Unmapped aliases have been written to $unmappedFilePath" -Level 'INFO'
        } else {
            Log-Message "[EntraModuleSplitter] No unmapped aliases found." -Level 'INFO'
        }

        return $unMappedAliases  # Ensure this line returns the unmapped aliases
    }

    [void] CreateDirectory([string]$path) {
        if (-not (Test-Path -Path $path)) {
            New-Item -Path $path -ItemType Directory | Out-Null
            Log-Message "[EntraModuleSplitter] Created directory: $path"
        }
    }

    [void] DisplaySummary([int]$totalAliases, [int]$mappedAliasesCount, [int]$unMappedAliasesCount) {
        Log-Message "[EntraModuleSplitter] Total Alias Lines (excluding comments and blanks): $totalAliases"
        Log-Message "[EntraModuleSplitter] Mapped Aliases: $mappedAliasesCount"
        Log-Message "[EntraModuleSplitter] UnMapped Aliases: $unMappedAliasesCount" -Level 'ERROR'
    }
}