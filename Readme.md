## Building instructions
Clone module

```powershell
cd ./Microsoft.Graph.Compatibility.AzureAD
. ".\build\common-functions.ps1"
Remove-BuildDirectories
 . ".\build\Write-CompatModule.ps1"
Write-CompatModule -ImportModules
.\build\Create-CompatModule.ps1
```

## Usage
Import the module and test the generated commands

```powershell
Import-Module Microsoft.Graph.Compatibility.AzureAD -Force
Connect-Graph
Get-CompatADUser
```

## Aliases
You can use the command `Set-CompatADAlias` to enable alias to emulate AzureAD cmdlets.