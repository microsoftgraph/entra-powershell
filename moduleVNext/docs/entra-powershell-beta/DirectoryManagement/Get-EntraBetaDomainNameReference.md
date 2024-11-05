---
title: Get-EntraBetaDomainNameReference
description: This article provides details on the Get-EntraBetaDomainNameReference command.


ms.topic: reference
ms.date: 08/08/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaDomainNameReference

schema: 2.0.0
---

# Get-EntraBetaDomainNameReference

## Synopsis

Retrieves the objects that are referenced by a given domain name.

## Syntax

```powershell
Get-EntraBetaDomainNameReference
 -Name <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDomainNameReference` cmdlet retrieves the objects that are referenced with a given domain name. Specify `Name` parameter retrieve the objects.

The work or school account needs to belong to at least the Domain Name Administrator or Global Reader Microsoft Entra role.

## Examples

### Example 1: Retrieve the domain name reference objects for a domain

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraBetaDomainNameReference -Name contoso.com
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
dddddddd-3333-4444-5555-eeeeeeeeeeee
ffffffff-4444-5555-6666-gggggggggggg
hhhhhhhh-5555-6666-7777-iiiiiiiiiiii
```

This example shows how to retrieve the domain name reference objects for a domain that is specified through the -Name parameter.

- `-Name` parameter specifies the name of the domain name for which the referenced objects are retrieved.

## Parameters

### -Name

The name of the domain name for which the referenced objects are retrieved.

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

### System.String

## Outputs

### System.Object

## Notes

## Related Links
