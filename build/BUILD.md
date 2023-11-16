## Building module

Clone the module and follow the instructions below. You need **Microsoft.Graph PowerShell version 2.4** in order to build the module, you can use the scripts bellow to install the dependencies. We support building based on AzureAD or AzureADPreview.

```powershell
git clone https://github.com/microsoftgraph/entra-powershell.git
cd entra-powershell
```

### Install dependencies

This module depends on AzureAD PowerShell and Microsoft.Graph. The following command will install the required dependencies.

```powershell
# For the default install
.\build\Install-Dependencies.ps1 -ModuleName AzureAD

# Preview
.\build\Install-Dependencies.ps1 -ModuleName AzureADPreview
```

### Build
Use a clean PowerShell session when you are building the module. The buikding processs attempts to load the required versions of the module and it will fail if an other version of the dependencies are already loaded.

```powershell
.\build\Create-CompatModule.ps1 -Module AzureAD // or AzureADPreview
```

Generated module will be in the output folder `./bin`

## Installing

If you want to test the generated version you can use this command

```powershell
. .\build\Common-functions.ps1
Create-ModuleFolder
Register-LocalGallery
.\build\Publish-LocalCompatModule.ps1 -Install
Unregister-LocalGallery
```

This will publish the module to a local repository and install the module.

## Usage

Import the module and test the generated commands

```powershell
#If you installed the test build locally just do:
Import-Module Microsoft.Graph.Entra -Force
#If not, you need to import it from the bin folder:
Import-Module .\bin\Microsoft.Graph.Entra.psd1 -Force
Connect-Graph
Get-EntraUser
```

## Testing as AzureAD

You can use the command `Set-EntraAzureADAliases` to enable aliases to emulate AzureAD commands. You need to remove AzureAD to avoid collisions via the command `Remove-Module AzureAD`

```powershell
Import-Module Microsoft.Graph.Entra -Force
Set-EntraAzureADAliases
Connect-Graph
Get-AzureADUser
```
