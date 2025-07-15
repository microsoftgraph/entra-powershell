---
author: msewaweru
description: This article provides details on the Get-EntraBetaApplicationProxyConnectorGroup.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/16/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaApplicationProxyConnectorGroup
schema: 2.0.0
title: Get-EntraBetaApplicationProxyConnectorGroup
---

# Get-EntraBetaApplicationProxyConnectorGroup

## SYNOPSIS

The `Get-EntraBetaApplicationProxyConnectorGroup` cmdlet retrieves a list of all connector groups, or if specified, details of a specific connector group.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaApplicationProxyConnectorGroup
 [-All]
 [-Top <Int32>]
 [-Filter <String>]
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraBetaApplicationProxyConnectorGroup
 [-SearchString <String>]
 [-All]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaApplicationProxyConnectorGroup
 -Id <String>
 [-All]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaApplicationProxyConnectorGroup` cmdlet retrieves a list of all connector groups, or if specified, details of the specified connector group.

## EXAMPLES

### Example 1: Retrieve all connector groups

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaApplicationProxyConnectorGroup
```

```Output
Id                                   ConnectorGroupType IsDefault Name                       Region
--                                   ------------------ --------- ----                       ------
bbbbbbbb-1111-2222-3333-cccccccccccc applicationProxy   False     Test                       eur
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb applicationProxy   True      Default                    eur
```

This example retrieves all connector groups.

### Example 2: Retrieve a specific connector group

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaApplicationProxyConnectorGroup -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```Output
Name                           Value
----                           -----
Id                                   ConnectorGroupType IsDefault Name                       Region
--                                   ------------------ --------- ----                       ------
bbbbbbbb-1111-2222-3333-cccccccccccc applicationProxy   False     Test                       eur
```

This example retrieves a specific connector group.

- `Id` parameter specifies the connector group ID.

### Example 3: Retrieve Top one connector groups

```powershell
Get-EntraBetaApplicationProxyConnectorGroup -Top 1
```

```Output
Id                                   ConnectorGroupType IsDefault Name                       Region
--                                   ------------------ --------- ----                       ------
bbbbbbbb-1111-2222-3333-cccccccccccc applicationProxy   False     Test                       eur
```

This example retrieves top one connector groups. You can use `-Limit` as an alias for `-Top`.

### Example 4: Retrieve a connector groups with filter parameter

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaApplicationProxyConnectorGroup -Filter "name eq 'Default'"
```

```Output
Id                                   ConnectorGroupType IsDefault Name                       Region
--                                   ------------------ --------- ----                       ------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb applicationProxy   True      Default                    eur
```

This example retrieves a connector groups with filter parameter.

### Example 5: Retrieve a connector groups with String parameter

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaApplicationProxyConnectorGroup -SearchString 'Test'
```

```Output
Id                                   ConnectorGroupType IsDefault Name                       Region
--                                   ------------------ --------- ----                       ------
bbbbbbbb-1111-2222-3333-cccccccccccc applicationProxy   False     Test                       eur
```

This example retrieves a connector groups with String parameter.

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

Specifies an OData v4.0 filter statement.
This parameter controls which objects are returned.
Details on querying with oData can be found here: <https://www.odata.org/documentation/odata-version-3-0/odata-version-3-0-core-protocol/#queryingcollections>

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

### -Id

The ID of the specific connector group.
You can find this ID by running the command without this parameter to get the desired ID, or by going into the portal and viewing connector group details.

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

### -SearchString

Specifies the search string.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

System.Nullable\`1\[\[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[New-EntraBetaApplicationProxyConnectorGroup](New-EntraBetaApplicationProxyConnectorGroup.md)

[Set-EntraBetaApplicationProxyConnectorGroup](Set-EntraBetaApplicationProxyConnectorGroup.md)

[Remove-EntraBetaApplicationProxyConnectorGroup](Remove-EntraBetaApplicationProxyConnectorGroup.md)
