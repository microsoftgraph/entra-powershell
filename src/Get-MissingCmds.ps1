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
        # AzureAD and AzureADPreview modules have been deprecated and removed from
        # PowerShell Gallery. Use the static mapping files as the source of truth
        # for the complete list of commands instead of importing the module.
        if($ModuleName -eq 'AzureAD'){
            $mappingFile = (Join-Path $PSScriptRoot './AzureADToEntraMapping.json')
        }
        else{
            $mappingFile = (Join-Path $PSScriptRoot './AzureADPreviewToEntraBetaMapping.json')
        }

        $content = Get-Content -Path $mappingFile | ConvertFrom-Json
        $names = @($content.PSObject.Properties.Name)

        $missingCmdletsToExport = @()

        foreach ($cmd in $names) {
            if(-not ($content.$cmd)){
                $missingCmdletsToExport += $cmd
            }
        }

        $missingCmdletsToExport
    }
}

