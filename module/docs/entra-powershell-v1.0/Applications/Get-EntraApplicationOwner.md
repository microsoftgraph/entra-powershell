---
author: msewaweru
description: This article provides details on the Get-EntraApplicationOwner command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraApplicationOwner
schema: 2.0.0
title: Get-EntraApplicationOwner
---

# Get-EntraApplicationOwner

## SYNOPSIS

Gets the owner of an application.

## SYNTAX

```powershell
Get-EntraApplicationOwner
 -ApplicationId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraApplicationOwner` cmdlet get an owner of an Microsoft Entra ID application.

## EXAMPLES

### Example 1: Get the owner of an application

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Helpdesk Application'"
Get-EntraApplicationOwner -ApplicationId $application.Id |
Select-Object Id, displayName, UserPrincipalName, createdDateTime, userType, accountEnabled |
Format-Table -AutoSize
```

```Output
id                                   DisplayName   UserPrincipalName                CreatedDateTime       UserType AccountEnabled
--                                   -----------   -----------------                ---------------       -------- --------------
bbbbbbbb-1111-2222-3333-cccccccccccc Adele Vance   AdeleV@contoso.com               10/7/2024 12:33:36 AM Member   True
dddddddd-3333-4444-5555-eeeeeeeeeeee Cameron White CameronW@contoso.com            10/7/2024 12:34:47 AM Member   True
```

This example demonstrates how to get the owners of an application in Microsoft Entra ID.

- `-ApplicationId` parameter specifies the unique identifier of an application.

### Example 2: Get all owners of an application

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Helpdesk Application'"
Get-EntraApplicationOwner -ApplicationId $application.Id -All |
Select-Object Id, displayName, UserPrincipalName, createdDateTime, userType, accountEnabled |
Format-Table -AutoSize
```

```Output
id                                   DisplayName   UserPrincipalName                CreatedDateTime       UserType AccountEnabled
--                                   -----------   -----------------                ---------------       -------- --------------
bbbbbbbb-1111-2222-3333-cccccccccccc Adele Vance   AdeleV@contoso.com               10/7/2024 12:33:36 AM Member   True
dddddddd-3333-4444-5555-eeeeeeeeeeee Cameron White CameronW@contoso.com            10/7/2024 12:34:47 AM Member   True
```

This example demonstrates how to get the all owners of a specified application in Microsoft Entra ID.

- `-ApplicationId` parameter specifies the unique identifier of an application.

### Example 3: Get top two owners of an application

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraApplication -Filter "DisplayName eq 'Helpdesk Application'"
Get-EntraApplicationOwner -ApplicationId $application.Id -Top 2 |
Select-Object Id, displayName, UserPrincipalName, createdDateTime, userType, accountEnabled |
Format-Table -AutoSize
```

```Output
id                                   DisplayName   UserPrincipalName                CreatedDateTime       UserType AccountEnabled
--                                   -----------   -----------------                ---------------       -------- --------------
bbbbbbbb-1111-2222-3333-cccccccccccc Adele Vance   AdeleV@contoso.com               10/7/2024 12:33:36 AM Member   True
dddddddd-3333-4444-5555-eeeeeeeeeeee Cameron White CameronW@contoso.com            10/7/2024 12:34:47 AM Member   True
```

This example demonstrates how to get the two owners of a specified application in Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

- `-ApplicationId` parameter specifies the unique identifier of an application.

## PARAMETERS

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationId

Specifies the ID of an application in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: Limit

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraApplicationOwner](Add-EntraApplicationOwner.md)

[Remove-EntraApplicationOwner](Remove-EntraApplicationOwner.md)
