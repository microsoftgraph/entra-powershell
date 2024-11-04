# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

#This function copies the docs using the moduleMapping.json into their submodule directories
# i.e. For each entry, it will use the Key(cmdlet name) and map it to the Value(A subdirectory created in the respective docs directory)

. ./common-functions.ps1


function Split-Docs {
    param (
        [string]$Module = 'Entra',  # Default to 'Entra'
        [string]$OutputDirectory    # Allow custom output directory
    )

    # Determine source directories and mapping file paths based on the Source parameter
    switch ($Module) {
        'Entra' {
            $DocsSourceDirectory = "../module/docs/entra-powershell-v1.0/Microsoft.Graph.Entra"
            $MappingFilePath = '../moduleVNext/Entra/config/moduleMapping.json'
            $OutputDirectory='../moduleVNext/docs/entra-powershell-v1.0'
        }
        'EntraBeta' {
            $DocsSourceDirectory = "../module/docs/entra-powershell-beta/Microsoft.Graph.Entra.Beta"
            $MappingFilePath = "../moduleVNext/EntraBeta/config/moduleMapping.json"
            $OutputDirectory="../moduleVNext/docs/entra-powershell-beta"
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

    # Ensure the root documentation directory exists, create if it doesn't
    if (-not (Test-Path -Path $TargetRootDirectory -PathType Container)) {
        New-Item -Path $TargetRootDirectory -ItemType Directory | Out-Null
        Log-Message -Message "Created directory: $TargetRootDirectory" -Level 'SUCCESS'
    }

    # Iterate over each file-directory pair in the moduleMapping.json
    foreach ($fileEntry in $moduleMapping.PSObject.Properties) {
        $fileName = $fileEntry.Name      # Key (file name without extension)
        $subDirName = $fileEntry.Value   # Value (sub-directory name)

        # Create the sub-directory under the output root directory if it doesn't exist
        $targetSubDir = Join-Path -Path $TargetRootDirectory -ChildPath $subDirName

        if($subDirName -eq 'Migration' -or $subDirName -eq 'Invitations'){
            Log-Message "Skipping $subDirName" -Level 'WARNING'
            continue
        }
        if (-not (Test-Path -Path $targetSubDir -PathType Container)) {
            New-Item -Path $targetSubDir -ItemType Directory | Out-Null
            Log-Message -Message "Created sub-directory: $targetSubDir" -Level 'SUCCESS'
        }

        # Build the full source file path for the .md file
        $sourceFile = Join-Path -Path $DocsSourceDirectory -ChildPath "$fileName.md"
        if (Test-Path -Path $sourceFile -PathType Leaf) {
            # Copy the .md file to the target sub-directory
            Copy-Item -Path $sourceFile -Destination $targetSubDir
            Log-Message -Message "Copied '$sourceFile' to '$targetSubDir'" -Level 'SUCCESS'
        } else {
            # Log a warning if the .md file doesn't exist in the source directory
            Log-Message -Message "File '$fileName.md' not found in '$DocsSourceDirectory'" -Level 'WARNING'
        }
    }

    Log-Message -Message "Markdown file copying complete." -Level 'INFO'
}