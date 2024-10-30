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
    $UnMappedDirectory = Join-Path -Path $TargetRootDirectory -ChildPath "UnMappedTests"

    # Check if the mapping file exists
    if (-not (Test-Path -Path $MappingFilePath -PathType Leaf)) {
        Log-Message -Message "Mapping file '$MappingFilePath' does not exist." -Level 'ERROR'
        return
    }

    # Load the JSON content from the mapping file
    $moduleMapping = Get-Content -Path $MappingFilePath | ConvertFrom-Json

    # Ensure the root documentation directory and UnMappedTests directory exist
    if (-not (Test-Path -Path $TargetRootDirectory -PathType Container)) {
        New-Item -Path $TargetRootDirectory -ItemType Directory | Out-Null
        Log-Message -Message "Created directory: $TargetRootDirectory" -Level 'SUCCESS'
    }
    if (-not (Test-Path -Path $UnMappedDirectory -PathType Container)) {
        New-Item -Path $UnMappedDirectory -ItemType Directory | Out-Null
        Log-Message -Message "Created directory for unmapped tests: $UnMappedDirectory" -Level 'SUCCESS'
    }

    # Collect all test files in the source directory
    $allTestFiles = Get-ChildItem -Path $TestSourceDirectory -Filter "*.Tests.ps1" -File

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
    }

    # Handle unmapped files by checking if they exist in the mapping
    foreach ($testFile in $allTestFiles) {
        $baseName = $testFile.BaseName -replace '\.Tests$', ''  # Remove '.Tests' suffix
        # Check if the base name is in the mapping file without the ".Tests" suffix
        if (-not $moduleMapping.PSObject.Properties["$baseName"]) {
            # Copy unmapped test file to UnMappedTests directory
            Copy-Item -Path $testFile.FullName -Destination $UnMappedDirectory
            Log-Message -Message "Copied unmapped test '$testFile' to '$UnMappedDirectory'" -Level 'INFO'
        }
    }

    Log-Message -Message "Test file copying and modification complete." -Level 'INFO'
}

Split-Tests -Source 'Entra'
