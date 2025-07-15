---
author: msewaweru
description: This article provides details on the Get-EntraBetaApplicationProxyConnector command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/16/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaApplicationProxyConnector
schema: 2.0.0
title: Get-EntraBetaApplicationProxyConnector
---

# Get-EntraBetaApplicationProxyConnector

## SYNOPSIS

The `Get-EntraBetaApplicationProxyConnector` cmdlet a list of all connectors, or if specified, details of a specific connector.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaApplicationProxyConnector
 [-All]
 [-Top <Int32>]
 [-Filter <String>]
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraBetaApplicationProxyConnector
 [-SearchString <String>]
 [-All]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaApplicationProxyConnector
 -OnPremisesPublishingProfileId <String>
 [-All]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaApplicationProxyConnector` cmdlet retrieves the details for a given connector.
If no connectorId is specified, it retrieves all the connectors assigned to the tenant.

## EXAMPLES

### Example 1: Retrieve all connectors

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaApplicationProxyConnector
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This command Retrieve all connectors.

### Example 2: Retrieve information for a specific connector

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaApplicationProxyConnector -OnPremisesPublishingProfileId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This example demonstrates how to Retrieve information for a specific connector.

- `OnPremisesPublishingProfileId` parameter specifies the connector ID.

### Example 3: Retrieve information for a top one connector

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaApplicationProxyConnector -Top 1
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This example demonstrates how to Retrieve information for a top one connector. You can use `-Limit` as an alias for `-Top`.

### Example 4: Retrieve information with SearchString parameter

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaApplicationProxyConnector -SearchString 'Entra PowerShell AppProxy Connector'
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This example demonstrates how to Retrieve information using SearchString.

### Example 5: Retrieve information using machineName property

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
Get-EntraBetaApplicationProxyConnector -Filter "machineName eq 'AppProxy Machine'"
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

This example demonstrates how to Retrieve information using machineName property.

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

### -OnPremisesPublishingProfileId

The ID of the specific connector.
You can find this ID by running the command without this parameter to get the desired ID, or by going into the portal and viewing connector details.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SearchString

Specifies a search string.

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

[Set-EntraBetaApplicationProxyConnector](Set-EntraBetaApplicationProxyConnector.md)
