---
title: About Microsoft Entra PowerShell.
description: About Microsoft Entra PowerShell.

ms.service: active-directory
ms.topic: reference
ms.date: 01/26/2024
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
  <a href="GET-STARTED.md">Get-Started: Installation & Usage</a> |
  <a href="#contributing">Contributing</a> |
  <a href="#known-issues">Known Issues</a> |
  <a href="#license">License</a>
</p>

<p align="center">
<strong>This module is under development. It's NOT READY for Production environments.</strong>
</p>

> [!NOTE]  
> We are continually improving Microsoft Entra PowerShell throughout the private preview phase and beyond. Keep your module current by applying updates as soon as we notify you of a new version. Module updates will be done on regular cadence.

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

To contribute, check [contribution guide](CONTRIBUTING.md).

## Known Issues

- Some properties names change between the Azure AD PowerShell module and Microsoft Graph endpoints:
  - Parameter -Filter might not work correctly
  - Parameter -SearchString don't currently work
  - Output objects might be different

## Issues

If you find any bugs when using the Microsoft Entra PowerShell module, file an issue on our [GitHub issues](https://github.com/microsoftgraph/entra-powershell/issues) page.

This project adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information, see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) for questions or comments.

## License

Copyright (c) Microsoft Corporation. All Rights Reserved. Licensed under the MIT [license](LICENSE).
