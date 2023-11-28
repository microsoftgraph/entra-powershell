## Building module

Clone the module and follow the instructions below. You need **Microsoft.Graph PowerShell version 2.4** in order to build the module, you can use the scripts below to install the dependencies. We support building based on AzureAD or AzureADPreview.

```powershell
git clone https://github.com/microsoftgraph/entra-powershell.git
cd entra-powershell
```

### Install dependencies

This module depends on AzureAD PowerShell and Microsoft.Graph. The following command will install the required dependencies.

```powershell
# For the default install
.\build\Install-Dependencies.ps1 -ModuleName AzureAD
```
To install the preview version, run the command below.

```powershell
.\build\Install-Dependencies.ps1 -ModuleName AzureADPreview
```

### Build
Use a clean PowerShell session when you are building the module. The building process attempts to load the required versions of the module, which will fail if another version of the dependencies is already loaded.

```powershell
.\build\Create-CompatModule.ps1 -Module AzureAD // or AzureADPreview
```

Generated module will be in the output folder `./bin`
In order to import it, you need to run `Import-Module .\bin\Microsoft.Graph.Entra.psd1 -Force`

## Usage

Import the module and test the generated commands.

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

## Installing a test version

Installing a test version is an optional task and only recommended if you are trying to test with automation that will try to load the module from the default PowerShell modules folder.

```powershell
. .\build\Common-functions.ps1
Create-ModuleFolder
Register-LocalGallery
.\build\Publish-LocalCompatModule.ps1 -Install
Unregister-LocalGallery
#When you install, you can load the module without the Path to the files.
Import-Module Microsoft.Graph.Entra.psd1 -Force
```

This will publish the module to a local repository and install the module.

