function Get-DirectoryFileMap {
    param (
        [string]$Source = 'Entra',  # Default to 'Entra'
        [string]$OutputDirectory
    )

    # Determine the root directory based on the Source parameter
    switch ($Source) {
        'Entra' {
            $RootDirectory = "./entra-powershell/module/Entra/Microsoft.Graph.Entra"
        }
        'EntraBeta' {
            $RootDirectory = "./entra-powershell/module/Entra/Microsoft.Graph.Entra.Beta"
        }
        default {
            throw "Invalid Source specified. Use 'Entra' or 'EntraBeta'."
        }
    }

    # Check if the root directory exists
    if (-not (Test-Path -Path $RootDirectory -PathType Container)) {
        throw "Directory '$RootDirectory' does not exist."
    }

    # Check if the output directory exists, create if it doesn't
    if (-not (Test-Path -Path $OutputDirectory -PathType Container)) {
        New-Item -Path $OutputDirectory -ItemType Directory | Out-Null
    }

    $directoryMap = @{}

    # Get all the subdirectories under the root directory
    $subDirectories = Get-ChildItem -Path $RootDirectory -Directory

    foreach ($subDir in $subDirectories) {
        # Get the files in each sub-directory without their extensions
        $files = Get-ChildItem -Path $subDir.FullName -File | ForEach-Object {
            [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
        }

        # Add the directory name and corresponding file names to the map
        $directoryMap[$subDir.Name] = $files
    }

    # Convert the directory map to JSON
    $jsonOutput = $directoryMap | ConvertTo-Json -Depth 3

    # Define the output file path as moduleMapping.json
    $outputFilePath = Join-Path -Path $OutputDirectory -ChildPath "moduleMapping.json"

    # Write the JSON output to moduleMapping.json
    $jsonOutput | Out-File -FilePath $outputFilePath -Encoding UTF8

    Write-Host "moduleMapping.json has been created at $outputFilePath"
}

# Usage example:
$outputDir = "C:\Users\enganga\Entra\"
Get-DirectoryFileMap -Source 'Entra' -OutputDirectory $outputDir  # For Entra

