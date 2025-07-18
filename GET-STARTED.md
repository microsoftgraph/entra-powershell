---
title: Microsoft Entra PowerShell installation and usage guide.
description: Microsoft Entra PowerShell installation and usage guide.


ms.topic: reference
ms.date: 02/03/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
---

# Get Started

Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Reporting Issues](#reporting-issues-and-feedback)
- [Telemetry](#telemetry)
- [Contributing](#contributing)

## Installation

### PowerShell Gallery

Run the following command in a PowerShell session to install the Microsoft Entra PowerShell module:

```powershell
Install-Module -Name Microsoft.Entra -Repository PSGallery -Scope CurrentUser -Force -AllowClobber
```

To install the `beta` module, use:

```powershell
Install-Module -Name Microsoft.Entra.Beta -Repository PSGallery -Scope CurrentUser -Force -AllowClobber
```

[The latest version of PowerShell 7][PowerShellCore] is the recommended version of PowerShell for
use with the Microsoft Entra PowerShell module on all platforms including Windows, Linux, and macOS. This module
also runs on Windows PowerShell 5.1 with [.NET Framework 4.7.2][DotNetFramework] or higher.

If you have an earlier version of the Microsoft Entra PowerShell module installed from the PowerShell Gallery
and would like to update to the latest version, run the following command in a PowerShell session:

```powershell
Update-Module -Name Microsoft.Entra -Force
```

`Update-Module` installs the new version side-by-side with previous versions. It doesn't uninstall
the previous versions.

For more information on installing Microsoft Entra PowerShell, see the
[installation guide][InstallationGuide].

### Building the module locally

For preview features, you can build the module locally from GitHub source code. See [Build module locally](./build/BUILD.md).

## Usage

### Sign in

To connect to Microsoft Entra ID, use the [`Connect-Entra`][Connect-Entra] cmdlet:

```powershell
# Opens a new browser window to log into your Microsoft Entra ID account.
Connect-Entra -Scopes 'User.Read.All', 'Group.ReadWrite.All'
```

For details on authentication scenarios: delegated (interactive) or app-only (noninteractive), see [Authentication scenarios][authentication-scenarios].

### Sign in to a national cloud

To log into a specific cloud national cloud, use the `Environment` parameter:

```powershell
# Log into a specific cloud, for example the Azure China cloud.
Connect-Entra -Environment China
```

To get a list of available environments, run:

```powershell
Get-EntraEnvironment
```

### Discovering cmdlets

Use `Get-Command` to discover cmdlets within a specific module, or cmdlets that follow a specific
search pattern:

```powershell
# List all cmdlets in the Microsoft Entra PowerShell module
Get-Command -Module Microsoft.Entra*
```

To narrow this down, for instance, to find commands related to applications, run the following command.

```powershell
Get-Command -Module Microsoft.Entra* -Noun *application*
```

### Cmdlet help and examples

To view the help content for a cmdlet, use the `Get-Help` cmdlet:

```powershell
# View basic help information for Get-EntraUser
Get-Help -Name Get-EntraUser

# View the examples for Get-EntraUser
Get-Help -Name Get-EntraUser -Examples

# View the full help for Get-EntraUser
Get-Help -Name Get-EntraUser -Full
```

### Run commands with `-Debug` option

To gain insights into the calls being made, you can add `-debug` option.

```powershell
Get-EntraUser -SearchString 'Adele' -Debug
```

To send debug output stream to a log file, use:

```powershell
Get-EntraUser -Top 1 -Debug 5>> <your-log-filepath>
```

For more information, see [documentation guide][debug-guide].

### Migrate from Azure AD

The [Enable-EntraAzureADAlias][enable-entraazureadalias] cmdlet enables compatibility mode through aliases. By default, `Enable-EntraAzureADAlias` only enables compatibility aliases for the current PowerShell session. For more information, see the [migration guide][migrationGuideLink].

#### Testing compatibility of a script

You can use the `Test-EntraScript` command to test compatibility of an AzureAD PowerShell module-based script. This helps determine if a script can be migrated to the Microsoft Entra PowerShell module.

```powershell
Test-EntraScript -Script .\export-apps-with-expiring-secrets.ps1
```

If the script is compatible, you won't see any output, although you can use `$?` to display that True was returned. If the script isn't compatible, a warning with details of the issues is displayed. Example:

```powershell
Test-EntraScript -Script .\export-apps-with-expiring-secrets.ps1

WARNING: Command Get-AzureADApplicationKeyCredential is not supported
WARNING: Script contains commands that are not supported by the compatibility adapter.
```

> [!TIP]
> You can access the `export-apps-with-expiring-secrets.ps1` from our [samples page](./samples/export-apps-with-expiring-secrets.ps1).

### Pipelining feature

With Pipelining, you can perform updates from the output of another command as inputs. For example, updating the Postal Code address for all group members after a reporting line changes.

```powershell
Get-EntraGroup -Filter "DisplayName eq 'Contoso Team'" | Get-EntraGroupMember | Set-EntraUser -PostalCode 90134 
```

## Reporting Issues and Feedback

### Issues

If you find any bugs when using Microsoft Entra PowerShell, file an issue in our [GitHub repo][GitHubRepo].
Fill out the issue template with the appropriate information. We value your feedback.

## Contributing

For details on contributing to this repository, see the [contributing guide](CONTRIBUTING.md)

## Data Collection

Microsoft Entra PowerShell collects telemetry data by default. We collection information about the `Microsoft Entra PowerShell version` and the `cmdlet` executed. Microsoft aggregates collected data to identify patterns of usage to identify common issues and to improve the experience of Microsoft Entra PowerShell. Microsoft Entra PowerShell doesn't collect any private or personal data. For example, the usage data helps identify issues such as cmdlets with low success and helps prioritize our work.

## Learn more

- [Get Started][GettingStartedGuide]
- [Migration guide][migrationGuideLink]
- [Navigating the module][navigate-the-module]
- [Versioning and release cadence][versioning-and-release-cadence]

[DotNetFramework]: https://dotnet.microsoft.com/download/dotnet-framework-runtime
[PowerShellCore]: https://github.com/PowerShell/PowerShell/releases/latest
[InstallationGuide]: https://learn.microsoft.com/powershell/entra-powershell/installation
[GettingStartedGuide]: https://learn.microsoft.com/powershell/entra-powershell/quickstart-entra-powershell
[Connect-Entra]:https://learn.microsoft.com/powershell/module/microsoft.entra/connect-entra
[authentication-scenarios]:https://learn.microsoft.com/powershell/entra-powershell/authentication-scenarios
[GitHubRepo]: https://aka.ms/entra/ps/issues
[debug-guide]: https://learn.microsoft.com/powershell/entra-powershell/entra-powershell-best-practices#use-the-debug-option
[migrationGuideLink]: https://learn.microsoft.com/powershell/entra-powershell/migration-guide
[enable-entraazureadalias]: https://learn.microsoft.com/powershell/module/microsoft.entra/enable-entraazureadalias
[versioning-and-release-cadence]: https://learn.microsoft.com/powershell/entra-powershell/entraps-versioning-release-cadence
[navigate-the-module]: https://learn.microsoft.com/powershell/entra-powershell/navigate-entra-powershell
