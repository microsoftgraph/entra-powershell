---
description: This article provides details on the Get-EntraBetaDeletedApplication command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 02/12/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaDeletedApplication
schema: 2.0.0
title: Get-EntraBetaDeletedApplication
---

# Get-EntraBetaDeletedApplication

## SYNOPSIS

Retrieves the list of previously deleted applications.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaDeletedApplication
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaDeletedApplication
 -ApplicationId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraBetaDeletedApplication
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaDeletedApplication` cmdlet Retrieves the list of previously deleted applications.

Note: Deleted security groups are permanently removed and cannot be retrieved.

## EXAMPLES

### Example 1: Get list of deleted applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaDeletedApplication -Property Id, AppId, DisplayName, DeletedDateTime, DeletionAgeInDays | Select-Object Id, AppId, DisplayName, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
id                                   displayName           appId                                deletedDateTime       DeletionAgeInDays
--                                   -----------           -----                                ---------------       -----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Contoso Fieldglass    bbbbbbbb-1111-2222-3333-cccccccccccc 2/12/2025 11:07:07 AM                 5
cccccccc-4444-5555-6666-dddddddddddd New Entra Application dddddddd-5555-6666-7777-eeeeeeeeeeee 2/12/2025 11:07:56 AM                 5
```

This cmdlet retrieves the list of deleted applications.

### Example 2: Get list of deleted applications using All parameter

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaDeletedApplication -All | Select-Object Id, DisplayName, AppId, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
id                                   displayName           appId                                deletedDateTime       DeletionAgeInDays
--                                   -----------           -----                                ---------------       -----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Contoso Fieldglass    bbbbbbbb-1111-2222-3333-cccccccccccc 2/12/2025 11:07:07 AM                 5
cccccccc-4444-5555-6666-dddddddddddd New Entra Application dddddddd-5555-6666-7777-eeeeeeeeeeee 2/12/2025 11:07:56 AM                 5
```

This cmdlet retrieves the list of deleted applications using All parameter.

### Example 3: Get top two deleted applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaDeletedApplication -Top 2 | Select-Object Id, DisplayName, AppId, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
id                                   displayName           appId                                deletedDateTime       DeletionAgeInDays
--                                   -----------           -----                                ---------------       -----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Contoso Fieldglass    bbbbbbbb-1111-2222-3333-cccccccccccc 2/12/2025 11:07:07 AM                 5
cccccccc-4444-5555-6666-dddddddddddd New Entra Application dddddddd-5555-6666-7777-eeeeeeeeeeee 2/12/2025 11:07:56 AM                 5
```

This cmdlet retrieves top two deleted applications. You can use `-Limit` as an alias for `-Top`.

### Example 4: Get deleted applications using SearchString parameter

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaDeletedApplication -SearchString 'TestApp1'
```

```Output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
TestApp1    aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADMyOrg   contoso.com
```

This cmdlet retrieves deleted applications using SearchString parameter.

### Example 5: Get deleted applications filter by display name

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaDeletedApplication -Filter "displayName eq 'Contoso Fieldglass'" | Select-Object Id, AppId, DisplayName, SignInAudience, PublisherDomain, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
id                                   appId                                displayName        signInAudience publisherDomain        deletedDateTime       DeletionAgeInDays
--                                   -----                                -----------        -------------- ---------------        ---------------       -----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc Contoso Fieldglass AzureADMyOrg   contoso.com          2/12/2025 11:07:07 AM  5
```

This cmdlet retrieves deleted applications having specified display name.

### Example 6: Get a specific deleted application using Application ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaDeletedApplication -ApplicationId aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb | Select-Object Id, AppId, DisplayName, DeletedDateTime, DeletionAgeInDays | Format-Table -AutoSize
```

```Output
Id                                   DisplayName           AppId                                DeletedDateTime       DeletionAgeInDays
--                                   -----------           -----                                ---------------       -----------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Contoso Fieldglass    bbbbbbbb-1111-2222-3333-cccccccccccc 2/14/2025 11:07:07 AM                 10
```

This cmdlet retrieves deleted applications with deletion age in days.

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

### -Filter

Retrieve only those deleted applications that satisfy the filter.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SearchString

Retrieve only those applications that satisfy the -SearchString value.

```yaml
Type: System.String
Parameter Sets: GetVague
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

The maximum number of applications returned by this cmdlet.
The default value is 100.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases: Limit

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

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

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)
