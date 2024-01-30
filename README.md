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
# Microsoft Entra PowerShell (preview)

Microsoft Entra PowerShell (preview), a PowerShell module for Microsoft Entra, based on usability feedback from customers. Microsoft Entra PowerShell is meticulously designed to deliver a delightful, usable, and high-quality collection of PowerShell cmdlets for Entra administrators. The module offers human-readable parameters, deliberate parameter set specification, inline documentation, and core PowerShell fundamentals like pipelining.

Microsoft Entra PowerShell module also provides significant compatibility with the legacy modules (such as Azure AD PowerShell), that can facilitate migration to Microsoft Graph as a benefit.  We intend to expand Microsoft Entra resource and scenario support in Microsoft Entra PowerShell over time.

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
