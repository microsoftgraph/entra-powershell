## Building module

Clone the module and follow the instructions described. You need **Microsoft.Graph PowerShell version 2.25.X** in order to build the module.

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

Or

```powershell
# Install the dependencies for the Microsoft Entra PowerShell preview
.\build\Install-Dependencies.ps1 -ModuleName EntraBeta
```

> [!TIP]
> If you encounter Execution Policies error, run the command `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`.

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

<details>

<summary>v1.0 version</summary>

### Build v1.0 module

```powershell
. .\build\Common-functions.ps1
.\build\Create-EntraModule.ps1 -Module 'Entra'
.\build\Create-EntraModule.ps1 -Module 'Entra' -Root
Import-Module .\bin\Microsoft.Entra.Authentication.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Applications.psd1 -Force
Import-Module .\bin\Microsoft.Entra.DirectoryManagement.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Governance.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Users.psd1 -Force
Import-Module .\bin\Microsoft.Entra.CertificateBasedAuthentication.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Groups.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Reports.psd1 -Force
Import-Module .\bin\Microsoft.Entra.SignIns.psd1 -Force
Import-Module .\bin\Microsoft.Entra.psd1 -Force
```

</details>

<details>

<summary>Beta version</summary>

### Build Beta module

```powershell
. .\build\Common-functions.ps1
.\build\Create-EntraModule.ps1 -Module 'Entra'
.\build\Create-EntraModule.ps1 -Module 'Entra' -Root
Import-Module .\bin\Microsoft.Entra.Authentication.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Applications.psd1 -Force
Import-Module .\bin\Microsoft.Entra.DirectoryManagement.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Governance.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Users.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Groups.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Reports.psd1 -Force
Import-Module .\bin\Microsoft.Entra.SignIns.psd1 -Force
Import-Module .\bin\Microsoft.Entra.psd1 -Force
```

</details>

The generated module is in the output folder `./bin`

## Usage

```powershell
Connect-Entra -Scopes "User.Read.All"
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
Import-Module .\bin\Microsoft.Entra.Users.psd1 -Force
Enable-EntraAzureADAlias
Connect-Entra
Get-AzureADUser -Top 1
```

## Full script

<details>

<summary>Full script for v1.0 version</summary>

### Build v1.0 module

```powershell
.\build\Install-Dependencies.ps1 -ModuleName Entra
Install-Module -Name PlatyPS
. .\build\Common-functions.ps1
Create-ModuleHelp -Module Entra
.\build\Create-EntraModule.ps1 -Module 'Entra'
.\build\Create-EntraModule.ps1 -Module 'Entra' -Root
Import-Module .\bin\Microsoft.Entra.Authentication.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Applications.psd1 -Force
Import-Module .\bin\Microsoft.Entra.DirectoryManagement.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Governance.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Users.psd1 -Force
Import-Module .\bin\Microsoft.Entra.CertificateBasedAuthentication.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Groups.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Reports.psd1 -Force
Import-Module .\bin\Microsoft.Entra.SignIns.psd1 -Force
Import-Module .\bin\Microsoft.Entra.psd1 -Force
```

</details>

<details>

<summary>Full script for Beta version</summary>

### Build Beta module

```powershell
.\build\Install-Dependencies.ps1 -ModuleName EntraBeta
Install-Module -Name PlatyPS
. .\build\Common-functions.ps1
Create-ModuleHelp -Module EntraBeta
.\build\Create-EntraModule.ps1 -Module 'EntraBeta'
.\build\Create-EntraModule.ps1 -Module 'EntraBeta' -Root
Import-Module .\bin\Microsoft.Entra.Beta.Authentication.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Beta.Applications.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Beta.DirectoryManagement.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Beta.Governance.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Beta.Users.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Beta.Groups.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Beta.Reports.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Beta.SignIns.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Beta.NetworkAccess.psd1 -Force
Import-Module .\bin\Microsoft.Entra.Beta.psd1 -Force
```

</details>

## Installing a test version (Optional)

Install a test version (optional), which is recommended if you're trying to test with automation, which tries to load the module from the default PowerShell modules folder.

```powershell
. .\build\Common-functions.ps1
Create-ModuleFolder
Register-LocalGallery
.\build\Publish-LocalCompatModule.ps1 -Install
#When you install, you can load the module without the Path to the files.
Import-Module Microsoft.Entra -Force
```

The snippet in the optional testing section publishes the module to a local repository and installs the module.

To unregister or remove a locally registered gallery, run:

```PowerShell
Unregister-LocalGallery
```

## FAQs

1. Installation error: `cannot be loaded because running scripts is disabled on this system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170.`

To solve this error, run the command:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

1. Installation error: `Function <cmdlet-name> cannot be created because function capacity 4096 has been exceeded for this scope.`

To solve this error, run the command:

```powershell
$MaximumFunctionCount=32768
```

Or

Use the latest version of PowerShell 7+ as the runtime version (highly recommended).

1. Build Help error: `New-ExternalHelp : The term 'New-ExternalHelp' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.`.

To solve this error, install PlatyPS module by running the command:

```powershell
Install-Module -Name PlatyPS
```
