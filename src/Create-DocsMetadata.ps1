# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Create-DocsMetadata {
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
            $fullModuleName = $rootModuleName + '.' + $subModuleName
            $moduleMetadataFilePath = (Join-Path $PSScriptRoot "$fullModuleName.md")
            New-Item -Path $moduleMetadataFilePath -ItemType File -Force

            $header = @"
---
Download Help Link: https://aka.ms/powershell51-help
Help Version: 5.2.0.0
Locale: en-US
Module Guid: e21be540-4e0b-40dc-a419-8d7912f82b2d
Module Name: $fullModuleName
ms.date: 5/29/2024
schema: 2.0.0
title: $fullModuleName
---
"@

            $metadataContent = $header + "`n"
            $metadataContent += "# $fullModuleName Module v1.1`n`n"
            $metadataContent += "## Description`n`n"
            $metadataContent += "This module contains cmdlets that designed to work with $fullModuleName.`n`n"
            $metadataContent += "## $fullModuleName Cmdlets`n`n"
            

            $subModuleFolderPath = (Join-Path $moduleFolderPath $subModuleName)
            Write-Host "[ModuleFolderPath] $subModuleFolderPath" -ForegroundColor 'Green'
            $subModulesDocs = @(Get-ChildItem -Path $subModuleFolderPath -File)

            foreach($subModuleDoc in $subModulesDocs){
                $file = $subModuleDoc.FullName
                $regex = '(?sm).*^## Synopsis\r?\n(.*?)\r?\n## Syntax.*'
                $description = (Get-Content -Raw $file) -replace $regex, '$1'

                $metadataContent += "### [$($subModuleDoc.BaseName)]($($subModuleDoc.Name))`n"
                $metadataContent += "$description`n"
                if($subModuleDoc.BaseName -ne 'Enable-EntraAzureADAlias'){
                    $mapping.Add($subModuleDoc.BaseName,$subModuleName)
                }
            }

            $metadataContent | Out-File -FilePath $moduleMetadataFilePath -Encoding utf8
        }

        # Save the mapping to a JSON file
        $mappingFilePath = (Join-Path $PSScriptRoot "$ModuleName-ModuleMapping.json")
        $mapping | ConvertTo-Json -Depth 10 | Out-File -FilePath $mappingFilePath -Encoding utf8
    }
}
