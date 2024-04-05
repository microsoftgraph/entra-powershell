---
title: Microsoft Entra PowerShell installation and usage guide.
description: About Microsoft Entra PowerShell installation and usage guide.

ms.service: active-directory
ms.topic: reference
ms.date: 04/05/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
---

# Get Started

Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [AzureAD aliasing](#aliasing-azuread-powershell-commands)
- [Other Entra PowerShell features](#other-microsoft-entra-powershell-features)
- [Bonus: End-to-end example](#end-to-end-scenario-example)

## Installation

### Prerequisites

This module depends on the [Microsoft Graph PowerShell SDK](https://github.com/microsoftgraph/msgraph-sdk-powershell#readme). Some modules need to be installed for this module to work. Check the prerequisites [here](https://github.com/microsoftgraph/entra-powershell/blob/main/PREREQUISITE.md).

**Installation method guidance**

| Installation Method  | During Private Preview  | After Private Preview |
|---|---|---|
| [Zipped folder option](#option-1---zipped-folder-option)  | ✅ | ❌ |
| [Build module locally](#option-2---build-the-module-locally) | ✅ | ❌ |
| [PowerShell gallery option](#option-3---powershell-gallery-option)  | ❌ | ✅ |

> [!TIP]
> If you encounter issues during installation or while interacting with the module, kindly raise a [GitHub issue](https://github.com/microsoftgraph/entra-powershell/issues) or reach us through email - <entraposh@microsoft.com>

### Option 1 - Zipped folder option

Download the latest [Microsoft Entra PowerShell release](https://github.com/microsoftgraph/entra-powershell/releases/download/0.7.1-preview/EntraPowerShell_0.7.1-preview.zip) zipped file. Follow the instructions as per this snippet.

```powershell
# Let's assume the unpacked files are in c:\test\entra-powershell
cd c:\test\entra-powershell

# Unblock the content using
Get-ChildItem -Path . -Recurse| Unblock-File -Confirm

# Add the folder to your module's path; this is temporary. To make it permanent, run the following with admin privileges
$env:PSModulePath += ";C:\test\entra-powerShell"

# Import the module
Import-Module Microsoft.Graph.Entra -Force
# or for beta
Import-Module Microsoft.Graph.Entra.Beta -Force
```
> [!TIP]
> If you are using PowerShell 5.1, you may experience the error `Function <cmdlet-name> cannot be created because function capacity 4096 has been exceeded for this scope`. To fix this error, run the command: `$MaximumFunctionCount=32768`.

### Option 2 - Build the module locally

Refer to [local building and installing guide](./build/BUILD.md).

## Usage

### Authentication

To use the Microsoft Entra PowerShell, you need to authenticate to access Entra resources. Sign in with an admin account of their tenant, if prompted.

```powershell
Connect-MgGraph -Scopes 'User.Read.All' 
```

To see all the possible options, refer to [MS Graph SDK authentication](https://learn.microsoft.com/powershell/microsoftgraph/authentication-commands#using-connect-mggraph).

### Warming up

1. Get all available commands in Microsoft Entra PowerShell module

```powershell
Get-Command -Module Microsoft.Graph.Entra
```
Replace `Microsoft.Graph.Entra` with `Microsoft.Graph.Entra.Beta` if you're using the `Beta` version of the module.

2. Get the Microsoft Entra ID users

```powershell
Get-EntraUser
```

This command returns all the users in your Microsoft Entra ID tenant.

3. Getting Help

To be effective with the Microsoft Entra PowerShell, you need to use the Help system. `Get-Help` command helps you find commands to perform specific tasks and learn how to use those commands after you find them.  

To learn more about the `Get-EntraUser` command, for example, run:

```powershell
Get-Help Get-EntraUser
```

To get examples, add the parameter `–Examples`.

```powershell
Get-Help Get-EntraUser -Examples
```

4. Searching for a user

```powershell
Get-EntraUser -SearchString "Adele" 
```

### Running Commands with `-Debug` option

To gain insights into the calls being made, you can add `-debug` option.

```powershell
Get-EntraUser -SearchString "Adele" -Debug
```

1. Running a legacy PowerShell module script with the Microsoft Entra PowerShell module

You can use the Microsoft Entra PowerShell to test an AzureAD PowerShell module-based script. This helps determine if a script can be migrated to the Microsoft Graph PowerShell SDK.

```powershell
Test-EntraScript -Script .\export-apps-with-expiring-secrets.ps1
```

If the script is compatible, you won't see any output, although you can use `$?` to display that True was returned. If the script isn't compatible, a warning with details of the problem cmdlet(s) shows. Example:

```powershell
Test-EntraScript -Script .\export-apps-with-expiring-secrets.ps1

WARNING: Command Get-AzureADApplicationKeyCredential is not supported
WARNING: Script contains commands that are not supported by the compatibility adapter.
```

> [!TIP]
> You can access the `export-apps-with-expiring-secrets.ps1` from our [samples page](./samples/export-apps-with-expiring-secrets.ps1).

## Aliasing AzureAD PowerShell commands

Since Microsoft Entra PowerShell offers significant compatibility with the legacy AzureAD PowerShell module, running the `Enable-EntraAzureADAlias` cmdlet creates aliases for all of the supported Azure AD PowerShell cmdlets in the Microsoft Entra PowerShell module.

```powershell
Enable-EntraAzureADAlias
```

This command shows you all of the newly created aliases:

```powershell
Get-Alias -Name *AzureAd*
```

You can now run the Azure AD PowerShell cmdlet using an alias, which calls the Microsoft Graph PowerShell under the hood.

```powershell
Get-AzureADUser -SearchString "Adele" 
```

## Other Microsoft Entra PowerShell features

Microsoft Entra PowerShell offers cool features such as pipelining, and migration adapter capabilities to help our customers migrate from legacy PowerShell modules such as [Azure AD](https://learn.microsoft.com/en-us/powershell/azure/active-directory/overview) and [MSOnline](https://learn.microsoft.com/en-us/powershell/module/msonline) modules. We'll continue to add more out-of-the-box usability features to make you productive and with pleasant experience.

### Pipelining feature

With Pipelining, you can perform updates from the output of another command as inputs. For example, updating the Postal Code address for all group members after a reporting line changes.

```powershell
Get-EntraGroup -Filter "DisplayName eq 'Contoso Team'" | Get-EntraGroupMember | Set-EntraUser -PostalCode 90134 
```

This command updates the Postal Code for all the members of the group with ID `e76bfd30-48fb-4f40-83f1-8d94ddd4f8c2`.

### Migration scenario

James has a long AzureAD PowerShell module based [script to export apps with expiring secrets](./samples/export-apps-with-expiring-secrets.ps1). Rewriting is tedious and time consuming. James would like to use the Microsoft Entra PowerShell module to help him ride on the Microsoft Graph PowerShell with the least friction. All that James has to do is to replace one line of code `Connect-AzureAD` with the three lines.

```powershell
Import-Module Microsoft.Graph.Entra
Connect-MgGraph #Replaces Connect-AzureAD for auth
Enable-EntraAzureADAlias #Activate aliasing 
```

> [!TIP]
> You can access the [modified script](./samples/export-apps-with-expiring-secrets-modified.ps1) from our samples page.

## End-to-end Scenario Example

Adele is an IT Admin within Contoso Group. Adele would like to test an end-to-end scenario to enable Adele to automate Group creation whenever a new product support team is formed from ServiceNow ticketing system trigger activity.

**Step 1: Group Creation**

To create a group, make sure you have the required permissions/scopes to create a group.

```powershell
Connect-MgGraph -Scopes "Group.ReadWrite.All" 
```

To create a new group, run the command.

```powershell
New-EntraGroup -DisplayName "My new group" -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet" 
```

This command creates a new group with the name `My new group`.

**Step 2: Searching for the created group**

```powershell
Get-EntraGroup -Filter "DisplayName eq 'My new group'" | fl 
```

This command returns the details of the newly created group.

_Hint_: You can use the ObjectId (GUID) to search, update or delete group

**Step 3: Update group properties**

```powershell
Set-EntraGroup -ObjectId "c1720fcf-0281-4c74-89c9-2fbc54f9b8f9" -Description "This is my new updated group details" 
```

This command updates the group description. The `ObjectId` is the Group Id GUID.

_Hint_: To confirm updated changes, run the `Get-EntraGroup` again.

```powershell
Get-EntraGroup -Filter "DisplayName eq 'My new group'" | fl 
```

**Step 4: Add a user to the group**

```powershell
Add-EntraGroupMember -ObjectId "c1720fcf-0281-4c74-89c9-2fbc54f9b8f9" -RefObjectId "3f19094c-65db-4556-ba96-2d29e41934b4" 
```

This command adds a user (with UserId `3f19094c-65db-4556-ba96-2d29e41934b4` - with parameter RefObjectId) to the group with ObjectId `c1720fcf-0281-4c74-89c9-2fbc54f9b8f9`.

_Hint_: You can get the UserId from the [Microsoft Entra admin center](https://entra.microsoft.com/) or by running `Get-EntraUser` command.

**Step 5: Adding the group owner**

```powershell
Add-EntraGroupOwner -ObjectId "c1720fcf-0281-4c74-89c9-2fbc54f9b8f9" -RefObjectId "a8f67daa-0d66-491a-b8af-e11c06218c19"
```

This command adds an owner with UserId `a8f67daa-0d66-491a-b8af-e11c06218c19`` to the group with Id`c1720fcf-0281-4c74-89c9-2fbc54f9b8f9`.

**Step 6: Getting the group owner**

```powershell
Get-EntraGroupOwner -ObjectId "c1720fcf-0281-4c74-89c9-2fbc54f9b8f9" 
```

This command returns the UserId of the group owner(s).

_Hint_: You can run the command below to get the user details of the group owner based on the UserId returned.

```powershell
Get-EntraUser -ObjectId "4580d0d6-a6fb-4125-b428-82d09064aa8a" 
```

**Step 7: Removing a group member**

```powershell
Remove-EntraGroupMember -ObjectId "c1720fcf-0281-4c74-89c9-2fbc54f9b8f9" -MemberId "1aa46598-c6ce-4115-943e-a82c574673cc"
```

This command removes a user/member with UserId `1aa46598-c6ce-4115-943e-a82c574673cc` from the group.

**Step 8: Cleaning up/Remove group**

```powershell
Remove-EntraGroup -ObjectId "c1720fcf-0281-4c74-89c9-2fbc54f9b8f9" 
```

This command removes the Microsoft Entra ID group.
