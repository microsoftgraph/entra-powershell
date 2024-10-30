# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

# This function copies the docs using the moduleMapping.json into their submodule directories.
# For each entry, it uses the Key (cmdlet name) to map it to the Value (a subdirectory created in the respective docs directory).

. ./common-functions.ps1

function Split-Tests {
    param (
        [string]$Source = 'Entra',  # Default to 'Entra'
        [string]$OutputDirectory    # Allow custom output directory
    )

    # Determine source directories and mapping file paths based on the Source parameter
    switch ($Source) {
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

    # Use the provided output directory or default to DocsSourceDirectory if none specified
    $TargetRootDirectory = $OutputDirectory

    # Check if the mapping file exists
    if (-not (Test-Path -Path $MappingFilePath -PathType Leaf)) {
        Log-Message -Message "Mapping file '$MappingFilePath' does not exist." -Level 'ERROR'
        return
    }

    # Load the JSON content from the mapping file
    $moduleMapping = Get-Content -Path $MappingFilePath | ConvertFrom-Json

    # Ensure the root documentation directory exists
    if (-not (Test-Path -Path $TargetRootDirectory -PathType Container)) {
        New-Item -Path $TargetRootDirectory -ItemType Directory | Out-Null
        Log-Message -Message "Created directory: $TargetRootDirectory" -Level 'SUCCESS'
    }

    # Collect all test files in the source directory
    $allTestFiles = Get-ChildItem -Path $TestSourceDirectory -Filter "*.Tests.ps1" -File

    # Define additional test files to be copied to each subdirectory
    $additionalTestFiles = @("General.Test.ps1", "Invalid.Tests.ps1", "Module.Tests.ps1", "Valid.Tests.ps1")

    # Iterate over each file-directory pair in the moduleMapping.json
    foreach ($fileEntry in $moduleMapping.PSObject.Properties) {
        $fileName = $fileEntry.Name      # Key (file name without extension)
        $subDirName = $fileEntry.Value   # Value (sub-directory name)

        # Create the sub-directory under the output root directory if it doesn't exist
        $targetSubDir = Join-Path -Path $TargetRootDirectory -ChildPath $subDirName

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
            # Read the content of the source file
            $fileContent = Get-Content -Path $sourceFile -Raw

            # Define the replacement string with the current directory name
            $replacementString = "$modulePrefix.$subDirName"

            # Replace occurrences of 'Microsoft.Graph.Entra' or 'Microsoft.Graph.Entra.Beta' as needed
            $updatedContent = $fileContent -replace [regex]::Escape($modulePrefix), $replacementString

            # Save the modified content to the target sub-directory
            $targetFilePath = Join-Path -Path $targetSubDir -ChildPath "$fileName.Tests.ps1"
            $updatedContent | Set-Content -Path $targetFilePath
            Log-Message -Message "Copied and modified '$sourceFile' to '$targetFilePath'" -Level 'SUCCESS'
        } else {
            Log-Message -Message "File '$fileName.Tests.ps1' not found in '$TestSourceDirectory'" -Level 'WARNING'
        }

        # Copy additional test files to the target sub-directory
        foreach ($additionalTestFile in $additionalTestFiles) {
            $additionalSourceFile = Join-Path -Path $TestSourceDirectory -ChildPath $additionalTestFile
            if (Test-Path -Path $additionalSourceFile -PathType Leaf) {
                Copy-Item -Path $additionalSourceFile -Destination $targetSubDir
                Log-Message -Message "Copied additional test file '$additionalSourceFile' to '$targetSubDir'" -Level 'SUCCESS'
            } else {
                Log-Message -Message "Additional test file '$additionalTestFile' not found in '$TestSourceDirectory'" -Level 'WARNING'
            }
        }

        # Check if the current test file name contains "Dir" or "Application" and handle them appropriately
        if ($fileName -like "*Dir*" -or $fileName -like "*Application*") {
            # Prepare the modified content for Dir or Application tests
            $sourceFileDir = Join-Path -Path $TestSourceDirectory -ChildPath "$fileName.Tests.ps1"
            if (Test-Path -Path $sourceFileDir -PathType Leaf) {
                # Read the content and perform replacements for Dir/Application
                $fileContentDir = Get-Content -Path $sourceFileDir -Raw
                $updatedContentDir = $fileContentDir -replace [regex]::Escape($modulePrefix), $replacementString

                # Determine the destination subdirectory based on the test file name
                $targetSubDirDir = if ($fileName -like "*Dir*") {
                    Join-Path -Path $TargetRootDirectory -ChildPath "DirectoryManagement"
                } elseif ($fileName -like "*Application*") {
                    Join-Path -Path $TargetRootDirectory -ChildPath "Applications"
                } else {
                    $targetSubDir  # Default to the original target subdirectory
                }

                # Ensure the destination subdirectory exists
                if (-not (Test-Path -Path $targetSubDirDir -PathType Container)) {
                    New-Item -Path $targetSubDirDir -ItemType Directory | Out-Null
                    Log-Message -Message "Created destination directory: $targetSubDirDir" -Level 'SUCCESS'
                }

                # Save the modified content to the appropriate destination
                $targetFilePathDir = Join-Path -Path $targetSubDirDir -ChildPath "$fileName.Tests.ps1"
                $updatedContentDir | Set-Content -Path $targetFilePathDir
                Log-Message -Message "Copied and modified '$sourceFileDir' to '$targetFilePathDir'" -Level 'SUCCESS'
            }
        }
    }

    # Handle unmapped files that do not exist in the mapping
    foreach ($testFile in $allTestFiles) {
        $baseName = $testFile.BaseName -replace '\.Tests$', ''  # Remove '.Tests' suffix
        
        # Check if the base name is in the mapping file without the ".Tests" suffix
        if (-not $moduleMapping.PSObject.Properties["$baseName"]) {
            # Check if the test file already exists in the output directories
            $isMapped = $false
            
            # Check for both Entra and EntraBeta directories
            if (Test-Path -Path (Join-Path -Path $OutputDirectory -ChildPath $baseName)) {
                $isMapped = $true
            }

            # If not mapped, copy it to the root output directory
            if (-not $isMapped) {
                Copy-Item -Path $testFile.FullName -Destination $TargetRootDirectory
                Log-Message -Message "Copied unmapped test '$testFile' to '$TargetRootDirectory'" -Level 'INFO'
            }
        }
    }

    Log-Message -Message "Test file copying and modification complete." -Level 'INFO'
}

Split-Tests -Source 'Entra'
