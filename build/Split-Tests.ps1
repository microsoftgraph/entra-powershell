# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

# This function copies the docs using the moduleMapping.json into their submodule directories.
# For each entry, it uses the Key (cmdlet name) to map it to the Value (a subdirectory created in the respective docs directory).

. ./common-functions.ps1

function Split-Tests {
    param (
        [string]$Module = 'Entra',  # Default to 'Entra'
        [string]$OutputDirectory      # Allow custom output directory
    )

    # Determine source directories and mapping file paths based on the Source parameter
    
    switch ($Module) {
        'Entra' {
            $TestSourceDirectory = "../test/module/Entra"
            $MappingFilePath = '../moduleVNext/Entra/config/moduleMapping.json'
            $OutputDirectory = '../testVNext/Entra'
            $modulePrefix = 'Microsoft.Graph.Entra'
        }
        'EntraBeta' {
            $TestSourceDirectory = "../test/module/EntraBeta"
            $MappingFilePath = "../moduleVNext/EntraBeta/config/moduleMapping.json"
            $OutputDirectory = "../testVNext/EntraBeta"
            $modulePrefix = 'Microsoft.Graph.Entra.Beta'
        }
        default {
            Log-Message -Message "Invalid Source specified. Use 'Entra' or 'EntraBeta'." -Level 'ERROR'
            return
        }
    }

    # Check if the mapping file exists
    if (-not (Test-Path -Path $MappingFilePath -PathType Leaf)) {
        Log-Message -Message "Mapping file '$MappingFilePath' does not exist." -Level 'ERROR'
        return
    }

    # Load the JSON content from the mapping file
    $moduleMapping = Get-Content -Path $MappingFilePath | ConvertFrom-Json

    # Create a set to track files that have been processed
    $processedFiles = @{}

    # Ensure the root documentation directory exists
    if (-not (Test-Path -Path $OutputDirectory -PathType Container)) {
        New-Item -Path $OutputDirectory -ItemType Directory | Out-Null
        Log-Message -Message "Created directory: $OutputDirectory" -Level 'SUCCESS'
    }

    # Collect all test files in the source directory
    $allTestFiles = Get-ChildItem -Path $TestSourceDirectory -Filter "*.Tests.ps1" -File

    # Define additional test files to be copied to each subdirectory
    $additionalTestFiles = @("General.Test.ps1", "Invalid.Tests.ps1", "Module.Tests.ps1", "Valid.Tests.ps1", "Entra.Tests.ps1")

    # Iterate over each file-directory pair in the moduleMapping.json
    foreach ($fileEntry in $moduleMapping.PSObject.Properties) {
        $fileName = $fileEntry.Name      # Key (file name without extension)
        $subDirName = $fileEntry.Value   # Value (sub-directory name)

        # Create the sub-directory under the output root directory if it doesn't exist
        $targetSubDir = Join-Path -Path $OutputDirectory -ChildPath $subDirName

        # Skip specified subdirectories
        if ($subDirName -eq 'Migration' -or $subDirName -eq 'Invitations') {
            Log-Message "Skipping $subDirName" -Level 'WARNING'
            continue
        }

        if (-not (Test-Path -Path $targetSubDir -PathType Container)) {
            New-Item -Path $targetSubDir -ItemType Directory | Out-Null
            Log-Message -Message "Created sub-directory: $targetSubDir" -Level 'SUCCESS'
        }

        # Build the full source file path for the .Tests.ps1 file
        $sourceFile = Join-Path -Path $TestSourceDirectory -ChildPath "$fileName.Tests.ps1"

        if (Test-Path -Path $sourceFile -PathType Leaf) {
            # Copy the file to the target sub-directory
            Copy-Item -Path $sourceFile -Destination $targetSubDir
            Log-Message -Message "Copied '$sourceFile' to '$targetSubDir'" -Level 'SUCCESS'
            
            # Track the processed file
            $processedFiles[$fileName] = $true
        } else {
            Log-Message -Message "File '$fileName.Tests.ps1' not found in '$TestSourceDirectory'" -Level 'WARNING'
        }

        # Copy additional test files to the target sub-directory
        foreach ($additionalTestFile in $additionalTestFiles) {
            $additionalSourceFile = Join-Path -Path $TestSourceDirectory -ChildPath $additionalTestFile
            if (Test-Path -Path $additionalSourceFile -PathType Leaf) {
                # Copy the additional test file
                Copy-Item -Path $additionalSourceFile -Destination $targetSubDir
                Log-Message -Message "Copied additional test file '$additionalSourceFile' to '$targetSubDir'" -Level 'SUCCESS'
                
                # Track the processed additional file
                $processedFiles[$additionalTestFile] = $true
            } else {
                Log-Message -Message "Additional test file '$additionalTestFile' not found in '$TestSourceDirectory'" -Level 'WARNING'
            }
        }

        # Check if the current test file name contains "Dir" or "Application" and handle them appropriately
        if ($fileName -like "*Dir*" -or $fileName -like "*Application*") {
            # Prepare the modified content for Dir or Application tests
            $sourceFileDir = Join-Path -Path $TestSourceDirectory -ChildPath "$fileName.Tests.ps1"
            if (Test-Path -Path $sourceFileDir -PathType Leaf) {
                # Copy the file to the appropriate target directory
                $targetDirSubDir = if ($fileName -like "*Dir*") {
                    Join-Path -Path $OutputDirectory -ChildPath "DirectoryManagement"
                } elseif ($fileName -like "*Application*") {
                    Join-Path -Path $OutputDirectory -ChildPath "Applications"
                } else {
                    $targetSubDir
                }

                if (-not (Test-Path -Path $targetDirSubDir -PathType Container)) {
                    New-Item -Path $targetDirSubDir -ItemType Directory | Out-Null
                    Log-Message -Message "Created target directory: $targetDirSubDir" -Level 'SUCCESS'
                }

                # Copy the file to the determined sub-directory
                Copy-Item -Path $sourceFileDir -Destination $targetDirSubDir
                Log-Message -Message "Copied '$sourceFileDir' to '$targetDirSubDir'" -Level 'SUCCESS'
                
                # Track the processed Dir/Application file
                 
                $processedFiles[$fileName] = $true
            }
        }
    }

    # Process all copied files to update their contents
    foreach ($subDir in Get-ChildItem -Path $OutputDirectory -Directory) {
        $subDirPath = $subDir.FullName
        $testFilesInSubDir = Get-ChildItem -Path $subDirPath -Filter "*.Tests.ps1"

        foreach ($testFile in $testFilesInSubDir) {
            $fileContent = Get-Content -Path $testFile.FullName -Raw
            $updatedContent = $fileContent -replace [regex]::Escape($modulePrefix), "$modulePrefix.$($subDir.Name)"
            

            # Save the modified content back to the file
            $updatedContent | Set-Content -Path $testFile.FullName
            Log-Message -Message "Updated content in '$testFile.FullName'" -Level 'SUCCESS'
        }
    }



    # Handle unmapped files that do not exist in the mapping
    foreach ($testFile in $allTestFiles) {
        $baseName = $testFile.BaseName -replace '\.Tests$', ''  # Remove '.Tests' suffix
        
        # Only consider unmapped files if they haven't been processed
        if (-not $processedFiles.ContainsKey($baseName)) {
            # Check if the test file already exists in the output directories
            $isMapped = $false
            
            # Check for both Entra and EntraBeta directories
            if (Test-Path -Path (Join-Path -Path $OutputDirectory -ChildPath $baseName)) {
                $isMapped = $true
            }

            # If not mapped, copy it to the root output directory
            if (-not $isMapped) {
                Copy-Item -Path $testFile.FullName -Destination $OutputDirectory
                Log-Message -Message "Copied unmapped test '$testFile' to '$OutputDirectory'" -Level 'INFO'
            }
        }
    }

    Log-Message -Message "Split-Tests completed for source: $Module" -Level 'SUCCESS'
}

