---
title: About Microsoft Entra PowerShell
description: About Microsoft Entra PowerShell


ms.topic: reference
ms.date: 02/03/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
---

[![PSGallery Version](https://img.shields.io/powershellgallery/v/Microsoft.Entra.svg?style=flat&logo=powershell&label=PSGallery%20Version)](https://www.powershellgallery.com/packages/Microsoft.Entra)
[![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/Microsoft.Entra.svg?style=flat&logo=powershell&label=PSGallery%20Downloads)](https://www.powershellgallery.com/packages/Microsoft.Entra)
[![PSGallery Platform](https://img.shields.io/powershellgallery/p/Microsoft.Entra.svg?style=flat&logo=powershell&label=PSGallery%20Platform)](https://www.powershellgallery.com/packages/Microsoft.Entra)
[![GitHub issues](https://img.shields.io/github/issues/microsoftgraph/entra-powershell)](https://github.com/microsoftgraph/entra-powershell/issues)

# Microsoft Entra PowerShell

[Microsoft Entra PowerShell][learn.microsoft], is a command-line tool that allows administrators and developers to manage and automate Microsoft Entra resources programmatically. This module is developed based on customer feedback to meet usability needs. Microsoft Entra PowerShell is meticulously designed to deliver a delightful, usable, and high-quality collection of PowerShell cmdlets for Entra administrators.

The module offers human-readable parameters, deliberate parameter set specification, inline documentation, and core PowerShell fundamentals like pipelining. The module builds upon the Microsoft Graph PowerShell SDK. It’s fully interoperable with all cmdlets in the Microsoft Graph PowerShell SDK.

The module also offers a backward compatibility option to streamline migration from the [retiring AzureAD PowerShell module][azureADRetirement]. Microsoft Entra PowerShell works with Windows PowerShell 5.1 and PowerShell 7+. For the best experience on Windows, Linux, and macOS, we recommend using PowerShell 7 or later.

## Modules

The following table contains a list of the Microsoft Entra PowerShell modules.

| Module                                          | Latest                          | Description  |
|------------------------------------------------|--------------------------------|--------------|
| [`Microsoft.Entra`][entrapsgallery]           | [![mg]][entrapsgallery]        | v1.0 Module  |
| [`Microsoft.Entra.Beta`][entrapsgallerybeta]  | [![mgbeta]][entrapsgallerybeta] | Beta Module  |

## Roadmap

Explore what's coming next on our [public roadmap][public-roadmap] ✨ and [share your suggestions][suggestions] with us!

## Learn more

<p align="center">
   <a href="MOTIVATION.md">Our Motivation</a> |
  <a href="GET-STARTED.md">Get-Started: Installation & Usage</a> |
  <a href="#contributing">Contributing</a> |
  <a href="#known-issues">Known Issues</a> |
  <a href="#license">License</a>
</p>

> [!NOTE]  
> We continuously enhance Microsoft Entra PowerShell to improve functionality and performance. To stay up to date, install updates as soon as they are released. Updates are provided on a regular cadence.

## Contribute

To contribute, see [contribution guide](CONTRIBUTING.md). By the way, our documentation ([cmdlet references](./module/docs/) and [conceptual articles][docs-repo]) 🤓 are open source!

## Known Issues

- Some properties names change between the Azure AD PowerShell module and Microsoft Graph endpoints:
  - Parameter -Filter might not work correctly
  - Parameter -SearchString don't currently work
  - Output objects might be different
- "Assembly with same name is already loaded" - when there are multiple versions of `Microsoft.Graph.Authentication` modules installed.

## Product feedback and issues

If you find any bugs when using the Microsoft Entra PowerShell module, file an issue on our [GitHub issues][entraPowershellIssues] page.

This project adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information, see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) for questions or comments.

## Thanks :purple_heart:

Thank you for your valuable contributions and dedicated efforts in enhancing the Microsoft Entra PowerShell code and documentation. We truly appreciate having you as part of our ✨ amazing community ✨!"

## License

Copyright (c) Microsoft Corporation. All Rights Reserved. Licensed under the MIT [license](LICENSE).

<!-- PS Gallery -->
[entrapsgallery]: https://aka.ms/entra/ps/gallery
[entrapsgallerybeta]: https://aka.ms/entra/ps/gallery/beta

[mg]: https://img.shields.io/powershellgallery/v/Microsoft.Entra.svg?style=flat-square&label=Microsoft.Entra
[mgbeta]: https://img.shields.io/powershellgallery/v/Microsoft.Entra.Beta.svg?style=flat-square&label=Microsoft.Entra.Beta

[entraPowershellIssues]: htts://aka.ms/entra/ps/issues
[azureADRetirement]: https://techcommunity.microsoft.com/blog/microsoft-entra-blog/action-required-msonline-and-azuread-powershell-retirement---2025-info-and-resou/4364991
[learn.microsoft]: https://aka.ms/entra/ps/docs
[public-roadmap]: https://github.com/orgs/microsoftgraph/projects/69/views/1
[suggestions]: https://github.com/microsoftgraph/entra-powershell/discussions
[docs-repo]: https://github.com/MicrosoftDocs/entra-powershell-docs/tree/main/docs/conceptual
