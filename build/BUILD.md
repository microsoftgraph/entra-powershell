## Building module

Clone the module and follow the instructions described. You need **Microsoft.Graph PowerShell version 2.4** in order to build the module.

```powershell
git clone https://github.com/microsoftgraph/entra-powershell.git
cd entra-powershell
```

### Install dependencies

This module depends on some Microsoft Graph PowerShell modules. The following command installs the required dependencies.

```powershell
# Install dependencies required to build the Microsoft Entra PowerShell General Availability (GA)
.\build\Install-Dependencies.ps1 -ModuleName Entra
```

or

```powershell
# Install the dependencies for the Microsoft Entra PowerShell preview
.\build\Install-Dependencies.ps1 -ModuleName EntraBeta
```
### Build help
The module help files are generated from markdown documentation (using platyPS module). To install PlatyPS module, run the command `Install-Module -Name PlatyPS`.

```powershell
# Install PlatyPS module
Install-Module -Name PlatyPS
```

```powershell
# Build help module for the Microsoft Entra Module
. .\build\Common-functions.ps1
Create-ModuleHelp -Module Entra // or EntraBeta for the preview version
```
### Build module
Use a clean PowerShell session when you're building the module. The building process attempts to load the required versions of the module, which fails if another version of the dependencies is already loaded.

```powershell
.\build\Create-CompatModule.ps1 -Module Entra // or EntraBeta
```

The generated module is in the output folder `./bin`
In order to import it, you need to run `Import-Module .\bin\Microsoft.Graph.Entra.psd1 -Force`

## Usage

Import the module and test the generated commands.

```powershell
Import-Module .\bin\Microsoft.Graph.Entra.psd1 -Force
Connect-MgGraph -Scopes "User.Read.All"
Get-EntraUser -Top 10
```

> [!TIP]
> If you are using PowerShell 5.1, you may experience the error `Function <cmdlet-name> cannot be created because function capacity 4096 has been exceeded for this scope`. To fix this error, run the command: `$MaximumFunctionCount=32768`, then retry importing the module again.

```powershell
$MaximumFunctionCount=32768
```

## Testing as AzureAD PowerShell module

For migration scenarios (if you have a script with AzureAD commands), you can use the command `Enable-EntraAzureADAlias` to enable aliases to emulate AzureAD PowerShell module commands. You need to remove AzureAD and AzureAD Preview modules to avoid collisions via the command `Remove-Module AzureAD` or `Remove-Module AzureADPreview`

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
