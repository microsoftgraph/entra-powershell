---
description: This article provides details on the Get-EntraBetaApplicationOwner command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/05/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaApplicationOwner
schema: 2.0.0
title: Get-EntraBetaApplicationOwner
---

# Get-EntraBetaApplicationOwner

## SYNOPSIS

Gets the owner of an application.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaApplicationOwner
 -ApplicationId <String>
 [-Top <Int32>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### Append

```powershell
Get-EntraBetaApplicationOwner
 -ApplicationId <String>
 -Property <String[]>
 -AppendSelected
 [-Top <Int32>]
 [-All]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaApplicationOwner` cmdlet get an owner of an Microsoft Entra ID application.

## EXAMPLES

### Example 1: Get the owner of an application

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Helpdesk Application'"
Get-EntraBetaApplicationOwner -ApplicationId $application.Id |
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
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Helpdesk Application'"
Get-EntraBetaApplicationOwner -ApplicationId $application.Id -All |
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
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Helpdesk Application'"
Get-EntraBetaApplicationOwner -ApplicationId $application.Id -Top 2 |
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

### Example 4: Retrieve top two owners of a service principal and select and append a property not returned by default.

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraBetaApplication -Filter "DisplayName eq 'Helpdesk Application'"
Get-EntraBetaApplicationOwner -ApplicationId $application.Id -Property onPremisesImmutableId -AppendSelected -Top 2 | Select-Object Id, userPrincipalName, DisplayName, '@odata.type', OnPremisesImmutableId
```

```Output
Id                                   userPrincipalName          @odata.type              OnPremisesImmutableId
--                                   -----------                -----------              ---------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb AdeleV@contoso.com         #microsoft.graph.user    hhhhhhhh-3333-5555-3333-qqqqqqqqqqqq
bbbbbbbb-1111-2222-3333-cccccccccccc CameronW@contoso.com       #microsoft.graph.user    eeeeeeee-4444-5555-6666-ffffffffffff
```

This command gets top two owners of an application. You can use the command `Get-EntraBetaApplication` to get application ID. You can use `-Limit` as an alias for `-Top`.

- `-ApplicationId` parameter specifies the unique identifier of an application.
- `-Property` parameter selects a property `userType` that is not returned by default.
- `-AppendSelected` parameter ensures the selected property is returned together with default properties.

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

### -AppendSelected

Specifies whether to append the selected properties.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: Append
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraBetaApplicationOwner](Add-EntraBetaApplicationOwner.md)

[Remove-EntraBetaApplicationOwner](Remove-EntraBetaApplicationOwner.md)
