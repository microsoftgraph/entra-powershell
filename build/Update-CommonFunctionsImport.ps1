# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
. ./common-functions.ps1

function Update-CommonFunctionsImport {
    param (
        [string]$Module = 'Entra'  # Default to 'Entra' if no path is provided
    )

    $rootPath = if ($Module -eq 'Entra') {
        "../testVNext/Entra"
    } else {
        "../testVNext/EntraBeta"
    }
    
    # Get all .Tests.ps1 files in the specified directory and its subdirectories
    $testFiles = Get-ChildItem -Path $rootPath -Recurse -Filter *.Tests.ps1

    Log-Message "Starting common-functions import update"
    
    # Loop through each file
    foreach ($file in $testFiles) {
        # Read the content of the file
        $content = Get-Content -Path $file.FullName -Raw

        Log-Message "Processing $file"
        
        # Check and replace all occurrences of the target string
        if ($content -match 'Import-Module\s*\(\s*Join-Path\s*\$psscriptroot\s*["'']\.\.\\Common-Functions\.ps1["'']\s*\)\s*-Force') {
            # Replace the old string with the new one
            $newContent = $content -replace 'Import-Module\s*\(\s*Join-Path\s*\$psscriptroot\s*["'']\.\.\\Common-Functions\.ps1["'']\s*\)\s*-Force', 'Import-Module (Join-Path $PSScriptRoot "..\..\build\Common-Functions.ps1") -Force'
            
            # Write the updated content back to the file
            Set-Content -Path $file.FullName -Value $newContent
            
            # Output the change
            Log-Message "Updated file: $($file.FullName)"
        }
    }
}

# Run the function for both modules
Update-CommonFunctionsImport -Module 'Entra'
Update-CommonFunctionsImport -Module 'EntraBeta'
