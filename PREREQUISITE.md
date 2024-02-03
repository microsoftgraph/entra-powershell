# Prerequisites

The main prerequisite for this module is having the right version of Microsoft Graph PowerShell SDK. For this release, the module requires version 2.0.0 or higher.

Microsoft Graph PowerShell SDK has its own [Prerequesites](https://learn.microsoft.com/powershell/microsoftgraph/installation#prerequisites).

This module does not require the full SDK, only these modules:

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

For Windows PowerShell users, you must update your tools to allow the prerelease version.

```
Install-Module -Name PackageManagement -Repository PSGallery -Force
Install-Module -Name PowerShellGet -Repository PSGallery -Force
```

## Known problems

If you are getting this error:

```
Install-Module: The 'Install-Module' command was found in the module 'PowerShellGet', but the module could not be load
ed. For more information, run 'Import-Module PowerShellGet'.

```

Users may need to change the execution policy `Set-ExecutionPolicy Unrestricted`. 

You can get more information regarding execution policy [here](https://learn.microsoft.com/powershell/module/microsoft.powershell.security/set-executionpolicy)
