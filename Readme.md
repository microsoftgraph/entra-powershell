# Microsoft Graph Compatibility Adapter for AzureAD PowerShell

Microsoft Graph Compatibility Adapter is a collection of commands that emulates the behavior of the legacy AzureAD PowerShell Module.
This Moduse use [Microsoft Graph PowerShell SDK](https://github.com/microsoftgraph/msgraph-sdk-powershell) to make the calls to [Microsoft Graph](http://microsoft.graph.com).
**This module is under development NOT READY for Production dependency.**

## Building module

Clone module and follow the instructions

```powershell
cd ./Microsoft.Graph.Compatibility.AzureAD
.\build\Create-CompatModule.ps1
```

Generated module will be in the output folder `./bin/modules`

## Installing

If you want to test the generated version you can use this command

```powershell
.\build\Publish-LocalCompatModule.ps1 -Clean -Install
```

This will publish the module to a local repository and install the module.

## Usage

Import the module and test the generated commands

```powershell
Import-Module Microsoft.Graph.Compatibility.AzureAD -Force
Connect-Graph
Get-CompatADUser
```

## Testing as AzureAD

You can use the command `Set-CompatADAlias` to enable alias to emulate AzureAD commands. You need to remove AzureAD to avoid collisions `Remove-Module AzureAD`

```powershell
Import-Module Microsoft.Graph.Compatibility.AzureAD -Force
Set-CompatADAlias
Connect-Graph
Get-AzureADUser
```
