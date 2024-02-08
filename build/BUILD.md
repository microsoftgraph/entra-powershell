## Building module

Clone the module and follow the instructions described. You need **Microsoft.Graph PowerShell version 2.4** in order to build the module. We support building based on AzureAD or AzureADPreview PowerShell modules.

```powershell
git clone https://github.com/microsoftgraph/entra-powershell.git
cd entra-powershell
```

### Install dependencies

This module depends on AzureAD PowerShell and Microsoft.Graph. The following command installs the required dependencies.

```powershell
# For the default install
.\build\Install-Dependencies.ps1 -ModuleName AzureAD
```
To install the preview version, run the command:

```powershell
.\build\Install-Dependencies.ps1 -ModuleName AzureADPreview
```
### Build help
The module help files are generated from markdown documentation (using platyPS module). To install PlatyPS module, run the command `Install-Module -Name PlatyPS`.

```powershell
. .\build\Common-functions.ps1
Create-ModuleHelp -Module Entra // or EntraBeta
```
### Build module
Use a clean PowerShell session when you're building the module. The building process attempts to load the required versions of the module, which fails if another version of the dependencies is already loaded.

```powershell
.\build\Create-CompatModule.ps1 -Module Entra // or EntraBeta
```

Generated module is in the output folder `./bin`
In order to import it, you need to run `Import-Module .\bin\Microsoft.Graph.Entra.psd1 -Force`

## Usage

Import the module and test the generated commands.

```powershell
Import-Module .\bin\Microsoft.Graph.Entra.psd1 -Force
Connect-Graph
Get-EntraUser
```

## Testing as AzureAD PowerShell module

You can use the command `Enable-EntraAzureADAlias` to enable aliases to emulate AzureAD PowerShell module commands. You need to remove Entra to avoid collisions via the command `Remove-Module Entra`

```powershell
Enable-EntraAzureADAlias
Connect-Graph
Get-AzureADUser
```

## Installing a test version (Optional)

Install a test version (optional), which is recommended if you're trying to test with automation, which tries to load the module from the default PowerShell modules folder.

```powershell
. .\build\Common-functions.ps1
Create-ModuleFolder
Register-LocalGallery
.\build\Publish-LocalCompatModule.ps1 -Install
Unregister-LocalGallery
#When you install, you can load the module without the Path to the files.
Import-Module Microsoft.Graph.Entra.psd1 -Force
```

The snippet in the optional testing section publishes the module to a local repository and installs the module.

## FAQs

1. Installation error: `cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.`

To solve this error, run the command:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

2. Installation error: `Function <cmdlet-name> cannot be created because function capacity 4096 has been exceeded for this scope.`

To solve this error, run the command:

```powershell
$MaximumFunctionCount=32768
```

or

Use the latest version of PowerShell 7+ as the runtime version (highly recommended).

3. Build Help error: `New-ExternalHelp : The term 'New-ExternalHelp' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again. `.

To solve this error, install PlatyPS module by running the command below:

```powershell
Install-Module -Name PlatyPS
```
