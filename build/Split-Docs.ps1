# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

#This function copies the docs using the moduleMapping.json into their submodule directories
# i.e. For each entry, it will use the Key(cmdlet name) and map it to the Value(A subdirectory created in the respective docs directory)

param (
    [string]$Module = "Entra"  # Default to "Entra" if no argument is provided
)

.(Join-Path $psscriptroot "/common-functions.ps1")


function Split-Docs {
    param (
        [string]$Module = 'Entra'
    )

    # Determine source directories and mapping file paths based on the Source parameter
    switch ($Module) {
        'Entra' {
            $DocsSourceDirectory = (Join-Path $PSScriptRoot "../module_legacy/docs/entra-powershell-v1.0/Microsoft.Graph.Entra")
            $MappingFilePath =  (Join-Path $PSScriptRoot '../module/Entra/config/moduleMapping.json')
            $OutputDirectory= (Join-Path $PSScriptRoot '../module/docs-temp/entra-powershell-v1.0')
        }
        'EntraBeta' {
            $DocsSourceDirectory =  (Join-Path $PSScriptRoot "../module_legacy/docs/entra-powershell-beta/Microsoft.Graph.Entra.Beta")
            $MappingFilePath = (Join-Path $PSScriptRoot "../module/EntraBeta/config/moduleMapping.json")
            $OutputDirectory= (Join-Path $PSScriptRoot "../module/docs-temp/entra-powershell-beta")
        }
        default {
            Log-Message -Message "[Split-Docs]: Invalid Source specified. Use 'Entra' or 'EntraBeta'." -Level 'ERROR'
            return
        }
    }

    # Use the provided output directory or default to DocsSourceDirectory if none specified
    $TargetRootDirectory = $OutputDirectory

    # Check if the mapping file exists
    if (-not (Test-Path -Path $MappingFilePath -PathType Leaf)) {
        Log-Message -Message "[Split-Docs]: Mapping file '$MappingFilePath' does not exist." -Level 'ERROR'
        return
    }

    # Load the JSON content from the mapping file
    $moduleMapping = Get-Content -Path $MappingFilePath | ConvertFrom-Json

    # Ensure the root documentation directory exists, create if it doesn't
    if (-not (Test-Path -Path $TargetRootDirectory -PathType Container)) {
        New-Item -Path $TargetRootDirectory -ItemType Directory | Out-Null
        Log-Message -Message "[Split-Docs]: Created directory: $TargetRootDirectory" -Level 'SUCCESS'
    }

    # Ensure UnMappedDocs directory exists at the same level as the OutputDirectory
    $unMappedDocsDirectory = Join-Path -Path (Split-Path $TargetRootDirectory) -ChildPath 'UnMappedDocs'
    if (-not (Test-Path -Path $unMappedDocsDirectory -PathType Container)) {
        New-Item -Path $unMappedDocsDirectory -ItemType Directory | Out-Null
        Log-Message -Message "[Split-Docs]: Created 'UnMappedDocs' directory: $unMappedDocsDirectory" -Level 'SUCCESS'
    }

    # Iterate over each file in the DocsSourceDirectory
    $filesInSource = Get-ChildItem -Path $DocsSourceDirectory -Filter "*.md"

    foreach ($file in $filesInSource) {
        $fileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        
        # Check if the fileName exists in the mapping
        $subDirName = $moduleMapping.PSObject.Properties.Name | Where-Object { $_ -eq $fileNameWithoutExtension }
        
        if ($subDirName) {
            # If a subdir is mapped, proceed as before
            $subDirName = $moduleMapping.$fileNameWithoutExtension
            $targetSubDir = Join-Path -Path $TargetRootDirectory -ChildPath $subDirName

            if($subDirName -eq 'Migration' -or $subDirName -eq 'Invitations'){
                Log-Message "[Split-Docs]: Skipping $subDirName" -Level 'WARNING'
                continue
            }
            if (-not (Test-Path -Path $targetSubDir -PathType Container)) {
                New-Item -Path $targetSubDir -ItemType Directory | Out-Null
                Log-Message -Message "[Split-Docs]: Created sub-directory: $targetSubDir" -Level 'SUCCESS'
            }

            # Copy the .md file to the target sub-directory
            Copy-Item -Path $file.FullName -Destination $targetSubDir
            Log-Message -Message "[Split-Docs]: Copied '$file' to '$targetSubDir'" -Level 'SUCCESS'
        }
        else {
            # If no mapping found, move it to UnMappedDocs
            Copy-Item -Path $file.FullName -Destination $unMappedDocsDirectory
            Log-Message -Message "[Split-Docs]: No mapping for '$fileNameWithoutExtension'. Moved to '$unMappedDocsDirectory'" -Level 'INFO'
        }
    }

    Log-Message -Message "[Split-Docs]: Markdown file copying complete." -Level 'INFO'
}

Split-Docs -Module $Module
