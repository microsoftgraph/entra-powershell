---
author: msewaweru
description: This article provides details on the Get-EntraApplicationTemplate command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 02/17/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraApplicationTemplate
schema: 2.0.0
title: Get-EntraApplicationTemplate
---

# Get-EntraApplicationTemplate

## Synopsis

Retrieve application templates from the Microsoft Entra gallery.

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

The `Get-EntraApplicationTemplate` cmdlet retrieves application templates from the Microsoft Entra gallery.

## Examples

### Example 1. Gets a list of application template objects

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplicationTemplate -Select Id, DisplayName, Publisher, Categories
```

```Output
Id                                   Categories                                       DisplayName                                       Publisher
--                                   ----------                                       -----------                                       ---------
00000007-0000-0000-c000-000000000000 {crm, productivity, collaboration, businessMgmt} Dynamics CRM Online                              Microsoft Corporation
f447d87b-6e85-481d-90b2-bae3f42cb0f6 {businessMgmt, erp, finance}                     Xledger                                           Xledger Inc
5979191c-86e6-40f7-87ac-0913dddd1f61 {businessMgmt}                                   FigBytes                                          Figbytes
00000012-0000-0000-c000-000000000000 {}                                              Microsoft Azure Information Protection            Microsoft Corporation
```

This command lists all the application template objects.

### Example 2: Get a list of application templates using All parameter

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplicationTemplate -Select Id, DisplayName, Publisher, Categories -All
```

```Output
Id                                   Categories                                       DisplayName                                       Publisher
--                                   ----------                                       -----------                                       ---------
00000007-0000-0000-c000-000000000000 {crm, productivity, collaboration, businessMgmt} Dynamics CRM Online                              Microsoft Corporation
f447d87b-6e85-481d-90b2-bae3f42cb0f6 {businessMgmt, erp, finance}                     Xledger                                           Xledger Inc
5979191c-86e6-40f7-87ac-0913dddd1f61 {businessMgmt}                                   FigBytes                                          Figbytes
00000012-0000-0000-c000-000000000000 {}                                              Microsoft Azure Information Protection            Microsoft Corporation
```

This cmdlet retrieves the list of application templates using All parameter.

### Example 3: Get top two deleted application templates

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplicationTemplate -Top 2 -Select Id, DisplayName, Publisher, Categories
```

```Output
Id                                   Categories                                       DisplayName                                       Publisher
--                                   ----------                                       -----------                                       ---------
00000007-0000-0000-c000-000000000000 {crm, productivity, collaboration, businessMgmt} Dynamics CRM Online                              Microsoft Corporation
f447d87b-6e85-481d-90b2-bae3f42cb0f6 {businessMgmt, erp, finance}                     Xledger                                           Xledger Inc
```

This cmdlet retrieves the top two application templates. You can use `-Limit` as an alias for `-Top`.

### Example 4: Get a list of application templates filtered by display name

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplicationTemplate -Filter "DisplayName eq 'Dynamics CRM Online'"
```

```Output
Id                                   Categories                                       DisplayName                                       Publisher
--                                   ----------                                       -----------                                       ---------
00000007-0000-0000-c000-000000000000 {crm, productivity, collaboration, businessMgmt} Dynamics CRM Online                              Microsoft Corporation
```

This example shows how to retrieve application templates with the specified display name.

### Example 5. Get a specific application templates

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$applicationTemplate = Get-EntraApplicationTemplate -Filter "DisplayName eq 'Dynamics CRM Online'"
Get-EntraApplicationTemplate -Id $applicationTemplate.Id
```

```Output
Id                                   Categories                                      Description
--                                   ----------                                      -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb {businessMgmt, productivity, projectManagement} Cube is perfect for businesses
```

This command gets an application template object for the specific application template ID.

- `-Id` Specifies the unique identifier of an application template.

### Example 6: Get application templates in the CRM category

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplicationTemplate -Filter "Categories/any(c:c eq 'crm')" -Select Id, DisplayName, Publisher, Categories
```

```Output
Id                                   Categories                                       DisplayName                                       Publisher
--                                   ----------                                       -----------                                       ---------
00000007-0000-0000-c000-000000000000 {crm, productivity, collaboration, businessMgmt} Dynamics CRM Online                              Microsoft Corporation
```

This example shows how to retrieve application templates in the CRM category.

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

## Inputs

## Outputs

### Microsoft.Online.Administration.ApplicationTemplate

## Notes

## Related links

[New-EntraApplicationFromApplicationTemplate](New-EntraApplicationFromApplicationTemplate.md)
