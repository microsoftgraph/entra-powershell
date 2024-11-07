### Building module

Clone the module and follow the instructions described. You need **Microsoft.Graph PowerShell version 2.15.X** in order to build the module.

```powershell
git clone https://github.com/microsoftgraph/entra-powershell.git
cd entra-powershell

```

### Checkout the Modularization Feature Branch

git pull
git checkout modularize

### Install dependencies

This module depends on some Microsoft Graph PowerShell modules. The following command installs the required dependencies.

```powershell
# Install dependencies required to build the Microsoft Entra PowerShell General Availability (GA)
.\build\Install-Dependencies.ps1 -ModuleName Entra
```

Or

```powershell
# Install the dependencies for the Microsoft Entra PowerShell preview
.\build\Install-Dependencies.ps1 -ModuleName EntraBeta
```

> [!TIP]
> If you encounter Execution Policies error, run the command `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`.

### Install PlatyPS

The module help files are generated from markdown documentation (using platyPS module). To install PlatyPS module, run the command `Install-Module -Name PlatyPS`.

```powershell
# Install PlatyPS module
Install-Module -Name PlatyPS
```

### Split Legacy Module

If you've made any changes to the legacy module e.g. Any files under `.\module` directory.

1. Build the legacy module.

```powershell
# Build help module for the Microsoft Entra Module
. .\build\Common-functions.ps1
Create-ModuleHelp -Module Entra // or EntraBeta for the preview version

# Rebuild the legacy module
.\build\Create-CompatModule.ps1 -Module Entra // or EntraBeta
```

2. Split the legacy module into functions .ps1 files into the respective sub-module directories.

```powershell
  .\build\Split-EntraModule.ps1 -Module 'Entra' 

```

If NO CHANGES have been made to the `.\module`, then proceed and build the vNext Module

```powershell
  .\build\Split-EntraModule.ps1 -Module 'Entra' 

```

This will ensure that the cmdlet function files are moved to the right sub-module directory under `.\moduleVNext` directory.

### Build vNext module

Use a clean PowerShell session when you're building the module. The building process attempts to load the required versions of the module, which fails if another version of the dependencies is already loaded.

```powershell
.\build\Create-CreateModule.ps1 -Module Entra // or EntraBeta
```

The generated modules are in the output folder `./bin`

SubModule in this case is the name of the specific sub-module you want to use. They are: `Authentication,Users,DirectoryManagement, Groups, Applications,Governance,SignIns and Reports`

In order to import it, you need to run `Import-Module .\bin\Microsoft.Graph.Entra.<SubModule>psd1 -Force`

Alternatively, import the root module(that encompases and includes all the sub-modules and their help and dependencies) `Import-Module .\bin\Microsoft.Graph.Entra.psd1 -Force`

## Usage

Import the module and test the generated commands.

```powershell
Import-Module .\bin\Microsoft.Graph.Entra.<SubModule>.psd1 -Force
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

Or

Use the latest version of PowerShell 7+ as the runtime version (highly recommended).

3. Build Help error: `New-ExternalHelp : The term 'New-ExternalHelp' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.`.

To solve this error, install PlatyPS module by running the command:

```powershell
Install-Module -Name PlatyPS
```
