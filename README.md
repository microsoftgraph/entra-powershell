# Microsoft Graph Compatibility Adapter for AzureAD PowerShell

Microsoft Graph Compatibility AzureAD is a collection of cmdlets that emulate the legacy AzureAD PowerShell cmdlets. It uses the [Microsoft Graph PowerShell SDK](https://github.com/microsoftgraph/msgraph-sdk-powershell) to make the calls to [Microsoft Graph](http://microsoft.graph.com).

The purpose of this module is to provide AzureAD PowerShell users with a tool to support their migration to the Microsoft Graph PowerShell SDK. The adpater cmdlets have different names to those of the Azure AD PowerShell ones to avoid name collisions.

**This module is under development NOT READY for Production dependency.**

## Installation

### Local Building

Please refer to [local building and installing guide](https://github.com/microsoftgraph/msgraph-ps-compatibility-azuread/blob/main/build/BUILD.md).

### PowerShell Gallery

All the modules are published on [PowerShell Gallery](https://www.powershellgallery.com/packages/Microsoft.Graph.Compatibility.AzureAD). Installing is as simple as:

``` powershell
Install-Module Microsoft.Graph.Compatibility.AzureAD
```

If you are upgrading from our preview modules, run `Install-Module` with AllowClobber and Force parameters to avoid command name conflicts:

``` powershell
Install-Module Microsoft.Graph.Compatibility.AzureAD -AllowClobber -Force
```

## Usage

1. Importing the module
```powershell
Import-Module Microsoft.Graph.Compatibility.AzureAD -Force
```

2. Authentication. To see all the possible options please refer to [Authentication](https://github.com/microsoftgraph/msgraph-sdk-powershell/blob/dev/README.md#usage)
```powershell
 Connect-MgGraph -Scopes "User.Read.All", "Group.ReadWrite.All"
```

3. Using commands

```powershell
Get-CompatADUser
```

4. Aliasing AzureAD Commands

```powershell
Set-CompatADAlias
```
## Contribution

In order to conribute please check [contribution guide](https://github.com/microsoftgraph/msgraph-ps-compatibility-azuread/blob/main/CONTRIBUTING.md).

## Known Issues

- Some properties names changed between AzureAD and MSGraph endpoints:
  - Parameter -Filter may not work correctly
  - Parameter -SearchString does not currently works.
  - Output objects may be different

## Issues

If you find any bugs when using the Microsoft Graph PowerShell modules, please file an issue on our GitHub issues page.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information, see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## License

Copyright (c) Microsoft Corporation. All Rights Reserved. Licensed under the MIT [license](LICENSE.txt).
