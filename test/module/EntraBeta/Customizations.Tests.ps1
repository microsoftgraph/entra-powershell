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
        $sourceNameMappings = @{
            "Get-AzureADMSRoleAssignment"            = "Get-AzureADMSDirectoryRoleAssignment"
            "New-AzureADMSRoleAssignment"            = "New-AzureADMSDirectoryRoleAssignment"
            "Remove-AzureADMSRoleAssignment"         = "Remove-AzureADMSDirectoryRoleAssignment"
            "Get-AzureADMSRoleDefinition"            = "Get-AzureADMSDirectoryRoleDefinition"
            "New-AzureADMSRoleDefinition"            = "New-AzureADMSDirectoryRoleDefinition"
            "Set-AzureADMSRoleDefinition"            = "Set-AzureADMSDirectoryRoleDefinition"
            "Remove-AzureADMSRoleDefinition"         = "Remove-AzureADMSDirectoryRoleDefinition"
            "Get-AzureADServiceAppRoleAssignedTo"    = "Get-AzureADServicePrincipalAppRoleAssignedTo"
            "Get-AzureADServiceAppRoleAssignment"    = "Get-AzureADServicePrincipalAppRoleAssignment"
            "New-AzureADServiceAppRoleAssignment"    = "New-AzureADServicePrincipalAppRoleAssignment"
            "Remove-AzureADServiceAppRoleAssignment" = "Remove-AzureADServicePrincipalAppRoleAssignment"
            "Add-AzureADMScustomSecurityAttributeDefinitionAllowedValues" = "Add-AzureADMScustomSecurityAttributeDefinitionAllowedValue"
            "Get-AzureADAuditDirectoryLogs" = "Get-AzureADAuditDirectoryLog"
            "Get-AzureADAuditSignInLogs" = "Get-AzureADAuditSignInLog"
        }
        $files | ForEach-Object {
            $name = $_.Name -ireplace ".ps1",""
            $name = $name -ireplace "EntraBeta","AzureAD"
            if(("Generic" -ne $name) -and ("Types" -ne $name)){
                # Write-Host "Checking nc $name"
                $value = . $_.FullName
                if ($sourceNameMappings.ContainsKey($value.SourceName)) {
                    $value.SourceName = $sourceNameMappings[$value.SourceName]
                }
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
        # Write-Host $modifiedCommands.Keys
        $files | ForEach-Object {
            $name = $_.Name -ireplace ".ps1",""
            $name = $name -ireplace "AzureAD","EntraBeta"
            if(("Generic" -ne $name) -and ("Types" -ne $name)){
                Write-Host "-----------"$name
                
                $modifiedCommands.ContainsKey($name) | Should -BeTrue
            }
        }
    }
}