function Update-CommonFunctionsImport {
    param (
        [string]$Module='Entra'  # Default to the current directory if no path is provided
    )
 
   $rootPath=if($Module -eq 'Entra'){
       "../testVNext/Entra"
   }else{
        "../testVNext/EntraBeta"
   }
    
    # Get all .Tests.ps1 files in the specified directory and its subdirectories
    $testFiles = Get-ChildItem -Path $rootPath -Recurse -Filter *.Tests.ps1

    Log-Message "Starting common-functions import update"
    # Loop through each file
    foreach ($file in $testFiles) {
        # Read the content of the file
        $content = Get-Content -Path $file.FullName

        Log-Message "Processing $file"
        
        # Check if the target string exists in the content
          if ($content -match  'Import-Module\s*\(\s*Join-Path\s*\$psscriptroot\s*["'']\.\.\\Common-Functions\.ps1["'']\s*\)\s*-Force') {
            # Replace the old string with the new one
            $newContent = $content -replace 'Import-Module \(Join-Path \$PSScriptRoot "\.\.\\\.\.\\\.\.\\Common-Functions\.ps1"\) -Force', 'Import-Module (Join-Path $PSScriptRoot "..\..\build\Common-Functions.ps1") -Force'
            
            # Write the updated content back to the file
            Set-Content -Path $file.FullName -Value $newContent
            
            # Output the change
            Log-Message "Updated file: $($file.FullName)"
        }
    }
}


Split-Tests -Module 'EntraBeta'
