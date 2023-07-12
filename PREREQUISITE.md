# Prerequisites

The main prerequisite for this module to work is having the right version of Microsoft Graph PowerShell SDK, for this release the module requires version 2.0.0 or higher.

Microsoft Graph PowerShell SDK has it own [Prerequesites](https://learn.microsoft.com/en-us/powershell/microsoftgraph/installation?view=graph-powershell-1.0#prerequisites).

This module does not require the full SDK only this modules:

- Microsoft.Graph.DirectoryObjects
- Microsoft.Graph.Users
- Microsoft.Graph.Users.Actions
- Microsoft.Graph.Users.Functions
- Microsoft.Graph.Groups
- Microsoft.Graph.Identity.DirectoryManagement
- Microsoft.Graph.Identity.Governance
- Microsoft.Graph.Identity.SignIns
- Microsoft.Graph.Applications

## Installing a preview version on PS 5.1

For Windows PowerShell user you need to update you tools to allow prerelease version.

```
Install-Module -Name PackageManagement -Repository PSGallery -Force
Install-Module -Name PowerShellGet -Repository PSGallery -Force
```

## Known problems

If you are getting this error:

```
Install-Module : The 'Install-Module' command was found in the module 'PowerShellGet', but the module could not be load
ed. For more information, run 'Import-Module PowerShellGet'.

```

Users may need to change the execution policy `Set-ExecutionPolicy Unrestricted`. 

You can get more information on the topic here Docs regarding excecution policy [here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy)
