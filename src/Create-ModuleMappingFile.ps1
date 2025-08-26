# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Create-ModuleMappingFile {
    [cmdletbinding()]
    param(
        [string]
        $ModuleName = 'Entra'  # Default to "Entra" if no argument is provided
    )

    PROCESS {

        if($ModuleName -eq 'Entra'){
            $rootModuleName = 'Microsoft.Entra'
            $docFolderName = 'entra-powershell-v1.0'
        }
        elseif($ModuleName -eq 'EntraBeta'){
            $rootModuleName = 'Microsoft.Entra.Beta'
            $docFolderName = 'entra-powershell-beta'
        }

        $moduleFolderPath = (Join-Path $PSScriptRoot "../module/docs/$docFolderName")
        Write-Host "[ModuleFolderPath] $moduleFolderPath" -ForegroundColor 'Green'
        $subModules = @(Get-ChildItem -Path $moduleFolderPath -Directory)
        Write-Host "[subModules] $($subModules.Count)" -ForegroundColor 'Green'

        $mapping = @{}

        foreach($subModuleName in $subModules.Name){
            $subModuleFolderPath = (Join-Path $moduleFolderPath $subModuleName)
            Write-Host "[ModuleFolderPath] $subModuleFolderPath" -ForegroundColor 'Green'
            $subModulesDocs = @(Get-ChildItem -Path $subModuleFolderPath -File)

            foreach($subModuleDoc in $subModulesDocs){
                if($subModuleDoc.BaseName -ne 'Enable-EntraAzureADAlias'){
                    $mapping.Add($subModuleDoc.BaseName,$subModuleName)
                }
            }
        }

        # Save the mapping to a JSON file
        $mappingFilePath = (Join-Path $PSScriptRoot "$ModuleName-ModuleMapping.json")
        $mapping | ConvertTo-Json -Depth 10 | Out-File -FilePath $mappingFilePath -Encoding utf8
    }
}
