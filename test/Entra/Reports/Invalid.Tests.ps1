# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if($null -eq (Get-Module -Name Microsoft.Entra.Reports)){
        Import-Module Microsoft.Entra.Reports
    }
}

Describe "Invalid Tests"{
    It "Should fail when parameters are invalid"{
        $module = Get-Module -Name Microsoft.Entra.Reports
        $module.ExportedCommands.Keys | ForEach-Object{
            $command = Get-Command $_
                { Invoke-Command $command -demo "" } | Should -Throw "A parameter cannot be found that matches parameter name 'demo'."
            }
    }
    It "Should fail with 'TenantId' parameter" {
        $module = Get-Module -Name Microsoft.Entra.Reports
        $module.ExportedCommands.Keys | ForEach-Object {
            $command = Get-Command $_
            if (($command.ParameterSets.Count -eq 1 -and $command.ParameterSets.Name -ne '__AllParameterSets') -and $command.ParameterSets.Parameters.Name -contains 'TenantId'){
                $commandScriptBlock = [scriptblock]::Create("$command -TenantId ")
                { Invoke-Command -ScriptBlock $commandScriptBlock } | Should -Throw "Missing an argument for parameter 'TenantId'.*"
            }
        }
    }
    It "Should fail with 'Id' parameter" {
        $module = Get-Module -Name Microsoft.Entra.Reports
        $module.ExportedCommands.Keys | ForEach-Object {
            $command = Get-Command $_
            if (($command.ParameterSets.Count -eq 1 -and $command.ParameterSets.Name -ne '__AllParameterSets') -and $command.ParameterSets.Parameters.Name -contains 'Id'){
                $commandScriptBlock = [scriptblock]::Create("$command -Id ")
                { Invoke-Command -ScriptBlock $commandScriptBlock } | Should -Throw "Missing an argument for parameter 'Id'.*"
            }
        }
    }
    It "Should fail with 'ObjectId' parameter" {
        $module = Get-Module -Name Microsoft.Entra.Reports
        $module.ExportedCommands.Keys | ForEach-Object {
            $command = Get-Command $_
            if (($command.ParameterSets.Count -eq 1 -and $command.ParameterSets.Name -ne '__AllParameterSets') -and $command.ParameterSets.Parameters.Name -contains 'ObjectId'){
                $commandScriptBlock = [scriptblock]::Create("$command -ObjectId ")
                { Invoke-Command -ScriptBlock $commandScriptBlock } | Should -Throw "Missing an argument for parameter 'ObjectId'.*"
            }
        }
    }
    It "Should fail with 'All' parameter" {
        $module = Get-Module -Name Microsoft.Entra.Reports
        $module.ExportedCommands.Keys | ForEach-Object {
            $command = Get-Command $_
            if (($command.ParameterSets.Count -eq 1 -and $command.ParameterSets.Name -ne '__AllParameterSets') -and $command.ParameterSets.Parameters.Name -contains 'All'){
                $commandScriptBlock = [scriptblock]::Create("$command -All `$True")
                if('Find-EntraPermission' -eq $command){
                    { Invoke-Command -ScriptBlock $commandScriptBlock } | Should -Throw "A positional parameter cannot be found that accepts argument 'True'*"
                }
                else {
                    { Invoke-Command -ScriptBlock $commandScriptBlock } | Should -Throw "A positional parameter cannot be found that accepts argument*"
                }
            }
        }
    }
    It "Should fail with 'Top' parameter" {
        $module = Get-Module -Name Microsoft.Entra.Reports
        $module.ExportedCommands.Keys | ForEach-Object {
            $command = Get-Command $_
            if (($command.ParameterSets.Count -eq 1 -and $command.ParameterSets.Name -ne '__AllParameterSets') -and $command.ParameterSets.Parameters.Name -contains 'Top'){
                $commandScriptBlock = [scriptblock]::Create("$command -Top ")
                { Invoke-Command -ScriptBlock $commandScriptBlock } | Should -Throw "Missing an argument for parameter 'Top'*"
            }
        }
    }
    It "Should fail with 'Filter' parameter" {
        $module = Get-Module -Name Microsoft.Entra.Reports
        $module.ExportedCommands.Keys | ForEach-Object {
            $command = Get-Command $_
            if (($command.ParameterSets.Count -eq 1 -and $command.ParameterSets.Name -ne '__AllParameterSets') -and $command.ParameterSets.Parameters.Name -contains 'Filter'){
                $commandScriptBlock = [scriptblock]::Create("$command -Filter ")
                { Invoke-Command -ScriptBlock $commandScriptBlock } | Should -Throw "Missing an argument for parameter 'Filter'*"
            }
        }
    }
    It "Should fail with 'SearchString' parameter" {
        $module = Get-Module -Name Microsoft.Entra.Reports
        $module.ExportedCommands.Keys | ForEach-Object {
            $command = Get-Command $_
            if (($command.ParameterSets.Count -eq 1 -and $command.ParameterSets.Name -ne '__AllParameterSets') -and $command.ParameterSets.Parameters.Name -contains 'SearchString'){
                $commandScriptBlock = [scriptblock]::Create("$command -SearchString ")
                { Invoke-Command -ScriptBlock $commandScriptBlock } | Should -Throw "Missing an argument for parameter 'SearchString'*"
            }
        }
    }      
}
