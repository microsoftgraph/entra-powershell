---
title: Restore-EntraDeletedApplication
description: This article provides details on the Restore-EntraDeletedApplication command.

ms.service: entra
ms.topic: reference
ms.date: 03/21/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Restore-EntraDeletedApplication

## SYNOPSIS

Restores a previously deleted application

## SYNTAX

```powershell
Restore-EntraDeletedApplication 
 [-IdentifierUris <System.Collections.Generic.List`1[System.String]>]
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION

This cmdlet restores a previously deleted application.

Restoring an application doesn't restore the associated service principal automatically. You must explicitly restore the deleted service principal.

For delegated scenarios, the calling user needs to have at least one of the following Microsoft Entra roles.

- Application Administrator
- Cloud Application Administrator
- Hybrid Identity Administrator

## EXAMPLES

### Example 1: Restores a previously deleted application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Get-EntraApplication
```

```Output

ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
dddddddd-3333-4444-5555-eeeeeeeeeeee 00001111-aaaa-2222-bbbb-3333cccc4444 PowerShellGraphAPI
eeeeeeee-4444-5555-6666-ffffffffffff 11112222-bbbb-3333-cccc-4444dddd5555 WingTips
ffffffff-5555-6666-7777-aaaaaaaaaaaa 22223333-cccc-4444-dddd-5555eeee6666 AzurePopulator
```

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Remove-EntraApplication -ObjectId dddddddd-3333-4444-5555-eeeeeeeeeeee
Get-EntraDeletedApplication
```

```Output

ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
dddddddd-3333-4444-5555-eeeeeeeeeeee 00001111-aaaa-2222-bbbb-3333cccc4444 analog
```

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Restore-EntraDeletedApplication -ObjectId dddddddd-3333-4444-5555-eeeeeeeeeeee
```

```Output
ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
dddddddd-3333-4444-5555-eeeeeeeeeeee 00001111-aaaa-2222-bbbb-3333cccc4444 analog
```

This example shows how an application is deleted, then the deleted application is retrieved using the `Get-EntraDeletedApplication` cmdlet, and after the application is restored by specifying the application's Object ID in the `Restore-EntraDeletedApplication` cmdlet.

## PARAMETERS

### -IdentifierUris

The IdentifierUris of the application that is to be restored

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId

The ObjectId of the deleted application that is to be restored

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
