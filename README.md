---
title: About Microsoft Entra PowerShell.
description: About Microsoft Entra PowerShell.

ms.service: active-directory
ms.topic: reference
ms.date: 11/29/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
---
# Microsoft Entra PowerShell

The Microsoft Entra PowerShell is a collection of cmdlets that helps access Microsoft Entra resources using the [Microsoft Graph SDK](https://github.com/microsoftgraph/msgraph-sdk-powershell). The module primarily functions as a usability layer with human-readable parameters, deliberate parameter set specification, inline documentation, and core PowerShell fundamentals like pipelining.

While the Microsoft Entra PowerShell module provides significant compatibility with the legacy modules (such as Azure AD PowerShell), that can accelerate migration to Microsoft Graph as a significant benefit, the Microsoft Entra module remains as a long-term, perpetual product offering.

<p align="center">
   <a href="MOTIVATION.md">Our Motivation</a> |
  <a href="#installation">Installation</a> |
  <a href="#usage">Usage</a> |
  <a href="#contributing">Contributing</a> |
  <a href="#known-issues">Known Issues</a> |
  <a href="#license">License</a>
</p>

<p align="center">
<strong>This module is under development. It's NOT READY for Production environments.</strong>
</p>

## Installation

### Prerequisites

This module depends on the [Microsoft Graph PowerShell SDK](https://github.com/microsoftgraph/msgraph-sdk-powershell#readme). Some modules need to be installed for this module to work. Check the prerequisites [here](https://github.com/microsoftgraph/entra-powershell/blob/main/PREREQUISITE.md).

### Local Build

Refer to [local building and installing guide](https://github.com/microsoftgraph/entra-powershell/blob/main/build/BUILD.md).

### PowerShell Gallery

[![PSGallery Version](https://img.shields.io/powershellgallery/v/Microsoft.Graph.Entra.svg?style=flat&logo=powershell&label=PSGallery%20Version)](https://www.powershellgallery.com/packages/Microsoft.Graph.Entra)
[![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/Microsoft.Graph.Entra.svg?style=flat&logo=powershell&label=PSGallery%20Downloads)](https://www.powershellgallery.com/packages/Microsoft.Graph.Entra)

> [!NOTE]
> The Microsoft Entra PowerShell module will be published on the [PowerShell Gallery](https://www.powershellgallery.com/packages/Microsoft.Graph.Entra) post-private preview stage. Kindly use the "Local Build" option in the interim.

## Usage

1. Importing the module

```powershell
Import-Module Microsoft.Graph.Entra -Force
```

1. Authentication

To see all the possible options, refer to [MS Graph SDK authentication](https://github.com/microsoftgraph/msgraph-sdk-powershell/blob/dev/README.md#usage).

```powershell
 Connect-MgGraph
```

1. Using commands

Here's an example that emulates the Azure AD module's Get-AzureADUser with a Microsoft Graph call:

```powershell
Get-EntraUser -SearchString "Joe" 
```

This example gives you more insight into the calls being made:

```powershell
Get-EntraUser -SearchString "Joe" -Debug
```

1. Aliasing Azure AD PowerShell commands

Running the `Set-EntraAzureADAliases` cmdlet creates aliases for all of the supported Azure AD PowerShell cmdlets in the Microsoft Entra PowerShell module:

```powershell
Set-EntraAzureADAliases
```

This command shows you all of the newly created aliases:

```powershell
Get-Alias -Name *AzureAd*
```

You can now run the Azure AD PowerShell cmdlet using an alias, which calls the Microsoft Graph PowerShell under the hood.

```powershell
Get-AzureADUser -SearchString "Jane" 
```

This example gives you more insight into the calls being made:

```powershell
Get-AzureADUser -SearchString "Jane" -Debug
```

**NB - removing the AzureAD module, if installed, is recommended to avoid collisions.**

```powershell
Remove-Module AzureAD
```

1. Running a legacy PowerShell module script with the Microsoft Entra PowerShell module

You can use the Microsoft Entra PowerShell to test an AzureAD PowerShell module-based script. This helps determine if a script can be migrated to the Microsoft Graph PowerShell SDK.

```powershell
Test-EntraScript -Script .\Export_secrets_and_certificates_for_app_registrations.ps1
```

If the script is compatible, you won't see any output, although you can use `$?` to display that True was returned. If the script isn't compatible, you'll see a warning with details of the problem cmdlet(s). Example:

```powershell
Test-EntraScript -Script .\Export_secrets_and_certificates_for_app_registrations.ps1

WARNING: Command Get-AzureADApplicationKeyCredential is not supported
WARNING: Script contains commands that are not supported by the compatibility adapter.
```

## Repository Visibility Notice
>
> [!IMPORTANT]  
> Important: This repository is private, and its contents are not visible to the public. Please be aware that we plan to convert this repository to public status in the near future (from the Public Preview stage).

**What does this mean?**

Once the repository becomes public:

- All code, issues, and discussions will be visible to everyone.
- Any messages or comments you make on issues, pull requests, or other discussions will be publicly accessible.
- Any issues submitted privately will become visible to the public.

**Why are we making it public?**

We believe in transparency and collaboration. By making this repository public, we aim to foster an open environment where developers and users can learn from each other.

**How can I provide feedback or raise concerns?**

Feel free to use the GitHub issue tracker to report any concerns, ask questions, or provide feedback. We value your input and we'll address any issues as soon as possible.

## Contributing

To contribute, check [contribution guide](https://github.com/microsoftgraph/entra-powershell/blob/main/CONTRIBUTING.md).

## Known Issues

- Some properties names change between the Azure AD PowerShell module and Microsoft Graph endpoints:
  - Parameter -Filter might not work correctly
  - Parameter -SearchString don't currently work
  - Output objects might be different

## Issues

If you find any bugs when using the Microsoft Entra PowerShell module, file an issue on our [GitHub issues](https://github.com/microsoftgraph/entra-powershell/issues) page.

This project adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information, see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) for questions or comments.

## License

Copyright (c) Microsoft Corporation. All Rights Reserved. Licensed under the MIT [license](LICENSE.txt).
