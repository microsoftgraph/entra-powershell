# Microsoft Graph Compatibility Adapter for AzureAD PowerShell

The Microsoft Graph Compatibility for Azure AD PowerShell is a collection of cmdlets that emulate the legacy Azure AD PowerShell cmdlets. The adapter uses the [Microsoft Graph PowerShell SDK](https://github.com/microsoftgraph/msgraph-sdk-powershell) to make calls to [Microsoft Graph](http://microsoft.graph.com).

This module provides Azure AD PowerShell users with a tool to support their migration to the Microsoft Graph PowerShell SDK. The adpater cmdlets have different names to those of the Azure AD PowerShell ones to avoid name collisions.

**This module is under development NOT READY for Production dependency.**

## Installation

### Local Building

Please refer to [local building and installing guide](https://github.com/microsoftgraph/msgraph-ps-compatibility-azuread/blob/main/build/BUILD.md).

### PowerShell Gallery
[![PSGallery Version](https://img.shields.io/powershellgallery/v/Microsoft.Graph.Compatibility.AzureAD)](https://www.powershellgallery.com/packages/Microsoft.Graph.Compatibility.AzureAD) 
[![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/Microsoft.Graph.Compatibility.AzureAD)](https://www.powershellgallery.com/packages/Microsoft.Graph.Compatibility.AzureAD)

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

2. Authentication

To see all the possible options please refer to [MS Graph SDK authentication](https://github.com/microsoftgraph/msgraph-sdk-powershell/blob/dev/README.md#usage)
```powershell
 Connect-MgGraph
```

3. Using commands

Here's an example that will convert the Azure AD module's Get-AzureADUser to a Microsoft Graph call.

```powershell
Get-CompatADUser -SearchString "ian" 
```

This example gives you more insight into the calls being made.

```powershell
Get-CompatADUser -SearchString "ian" -Debug
```

4. Aliasing Azure AD Commands

Running this cmdlet creates aliases for all of the supported Azure AD cmdlets to those in the compatability module.

```powershell
Set-CompatADAlias
```

This will show you all of the newly created aliases.

```powershell
Get-Alias -Name *AzureAd*
```

You can now run the Azure AD cmdlet, using an alias, and it will call MS Graph.

```powershell
Get-AzureADUser -SearchString "ian" 
```

This example gives you more insight into the calls being made.

```powershell
Get-AzureADUser -SearchString "ian" -Debug
```

NB - it is recommended that you remove the AzureAD module, if installed, to avoid collisions.

```powershell
Remove-Module AzureAD
```

5. Running a script with the adapter

You can use the compatibility adapter to test an AzureAD PowerShell module based script. This will help determine if a script can be migrated to the MS Graph PowerShell SDK. 

```powershell
Test-CompatADScript -Script .\Export_secrets_and_certificates_for_app_registrations.ps1
```

If the script is compatible you won't see any output, although you can use ```powershell$?``` to display that true was returned. If the script isn't compatible then you will see a warning with details of the problem cmdlet(s). Example:

```powershell
Test-CompatADScript -Script .\Export_secrets_and_certificates_for_app_registrations.ps1
WARNING: Command Get-AzureADApplicationKeyCredential is not supported
WARNING: Script contains commands that are not supported by the compatibility adapter.
```

## Contributing

In order to contribute please check [contribution guide](https://github.com/microsoftgraph/msgraph-ps-compatibility-azuread/blob/main/CONTRIBUTING.md).

## Known Issues

- Some properties names change between AzureAD and MSGraph endpoints:
  - Parameter -Filter may not work correctly
  - Parameter -SearchString does not currently work
  - Output objects may be different

## Issues

If you find any bugs when using the Microsoft Graph PowerShell modules, please file an issue on our GitHub issues page.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information, see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## License

Copyright (c) Microsoft Corporation. All Rights Reserved. Licensed under the MIT [license](LICENSE.txt).
