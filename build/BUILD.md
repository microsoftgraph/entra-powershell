## Building module

Clone module and follow the instructions. You need **Microsoft.Graph PowerShell module installed** in order to build the module.

```powershell
git clone https://github.com/microsoftgraph/msgraph-ps-compatibility-azuread.git
cd ./Microsoft.Graph.Compatibility.AzureAD
```

### Install dependecies

This module depends on AzureAD PowerShell and Microsoft.Graph the following command install the required dependencies.

```powershell
.\build\Install-Dependencies.ps1
```


### Build

```powershell
.\build\Create-CompatModule.ps1
```


Generated module will be in the output folder `./bin/modules`

## Installing

If you want to test the generated version you can use this command

```powershell
Create-ModuleFolder
.\build\Publish-LocalCompatModule.ps1 -Clean -Install
```

This will publish the module to a local repository and install the module.

## Usage

Import the module and test the generated commands

```powershell
#If you installed the test build locally just do:
Import-Module Microsoft.Graph.Compatibility.AzureAD -Force
#If not you need to import it from the bin folder:
Import-Module .\bin\Microsoft.Graph.Compatibility.AzureAD.psd1 -Force
Connect-Graph
Get-EntraUser
```

## Testing as AzureAD

You can use the command `Set-EntraAzureADAliases` to enable alias to emulate AzureAD commands. You need to remove AzureAD to avoid collisions `Remove-Module AzureAD`

```powershell
Import-Module Microsoft.Graph.Compatibility.AzureAD -Force
Set-EntraAzureADAliases
Connect-Graph
Get-AzureADUser
```
