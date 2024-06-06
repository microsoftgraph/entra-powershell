---
title: Get-EntraMSApplicationOwner
description: This article provides details on the Get-EntraMSApplicationOwner command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraMSApplicationOwner

## SYNOPSIS

Retrieves the list of owners for an application object.

## SYNTAX

```powershell
Get-EntraMSApplicationOwner 
 -ObjectId <String> 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION

Retrieves the list of owners for an application object.

## EXAMPLES

### Example 1: Get the owners of an application

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraMSApplicationOwner -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```output
Id                                   DeletedDateTime
--                                   ---------------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee
11bb11bb-cc22-dd33-ee44-55ff55ff55ff
22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

This command gets the owner of the specified application.  

### Example 2: Get the owners of an application using all parameter

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraMSApplicationOwner -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -All 
```

```output
Id                                   DeletedDateTime
--                                   ---------------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee
11bb11bb-cc22-dd33-ee44-55ff55ff55ff
22cc22cc-dd33-ee44-ff55-66aa66aa66aa
```

This command gets the owners of an application using `-All` parameter.  

### Example 3: Get top two owners of an application

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraMSApplicationOwner -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Top 2
```

```output
Id                                   DeletedDateTime
--                                   ---------------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee
11bb11bb-cc22-dd33-ee44-55ff55ff55ff
```

This command gets the top two owners of an application.  

## PARAMETERS

### -ObjectId

Specifies the ID of an application in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: (All)
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
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Bool?

### Int?

### String

## OUTPUTS

### Microsoft.Open.MSGraph.Model.GetDirectoryObjectsResponse

## NOTES

## RELATED LINKS

[Add-EntraMSApplicationOwner](Add-EntraMSApplicationOwner.md)

[Remove-EntraMSApplicationOwner](Remove-EntraMSApplicationOwner.md)