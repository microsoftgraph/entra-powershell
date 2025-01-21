# Define the JSON files and corresponding directory paths
$mappings = @(
    @{
        jsonFilePath = "entra-powershell-docs-pr/docs/mapping/entra-serviceMapping-beta.json"
        directoryPath = "entra-powershell-docs-pr/docs/reference/beta/Microsoft.Graph.Entra.Beta"
    },
    @{
        jsonFilePath = "entra-powershell-docs-pr/docs/mapping/entra-serviceMapping-1.0.json"
        directoryPath = "entra-powershell-docs-pr/docs/reference/v1.0/Microsoft.Graph.Entra"
    }
)

# Initialize arrays to track changes
$filesAdded = @()
$filesRemoved = @()
$keysRemoved = @()

# Function to process each pair of JSON and directory
function Process-Mapping {
    param (
        [string]$jsonFilePath,
        [string]$directoryPath
    )

    Write-Host "Processing: $jsonFilePath with directory: $directoryPath"

    # Read and parse the JSON file
    try {
        $jsonData = Get-Content -Path $jsonFilePath -Raw | ConvertFrom-Json
    } catch {
        Write-Host "Error reading or parsing JSON file: $_"
        exit 1
    }

    # Get JSON keys
    $jsonKeys = $jsonData.PSObject.Properties.Name

    # Read the directory contents
    try {
        $directoryFiles = Get-ChildItem -Path $directoryPath -File | ForEach-Object {
            [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
        }
    } catch {
        Write-Host "Error reading directory: $_"
        exit 1
    }

    # Compare directory files with JSON keys
    $filesNotInJson = $directoryFiles | Where-Object { $_ -notin $jsonKeys }
    $jsonKeysNotInDirectory = $jsonKeys | Where-Object { $_ -notin $directoryFiles }

    # Only modify keys that are NOT "Microsoft.Graph.Entra.Beta" or "Microsoft.Graph.Entra"
    $protectedKeys = @("Microsoft.Graph.Entra.Beta", "Microsoft.Graph.Entra")

    # Track changes
    $changedFiles = @()
    $removedKeys = @()

    # Add missing files to the JSON object, but exclude the protected keys
    foreach ($file in $filesNotInJson) {
        if ($file -notin $protectedKeys) {
            $jsonData | Add-Member -NotePropertyName $file -NotePropertyValue ""
            $changedFiles += [PSCustomObject]@{ Action = "Added"; FileName = $file }
        }
    }

    # Remove keys from JSON that are not in the directory, but exclude the protected keys
    foreach ($key in $jsonKeysNotInDirectory) {
        if ($key -notin $protectedKeys) {
            $jsonData.PSObject.Properties.Remove($key)
            $removedKeys += [PSCustomObject]@{ Action = "Removed"; FileName = $key }
        }
    }

    # Write the updated JSON object back to the original file
    try {
        $jsonData | ConvertTo-Json -Depth 10 | Set-Content -Path $jsonFilePath
        Write-Host "Updated JSON file with missing keys added and extra keys removed: $jsonFilePath"
    } catch {
        Write-Host "Error writing to JSON file: $_"
        exit 1
    }

    # Collect all changes for output
    $filesAdded += $changedFiles | Where-Object { $_.Action -eq "Added" }
    $filesRemoved += $removedKeys | Where-Object { $_.Action -eq "Removed" }
}

# Loop through each mapping and process it
foreach ($mapping in $mappings) {
    Process-Mapping -jsonFilePath $mapping.jsonFilePath -directoryPath $mapping.directoryPath
}

# Output results
Write-Host "Processing completed for all mappings."

if ($filesAdded.Count -gt 0) {
    Write-Host "Files added to JSON:"
    $filesAdded | Format-Table -AutoSize
} else {
    Write-Host "No files were added to the JSON."
}

if ($filesRemoved.Count -gt 0) {
    Write-Host "Keys removed from JSON:"
    $filesRemoved | Format-Table -AutoSize
} else {
    Write-Host "No keys were removed from the JSON."
}
