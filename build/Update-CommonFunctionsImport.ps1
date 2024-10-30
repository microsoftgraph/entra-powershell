# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
. ./common-functions.ps1

function Update-CommonFunctionsImport {
    param (
        [string]$Module='Entra'  # Default to the current directory if no path is provided
    )
 
   $rootPath=if($Module -eq 'Entra'){
       "../testVNext/Entra"
   }else{
        "../testVNext/EntraBeta"
   }
    
    # Get all .Tests.ps1 files in the specified directory and its subdirectories
    $testFiles = Get-ChildItem -Path $rootPath -Recurse -Filter *.Tests.ps1

    Log-Message "Starting common-functions import update"
    # Loop through each file
    foreach ($file in $testFiles) {
        # Read the content of the file
        $content = Get-Content -Path $file.FullName

        Log-Message "Processing $file"
        
        # Check if the target string exists in the content
          if ($content -match 'Import-Module \(Join-Path \$PSScriptRoot "\.\.\\\.\.\\\.\.\\Common-Functions\.ps1"\) -Force') {
            # Replace the old string with the new one
            $newContent = $content -replace 'Import-Module \(Join-Path \$PSScriptRoot "\.\.\\\.\.\\\.\.\\Common-Functions\.ps1"\) -Force', 'Import-Module (Join-Path $PSScriptRoot "..\..\build\Common-Functions.ps1") -Force'
            
            # Write the updated content back to the file
            Set-Content -Path $file.FullName -Value $newContent
            
            # Output the change
            Log-Message "Updated file: $($file.FullName)"
        }
    }
}

Update-CommonFunctionsImport -Module 'Entra'