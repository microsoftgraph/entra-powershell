# Entra PowerShell

This project generates commands using legacy modules as baseline(AzureAD/AzureAD Preview PowerShell) and map them into other input modules(Microsoft Graph PowerShell SDK) for similar commands base on Nouns assuming that same Noun will have similar behavior, then do the same for the parameters of each of the found commands. Initially commands are complexly auto-generated, but there is ways to customize commands, please check our contribute guide.

The code is organized in class having the principal class being `CompatibilityAdapterBuilder` having all the logic required to translate the command the other class a support data structures. The `CompatibilityAdapter.ps1` dot source all the required files in the required order in case you need to use the class. The code was designed to translate between AzureAD and Microsoft Graph PowerShell but can be use in other cases.

## Usage

```Powershell
. (join-path $psscriptroot "../src/CompatibilityAdapter.ps1")
$mapper = [CompatibilityAdapterBuilder]::new()
$map.GenerateModuleFiles()
```
