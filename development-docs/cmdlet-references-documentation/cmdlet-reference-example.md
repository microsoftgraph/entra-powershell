---
title: Get-EntraUser
description: This article provides details on the Get-EntraUser command


ms.topic: reference
ms.date: 07/12/2024
ms.author: eunicewaweru
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraUser

schema: 2.0.0
---

# Get-EntraUser

Reference

Module: **Microsoft.Entra**

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
  
The `Get-EntraUser` cmdlet gets an individual user or list of users. Specify the `ObjectId` parameter to get a specific user.

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

This command retrieves all users in the company, displaying up to the default limit of 500 results.

### Example 2: Get a specific user

In this example, we provide the user's ID to retrieve their details.

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUser -ObjectId 'RastislavM@contoso.com'
```

```Output
DisplayName         Id                                   Mail                                UserPrincipalName
-----------         --                                   ----                                -----------------
Rastislav Moravcik aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb RastislavM@contoso.com               RastislavM@contoso.com                       
```

This example returns the details of the specified user using their User Principal Name (UPN) `RastislavM@contoso.com`.

- `-ObjectId` parameter specifies the ID of the user to retrieve.

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

## Related Links

[New-EntraUser](New-EntraUser.md)

[Remove-EntraUser](Remove-EntraUser.md)

[Update-EntraUser](Update-EntraUser.md)
