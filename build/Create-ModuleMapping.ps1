# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

#This function uses the moduleMapping.json to split the docs to subdirectories i.e. Key =SubModule name and
# Value =an array of strings representing the files in that directory
. ./common-functions.ps1
function Get-DirectoryFileMap {
    param (
        [string]$Source = 'Entra' # Default to 'Entra'
    )


    # Determine the root directory and the output based on the Source parameter
    switch ($Source) {
        'Entra' {
            $RootDirectory = "../module/Entra/Microsoft.Graph.Entra/"
            $OutputDirectory = '../module/Entra/config/'
        }
        'EntraBeta' {
            $RootDirectory = "../module/EntraBeta/Microsoft.Graph.Entra.Beta/"
            $OutputDirectory = "../module/EntraBeta/config/"
        }
        default {
            Log-Message "Invalid Source specified. Use 'Entra' or 'EntraBeta'." 'Error'
            throw "Invalid Source specified. Use 'Entra' or 'EntraBeta'."
        }
    }

    # Check if the root directory exists
    if (-not (Test-Path -Path $RootDirectory -PathType Container)) {
        Log-Message "Directory '$RootDirectory' does not exist." 'Error'
        throw "Directory '$RootDirectory' does not exist."
    } else {
        Log-Message "Root directory '$RootDirectory' found."
    }

    # Check if the output directory exists, create if it doesn't
    if (-not (Test-Path -Path $OutputDirectory -PathType Container)) {
        New-Item -Path $OutputDirectory -ItemType Directory | Out-Null
        Log-Message "Output directory '$OutputDirectory' did not exist, created it." 'Warning'
    } else {
        Log-Message "Output directory '$OutputDirectory' exists."
    }

    $fileDirectoryMap = @{}

    # Get all the subdirectories under the root directory
    $subDirectories = Get-ChildItem -Path $RootDirectory -Directory

    foreach ($subDir in $subDirectories) {
        Log-Message "Processing subdirectory '$($subDir.Name)'." 'Info'

        # Get the files in each sub-directory without their extensions
        $files = Get-ChildItem -Path $subDir.FullName -File | ForEach-Object {
            $fileName = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
            # Map the file name to the directory name
            $fileDirectoryMap[$fileName] = $subDir.Name
            Log-Message "Mapped file '$fileName' to directory '$($subDir.Name)'." 'Info'
        }
    }

    # Convert the file-directory map to JSON
    $jsonOutput = $fileDirectoryMap | ConvertTo-Json -Depth 3

    # Define the output file path as moduleMapping.json
    $outputFilePath = Join-Path -Path $OutputDirectory -ChildPath "newModuleMapping.json"

    # Write the JSON output to moduleMapping.json
    $jsonOutput | Out-File -FilePath $outputFilePath -Encoding UTF8

    Log-Message "moduleMapping.json has been created at '$outputFilePath'." 'Info'
}

Get-DirectoryFileMap -Source 'Entra'