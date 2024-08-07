# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {    
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta
    }
}



Describe 'Checking Files'{
    BeforeAll {
        $files = Get-ChildItem -Path (join-path $psscriptroot "..\..\..\module\EntraBeta\customizations") -Filter '*.ps1'        
    }

    It 'Checking naming conventios' {
        $files | ForEach-Object {
            $name = $_.Name -ireplace ".ps1",""
            $name = $name -ireplace "EntraBeta","AzureAD"
            if(("Generic" -ne $name) -and ("Types" -ne $name)){
                # Write-Host "Checking nc $name"
                $value = . $_.FullName
                $name | Should -Be ($value.SourceName -ireplace "AzureADMS","AzureAD") 
            }            
        }
    }

    It 'Checking that customizations produce commands' {
        $modifiedCommands = @{}
        $module = Get-Module Microsoft.Graph.Entra.Beta
        foreach ($key in $module.ExportedCommands.Keys) {
            $newKey = $key -replace 'AzureADMS', 'AzureAD'
            $modifiedCommands[$newKey] = $module.ExportedCommands[$key]
        }
        Write-Host $modifiedCommands.Keys
        $files | ForEach-Object {
            $name = $_.Name -ireplace ".ps1",""
            $name = $name -ireplace "AzureAD","EntraBeta"
            if(("Generic" -ne $name) -and ("Types" -ne $name)){
                Write-Host $name
                $modifiedCommands.ContainsKey($name) | Should -BeTrue
            }
        }
    }
}