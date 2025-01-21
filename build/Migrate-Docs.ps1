# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<# This script assumes that it resides in the same directory as entra-powershell repo and the entra-powershell-docs-pr
What it does:

1. Extracts the file names of all the .md files in the code repo(entra-powershell repo) and the *-mapping.json file 
    in the docs repo(entra-powershell-docs-pr).
2. It will spit out the beta.missing.json or v1.0.missing.jsonthat will tell you which files are in the code repo but not mapped in *-mapping.json file
3. Automatically copies all the .md files from the code repo to the docs repo.
4. You can use the corresponding beta or v1.0 *-mapping.json files, with empty values. Values will be added manually
   to reflect the correct grouping in the docs.
#>

# Define the JSON files and corresponding directory paths

$mappings = @(
    @{
        jsonFilePath = "entra-powershell-docs-pr/docs/mapping/entra-serviceMapping-beta.json"
        sourceDirectoryPath = "entra-powershell/module/docs/entra-powershell-beta"
        destinationDirectoryPath = "entra-powershell-docs-pr/docs/reference/beta/Microsoft.Entra.Beta"
        missingJsonPath = "Beta.missing.json"
    },
    @{
        jsonFilePath = "entra-powershell-docs-pr/docs/mapping/entra-serviceMapping-1.0.json"
        sourceDirectoryPath = "entra-powershell/module/docs/entra-powershell-v1.0"
        destinationDirectoryPath = "entra-powershell-docs-pr/docs/reference/v1.0/Microsoft.Entra"
        missingJsonPath = "v1.0.missing.json"
    }
)

# Function to process each JSON file and source directory pair
function Check-MappingDiscrepancies {
    param (
        [string]$jsonFilePath,
        [string]$sourceDirectoryPath,
        [string]$destinationDirectoryPath,
        [string]$missingJsonPath
    )

    Write-Host "Checking: $jsonFilePath against source directory: $sourceDirectoryPath"

    # Read and parse the JSON file
    try {
        $jsonData = Get-Content -Path $jsonFilePath -Raw | ConvertFrom-Json
    } catch {
        Write-Host "Error reading or parsing JSON file: $_"
        return
    }

    # Get JSON keys
    $jsonKeys = $jsonData.PSObject.Properties.Name
    Write-Host "Found JSON keys:" -ForegroundColor Cyan
    $jsonKeys | ForEach-Object { Write-Host "$_" }

    # Scan subdirectories and collect filenames without extensions
    Write-Host "Scanning subdirectories under source directory: $sourceDirectoryPath" -ForegroundColor Green
    try {
        $directoryFiles = Get-ChildItem -Path $sourceDirectoryPath -Recurse -File -Filter *.md | ForEach-Object {
            $_.BaseName
        }
    } catch {
        Write-Host "Error reading directory: $_"
        return
    }

    # Log the list of filenames found in the source directory
    Write-Host "Files found in the source directory (filenames only):" -ForegroundColor Cyan
    $directoryFiles | ForEach-Object { Write-Host "$_"}

    # Identify files in the source directory that are not in the JSON
    $filesNotInJson = $directoryFiles | Where-Object { $_ -notin $jsonKeys }

    if ($filesNotInJson.Count -gt 0) {
        Write-Host "Entries found in the source directory but missing from the JSON:" -ForegroundColor Yellow
        $filesNotInJson | ForEach-Object { Write-Host "$_" -ForegroundColor Cyan }

        # Write the missing files to the specified JSON file if it doesn't exist
        $missingFiles = @{ }
        $filesNotInJson | ForEach-Object { $missingFiles.Add($_, "") }

        # Check if the missing JSON file exists; create it if not
        if (-Not (Test-Path -Path $missingJsonPath)) {
            Write-Host "$missingJsonPath does not exist. Creating the file..." -ForegroundColor Green
        } else {
            Write-Host "$missingJsonPath already exists. Updating the file..." -ForegroundColor Yellow
        }

        # Convert the missing files to JSON and save them to the specified path
        try {
            $missingFiles | ConvertTo-Json -Depth 3 | Set-Content -Path $missingJsonPath
            Write-Host "Missing entries written to $missingJsonPath" -ForegroundColor Green
        } catch {
            Write-Host "Error writing missing entries to $missingJsonPath $_" -ForegroundColor Red
        }
    } else {
        Write-Host "No discrepancies found. All source files are in the JSON."
    }

    # Ask for user confirmation to copy all files
    $confirmation = Read-Host "Do you want to copy all the files to the destination directory? (Y/N)"
    if ($confirmation -match '^[Yy]$') {
        # Copy all files to the destination directory, overwriting if exists
        $directoryFiles | ForEach-Object {
            $sourceFile = Get-ChildItem -Path $sourceDirectoryPath -Recurse -File -Filter "$_.md"
            $destinationPath = Join-Path -Path $destinationDirectoryPath -ChildPath $sourceFile.Name

            # Copy the file to the destination, overwriting if exists
            try {
                Copy-Item -Path $sourceFile.FullName -Destination $destinationPath -Force
                Write-Host "Copied: $($sourceFile.FullName) to $destinationPath" -ForegroundColor Green
            } catch {
                Write-Host "Error copying file: $sourceFile.FullName to $destinationPath. Error: $_" -ForegroundColor Red
            }
        }
    } else {
        Write-Host "Skipping file copy operation as per user choice." -ForegroundColor Red
    }
}

# Loop through each mapping and check for discrepancies, then ask for user confirmation to copy the files
foreach ($mapping in $mappings) {
    Check-MappingDiscrepancies -jsonFilePath $mapping.jsonFilePath -sourceDirectoryPath $mapping.sourceDirectoryPath -destinationDirectoryPath $mapping.destinationDirectoryPath -missingJsonPath $mapping.missingJsonPath
}

Write-Host "Completed checking all mappings and file copy operations."
