# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

#This function copies the docs using the moduleMapping.json into their submodule directories

function Copy-MarkdownFilesFromMapping {
    param (
        [string]$Source = 'Entra'  # Default to 'Entra'
    )


   switch ($Source) {
        'Entra' {
            $DocsRootDirectory = "../module/docs/Entra/Microsoft.Graph.Entra"
            $MappingFilePath='../module/Entra/config/moduleMapping.json'
        }
        'EntraBeta' {
            $DocsRootDirectory = "../module/docs/EntraBeta/Microsoft.Graph.Entra.Beta"
            $OutputDirectory="../module/EntraBeta/config/"
        }
        default {
            throw "Invalid Source specified. Use 'Entra' or 'EntraBeta'."
        }
    }
    # Check if the mapping file exists
    if (-not (Test-Path -Path $MappingFilePath -PathType Leaf)) {
        throw "Mapping file '$MappingFilePath' does not exist."
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
            throw "Invalid Source specified. Use 'Entra' or 'EntraBeta'."
        }
    }

    # Check if the source directory exists
    if (-not (Test-Path -Path $SourceDirectory -PathType Container)) {
        throw "Source directory '$SourceDirectory' does not exist."
    }

    # Check if the output root directory exists, create if it doesn't
    if (-not (Test-Path -Path $DocsRootDirectory -PathType Container)) {
        New-Item -Path $DocsRootDirectory -ItemType Directory | Out-Null
    }

    # Iterate over each key-value pair in the moduleMapping.json
    foreach ($entry in $moduleMapping.PSObject.Properties) {
        $subDirName = $entry.Name          # Key (sub-directory name)
        $fileNames = $entry.Value          # Value (array of file names without extensions)

        # Create the sub-directory under the output root directory
        $targetSubDir = Join-Path -Path $DocsRootDirectory -ChildPath $subDirName
        if (-not (Test-Path -Path $targetSubDir -PathType Container)) {
            New-Item -Path $targetSubDir -ItemType Directory | Out-Null
        }

        # Copy all matching .md files to the target sub-directory
        foreach ($fileName in $fileNames) {
            $sourceFile = Join-Path -Path $SourceDirectory -ChildPath "$fileName.md"
            if (Test-Path -Path $sourceFile -PathType Leaf) {
                Copy-Item -Path $sourceFile -Destination $targetSubDir
                Write-Host "Copied $sourceFile to $targetSubDir"
            } else {
                Write-Warning "File $fileName.md not found in $SourceDirectory"
            }
        }
    }

    Write-Host "Markdown file copying complete."
}

# Usage example:
Copy-MarkdownFilesFromMapping -Source 'Entra'  # For Entra
