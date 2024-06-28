---
title: Get-EntraBetaPrivilegedResource.
description: This article provides details on Get-EntraBetaPrivilegedResource command.

ms.service: active-directory
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaPrivilegedResource

## Synopsis
Get Microsoft Entra ID privileged resource.

## Syntax

### GetQuery (Default)
```
Get-EntraBetaPrivilegedResource
   -ProviderId <String>
   [-Top <Int32>]
   [-Filter <String>]
 [<CommonParameters>]
```

### GetById
```
Get-EntraBetaPrivilegedResource
   -ProviderId <String>
   -Id <String>
 [<CommonParameters>]
```

## Description
Get Microsoft Entra ID privileged resource.

## Examples

### Example 1: Get all resources

This example demonstrates how to retrieve all resources from Microsoft Entra ID.

```
PS C:\> Get-EntraBetaPrivilegedResource -ProviderId aadRoles
```

```Output
Id                                   DisplayName                          ExternalId
--                                   -----------                          ----------
0d626126-a0f3-444c-a025-84c2715389b4 ToGraph_443DEMos1                    /0d626126-a0f3-444c-a025-84c2715389b4
951691f3-d9e5-4f43-8e48-9b1624f61fe3 MOD Demo Platform UnifiedApiConsumer /951691f3-d9e5-4f43-8e48-9b1624f61fe3
9c8f84d0-3bd6-4ec4-a753-a6990777f438 "Ahiresh"                            /administrativeUnits/9c8f84d0-3bd6-4ec4-a753-a6990777...
c4fd2cd1-7902-4be2-a25b-d5cc5ff93517 Pradeep Gupta                        /administrativeUnits/c4fd2cd1-7902-4be2-a25b-d5cc5ff9...
d40bbf91-9b28-42bb-a42c-f2ada9332fb6 AdminUnitName1                       /administrativeUnits/d40bbf91-9b28-42bb-a42c-f2ada933...
d5aec55f-2d12-4442-8d2f-ccca95d4390e Contoso                              /
eb2a1f04-5fb2-44fb-b159-b8989da9a6a8 56544new2$£3                         /eb2a1f04-5fb2-44fb-b159-b8989da9a6a8
```

Get all resources for AzureResource provider.

### Example 2: Get a specific privileged resource

In this example, we provide the resource ID to retrieve a specific resource.

```
PS C:\> Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Id 9c8f84d0-3bd6-4ec4-a753-a6990777f438
```

```Output

Id                                   DisplayName ExternalId
--                                   ----------- ----------
9c8f84d0-3bd6-4ec4-a753-a6990777f438 "Ahiresh"   /administrativeUnits/9c8f84d0-3bd6-4ec4-a75...
```

Get a resource for AzureResource provider with Id `9c8f84d0-3bd6-4ec4-a753-a6990777f438`.

### Example 3: Get a specific privileged resource by filter

```
PS C:\> Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Filter "DisplayName eq 'AdminUnitName1'"
```

```Output
Id                                   DisplayName    ExternalId
--                                   -----------    ----------
d40bbf91-9b28-42bb-a42c-f2ada9332fb6 AdminUnitName1 /administrativeUnits/d40bbf91-9b28-42bb-a42c-f2ada9...
```
Get a resource for AzureResource provider by Filter

### Example 4: Get top privileged resources
```
PS C:\> Get-EntraBetaPrivilegedResource -ProviderId aadRoles -Top 1
```

````output
Id                                   DisplayName       ExternalId
--                                   -----------       ----------
0d626126-a0f3-444c-a025-84c2715389b4 ToGraph_443DEMos1 /0d626126-a0f3-444c-a025-84c271...
```
Get top resources for AzureResource provider.

## Parameters

### -Filter
The filter for Odata query

```yaml
Type: String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Id
The unique identifier of the specific resource

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ProviderId
The unique identifier of the specific provider

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
The top result count

```yaml
Type: Int32
Parameter Sets: GetQuery
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
## Outputs

### System.Object
## Notes

## Related Links
