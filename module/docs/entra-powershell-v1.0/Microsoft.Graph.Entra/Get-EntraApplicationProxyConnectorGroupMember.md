---
title: Get-EntraApplicationProxyConnectorGroupMember
description: This article provides details on the Get-EntraApplicationProxyConnectorGroupMember. Command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraApplicationProxyConnectorGroupMember

schema: 2.0.0
---

# Get-EntraApplicationProxyConnectorGroupMember.

## Synopsis
Get members from applicationProxyConnectorGroup.

## Syntax

```powershell
Get-EntraApplicationProxyConnectorGroupMember
 -Id <String> 
 [-All] 
 [-Top <Int32>] 
 [-Filter <String>]
 [<CommonParameters>]
```

## Description
Get members from applicationProxyConnectorGroup.

## Examples

### Example 1: Get members from applicationProxyConnectorGroup 
```powershell
PS C:\> Get-EntraApplicationProxyConnectorGroupMember -Id 87ffe1e2-6313-4a22-93eb-da1eb8a2bf8d
```
```output
Name                           Value
----                           -----
id                             147bd8b4-2134-4454-8f2a-1da81cf27917
externalIp                     3.7.211.5
machineName                    PERE-VARSHAM-FULLSTAK
version                        1.5.3437.0
status                         active
```

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Filter
Specifies an OData v4.0 filter statement. This parameter controls which objects are returned.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Id
Specifies the ID of user in Microsoft Entra ID.
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

### System. Nullable`1[[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]

### System. Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]

## Outputs

### System.Object
## Notes

## RELATED LINKS