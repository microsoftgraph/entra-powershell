---
title: Example of the Microsoft Entra PowerShell cmdlet reference content.
description: This article provides an example of how to write cmdlet reference content for Microsoft Entra PowerShell docs.


ms.topic: reference
ms.date: 07/12/2024
ms.author: eunicewaweru
manager: CelesteDG
author: msewaweru
---

# Microsoft Entra PowerShell cmdlet reference example

# Get-EntraUser

Reference

Module: **Microsoft.Entra.Users**

## Synopsis

Gets users from Microsoft Entra ID.

## Syntax

```powershell
Get-EntraUser 
 [-ReturnDeletedUsers] 
 [-City <String>] 
 [-Country <String>] 
 [-Department <String>]
 [-DomainName <String>]
 [-EnabledFilter <UserEnabledFilter>]
 [-State <String>]
 [-Synchronized]
 [-Title <String>]
 [-HasErrorsOnly]
 [-LicenseReconciliationNeededOnly]
 [-UnlicensedUsersOnly]
 [-UsageLocation <String>]
 [-SearchString <String>]
 [-MaxResults <Int32>]
 [-TenantId <Guid>]
 [<CommonParameters>]
```

```powershell
Get-EntraUser
 -UserId <Guid>
 [-ReturnDeletedUsers]
 [-TenantId <Guid>]
 [<CommonParameters>]
```

## Description  
  
The `Get-EntraUser` cmdlet gets an individual user or list of users. Specify the `UserId` parameter to get a specific user.

## Permissions

|Permission type      | Permissions (from least to most privileged)              |
|:--------------------|:---------------------------------------------------------|
|Delegated (work or school account) | User.Read, User.ReadWrite, User.ReadBasic.All, User.Read.All, User.ReadWrite.All, Directory.Read.All, Directory.ReadWrite.All    |
|Delegated (personal Microsoft account) | User.Read, User.ReadWrite    |
|Application | User.Read.All, User.ReadWrite.All, Directory.Read.All, Directory.ReadWrite.All |

## Examples

### Example 1: Get all users

This example demonstrates how to retrieve all users from Microsoft Entra ID.

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUser
```

```Output
   DisplayName               Id                                   Mail                                    UserPrincipalName
-----------                  --                                   ----                                    -----------------
Rastislav Moravcik           aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb RastislavM@contoso.com                  RastislavM@contoso.com
Yerzhan Kasymuly             bbbbbbbb-1111-2222-3333-cccccccccccc YerzhanK@contoso.com                    YerzhanK@contoso.com                       
Baglan Serik                 cccccccc-2222-3333-4444-dddddddddddd BaglanS@contoso.com                     BaglanS@contoso.com                       
Abdulla Kafeel               dddddddd-3333-4444-5555-eeeeeeeeeeee AbdullaK@contoso.com                    AbdullaK@contoso.com                       
Vladimir Zeman               eeeeeeee-4444-5555-6666-ffffffffffff VladimirZ@contoso.com                   VladimirZ@contoso.com                       
```

This command retrieves all users in the company. It displays up to the default value of 500 results.

### Example 2: Get a specific user

In this example, we provide the user's ID to retrieve a specific user.

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUser -UserId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
DisplayName         Id                                   Mail                                UserPrincipalName
-----------         --                                   ----                                -----------------
Rastislav Moravcik aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb RastislavM@contoso.com               RastislavM@contoso.com                       
```

This example returns the details of the specified user with the ID `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`.

- `-UserId` is the parameter that specifies the user ID of the user to get.

## Parameters

### -All

Indicates that this cmdlet returns all results.
Don't specify together with the _MaxResults_ parameter.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: All__0
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserId

Specifies the unique object ID of the user to get.

```yaml
Type: System.String
Parameter Sets: GetUser__0
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## Inputs

## Outputs

## Related links

- New-EntraUser
- Remove-EntraUser
- Update-EntraUser
