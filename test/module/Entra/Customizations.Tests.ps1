# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

BeforeAll {    
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
}


Describe 'Checking Files'{
    BeforeAll {
        $files = Get-ChildItem -Path (join-path $psscriptroot "..\..\..\module\Entra\customizations") -Filter '*.ps1'        
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
        }
        $files | ForEach-Object {
            $name = $_.Name -ireplace ".ps1",""
            $name = $name -ireplace "Entra","AzureAD"
            if(("Generic" -ne $name) -and ("Types" -ne $name)){
                Write-Host "Checking $name"
                $value = . $_.FullName
                # Dynamically update $value.SourceName based on the mappings
                if ($sourceNameMappings.ContainsKey($value.SourceName)) {
                    $value.SourceName = $sourceNameMappings[$value.SourceName]
                }
                # if($value.SourceName -eq "Get-AzureADMSRoleAssignment"){
                #     $value.SourceName = "Get-AzureADMSDirectoryRoleAssignment"
                # }
                # if($value.SourceName -eq "New-AzureADMSRoleAssignment"){
                #     $value.SourceName = "New-AzureADMSDirectoryRoleAssignment"
                # }
                # if($value.SourceName -eq "Remove-AzureADMSRoleAssignment"){
                #     $value.SourceName = "Remove-AzureADMSDirectoryRoleAssignment"
                # }
                # if($value.SourceName -eq "Remove-AzureADMSRoleAssignment"){
                #     $value.SourceName = "Remove-AzureADMSDirectoryRoleAssignment"
                # }
                # if($value.SourceName -eq "Get-AzureADMSRoleDefinition"){
                #     $value.SourceName = "Get-AzureADMSDirectoryRoleDefinition"
                # }
                # if($value.SourceName -eq "New-AzureADMSRoleDefinition"){
                #     $value.SourceName = "New-AzureADMSDirectoryRoleDefinition"
                # }
                # if($value.SourceName -eq "Set-AzureADMSRoleDefinition"){
                #     $value.SourceName = "Set-AzureADMSDirectoryRoleDefinition"
                # }
                # if($value.SourceName -eq "Remove-AzureADMSRoleDefinition"){
                #     $value.SourceName = "Remove-AzureADMSDirectoryRoleDefinition"
                # }
                # if($value.SourceName -eq "Get-AzureADServiceAppRoleAssignedTo"){
                #     $value.SourceName = "Get-AzureADServicePrincipalAppRoleAssignedTo"
                # }
                # if($value.SourceName -eq "Get-AzureADServiceAppRoleAssignment"){
                #     $value.SourceName = "Get-AzureADServicePrincipalAppRoleAssignment"
                # }
                # if($value.SourceName -eq "New-AzureADServiceAppRoleAssignment"){
                #     $value.SourceName = "New-AzureADServicePrincipalAppRoleAssignment"
                # }
                # if($value.SourceName -eq "Remove-AzureADServiceAppRoleAssignment"){
                #     $value.SourceName = "Remove-AzureADServicePrincipalAppRoleAssignment"
                # }
                

                $name | Should -Be ($value.SourceName -ireplace "AzureADMS","AzureAD")  
            }            
        }
    }

    It 'Checking that customizations produce commands' {
        $modifiedCommands = @{}
        $module = Get-Module Microsoft.Graph.Entra
        foreach ($key in $module.ExportedCommands.Keys) {
            $newKey = $key -replace 'AzureADMS', 'AzureAD'
            $modifiedCommands[$newKey] = $module.ExportedCommands[$key]
        }
        $files | ForEach-Object {
            $name = $_.Name -ireplace ".ps1",""
            $name = $name -ireplace "AzureAD","Entra"
            if(("Generic" -ne $name) -and ("Types" -ne $name)){
                $modifiedCommands.ContainsKey($name) | Should -BeTrue
            }
        }
    }
}