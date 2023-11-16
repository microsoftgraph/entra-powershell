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
In order to import it you just need to run `Import-Module .\bin\Microsoft.Graph.Entra.psd1 -Force`

## Usage

Import the module and test the generated commands

```powershell
Import-Module .\bin\Microsoft.Graph.Entra.psd1 -Force
Connect-Graph
Get-EntraUser
```

## Testing as AzureAD

You can use the command `Set-EntraAzureADAliases` to enable aliases to emulate AzureAD commands. You need to remove AzureAD to avoid collisions via the command `Remove-Module AzureAD`

```powershell
Set-EntraAzureADAliases
Connect-Graph
Get-AzureADUser
```

## Installing

Installing is an optional task that is only recommended if you are testing with automation that will try to load the module form the default powershell modules folder, otherwise for local build test is recommend to load directly from the `bin` folder.

```powershell
. .\build\Common-functions.ps1
Create-ModuleFolder
Register-LocalGallery
.\build\Publish-LocalCompatModule.ps1 -Install
Unregister-LocalGallery
#When you install you can now just load the module without the Path to the files.
Import-Module Microsoft.Graph.Entra.psd1 -Force
```

This will publish the module to a local repository and install the module.

