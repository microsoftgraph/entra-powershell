# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-MissingCmds {
    [cmdletbinding()]
    param(
        [string]
        $ModuleName = 'AzureAD'
    )

    PROCESS {
        Import-Module $ModuleName -Force | Out-Null

        $names = @()
        $module = Get-Module -Name $ModuleName
        $names += $module.ExportedCmdlets.Keys
        $names += $module.ExportedFunctions.Keys

        if($ModuleName -eq 'AzureAD'){
            $mappingFile = (Join-Path $PSScriptRoot './AzureADToEntraMapping.json')
        }
        else{
            $mappingFile = (Join-Path $PSScriptRoot './AzureADPreviewToEntraBetaMapping.json')
        }

        $content = Get-Content -Path $mappingFile | ConvertFrom-Json

        $missingCmdletsToExport = @()

        foreach ($cmd in $names) {
            if (-not ($content.PSObject.Properties.Name -contains $cmd)) {
                $missingCmdletsToExport += $cmd
                continue
            }

            if(-not ($content.$cmd)){
                $missingCmdletsToExport += $cmd
            }
        }

        $missingCmdletsToExport
    }
}

