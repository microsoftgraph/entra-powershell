---
title: Get-EntraApplicationProxyConnectorGroupMember.
description: This article provides details on the Get-EntraApplicationProxyConnectorGroupMember. Command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraApplicationProxyConnectorGroupMember.

## SYNOPSIS
Get members from applicationProxyConnectorGroup.

## SYNTAX

```
Get-EntraApplicationProxyConnectorGroupMember
 -Id <String> 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [-Filter <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Get members from applicationProxyConnectorGroup.

## EXAMPLES

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

## PARAMETERS

### -All
If true, return all objects created by this user. If false, return the number of objects specified by the Top parameter.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter
Specifies an oData v3.0 filter statement. This parameter controls which objects are returned.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System. Nullable`1[[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]

### System. Nullable`1[[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
