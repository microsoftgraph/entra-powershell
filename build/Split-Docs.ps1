# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

#This function copies the docs using the moduleMapping.json into their submodule directories

. ./common-functions.ps1

# Modified Copy-MarkdownFilesFromMapping function
function Copy-MarkdownFilesFromMapping {
    param (
        [string]$Source = 'Entra'  # Default to 'Entra'
    )

    # Determine directories and mapping file paths based on the Source parameter
    switch ($Source) {
        'Entra' {
            $DocsRootDirectory = "../module/docs/Entra/Microsoft.Graph.Entra"
            $MappingFilePath = '../module/Entra/config/moduleMapping.json'
        }
        'EntraBeta' {
            $DocsRootDirectory = "../module/docs/EntraBeta/Microsoft.Graph.Entra.Beta"
            $MappingFilePath = "../module/EntraBeta/config/moduleMapping.json"
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

    # Determine the source directory based on the Source parameter
    switch ($Source) {
        'Entra' {
            $SourceDirectory = "./entra-powershell/module/docs/entra-powershell-v1.0/Microsoft.Graph.Entra"
        }
        'EntraBeta' {
            $SourceDirectory = "./entra-powershell/module/docs/entra-powershell-beta/Microsoft.Graph.Entra.Beta"
        }
        default {
            Log-Message -Message "Invalid Source specified. Use 'Entra' or 'EntraBeta'." -Level 'ERROR'
            return
        }
    }

    # Check if the source directory exists
    if (-not (Test-Path -Path $SourceDirectory -PathType Container)) {
        Log-Message -Message "Source directory '$SourceDirectory' does not exist." -Level 'ERROR'
        return
    }

    # Ensure the root documentation directory exists, create if it doesn't
    if (-not (Test-Path -Path $DocsRootDirectory -PathType Container)) {
        New-Item -Path $DocsRootDirectory -ItemType Directory | Out-Null
        Log-Message -Message "Created directory: $DocsRootDirectory" -Level 'SUCCESS'
    }

    # Iterate over each file-directory pair in the moduleMapping.json
    foreach ($fileEntry in $moduleMapping.PSObject.Properties) {
        $fileName = $fileEntry.Name      # Key (file name without extension)
        $subDirName = $fileEntry.Value   # Value (sub-directory name)

        # Create the sub-directory under the output root directory if it doesn't exist
        $targetSubDir = Join-Path -Path $DocsRootDirectory -ChildPath $subDirName
        if (-not (Test-Path -Path $targetSubDir -PathType Container)) {
            New-Item -Path $targetSubDir -ItemType Directory | Out-Null
            Log-Message -Message "Created sub-directory: $targetSubDir" -Level 'SUCCESS'
        }

        # Build the full source file path for the .md file
        $sourceFile = Join-Path -Path $SourceDirectory -ChildPath "$fileName.md"
        if (Test-Path -Path $sourceFile -PathType Leaf) {
            # Copy the .md file to the target sub-directory
            Copy-Item -Path $sourceFile -Destination $targetSubDir
            Log-Message -Message "Copied '$sourceFile' to '$targetSubDir'" -Level 'SUCCESS'
        } else {
            # Log a warning if the .md file doesn't exist in the source directory
            Log-Message -Message "File '$fileName.md' not found in '$SourceDirectory'" -Level 'WARNING'
        }
    }

    Log-Message -Message "Markdown file copying complete." -Level 'INFO'
}


# Usage example:
#Copy-MarkdownFilesFromMapping -Source 'Entra'  # For Entra
