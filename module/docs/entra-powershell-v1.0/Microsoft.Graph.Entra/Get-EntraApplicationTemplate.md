---
title: Get-EntraApplicationTemplate
description: This article provides details on the Get-EntraApplicationTemplate command.


ms.topic: reference
ms.date: 07/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraApplicationTemplate
schema: 2.0.0
---

# Get-EntraApplicationTemplate

## Synopsis

Retrieve a list of applicationTemplate objects.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraApplicationTemplate
 [-Filter <String>]
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraApplicationTemplate 
 -Id <String> 
 [<CommonParameters>]
```

## Description

The `Get-EntraApplicationTemplate` cmdlet allows users to get a list of all the application templates or a specific application template.

## Examples

### Example 1: Gets a list of application template objects

```powershell
Connect-Entra
$all_templates = Get-EntraApplicationTemplate
```

This command gets all the application template objects.

### Example 2: Gets an application template object

```powershell
Connect-Entra
Get-EntraApplicationTemplate -Id 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
Id                                   Categories                                       Description DisplayName         HomePageUrl                           LogoUrl
--                                   ----------                                       ----------- -----------         -----------                           -------
00000007-0000-0000-c000-000000000000 {crm, productivity, collaboration, businessMgmt}             Dynamics CRM Online http://www.microsoft.com/dynamics/crm https://az4950…
```

This command gets an application template object for the given ID.

- `-Id` Specify unique identifier of an application template.

### Example 3: Gets top one application template object

```powershell
Connect-Entra
Get-EntraApplicationTemplate -Top 1
```

```Output
Id                                   Categories                                       Description DisplayName         HomePageUrl                           LogoUrl
--                                   ----------                                       ----------- -----------         -----------                           -------
00000007-0000-0000-c000-000000000000 {crm, productivity, collaboration, businessMgmt}             Dynamics CRM Online http://www.microsoft.com/dynamics/crm https://az4950…

```

This example demonstrates how to gets Top one application template object.

### Example 4: Gets all application template object

```powershell
Connect-Entra
Get-EntraApplicationTemplate -All
```

```Output
Id                                   Categories                                       Description DisplayName         HomePageUrl                           LogoUrl
--                                   ----------                                       ----------- -----------         -----------                           -------
00000007-0000-0000-c000-000000000000 {crm, productivity, collaboration, businessMgmt}             Dynamics CRM Online http://www.microsoft.com/dynamics/crm https://az4950…
00001111-aaaa-2222-bbbb-3333cccc4444 {businessMgmt, erp, finance}                     Xledger True Cloud ERP System. Xledger supports your ambition with three value pilla…
11112222-bbbb-3333-cccc-4444dddd5555 {businessMgmt}                                   Capture and manage your ESG data from across the organization in an integrated, clou…

```

This example demonstrates how to get all application template object.

### Example 5: Gets application template object With Filter

```powershell
Connect-Entra
Get-EntraApplicationTemplate -Filter "DisplayName eq 'Dynamics CRM Online'"
```

```Output
Id                                   Categories                                       Description DisplayName         HomePageUrl                           LogoUrl
--                                   ----------                                       ----------- -----------         -----------                           -------
00001111-aaaa-2222-bbbb-3333cccc4444 {crm, productivity, collaboration, businessMgmt}             Dynamics CRM Online http://www.microsoft.com/dynamics/crm https://az4950…
```

This example demonstrates how to retrieve application template by DisplayName.

## Parameters

### -Id

The unique identifier of an application template.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

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

Specifies an OData v4.0 filter statement.
This parameter controls which objects are returned.

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

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases:

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
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

### Microsoft.Online.Administration.ApplicationTemplate

## Notes

## Related Links
