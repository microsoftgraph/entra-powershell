---
title: Get-EntraBetaPrivilegedResource
description: This article provides details on Get-EntraBetaPrivilegedResource command.


ms.topic: reference
ms.date: 08/12/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaPrivilegedResource

schema: 2.0.0
---

# Get-EntraBetaPrivilegedResource

## Synopsis

Get Microsoft Entra ID privileged resource.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaPrivilegedResource
 -ProviderId <String>
 [-Top <Int32>]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaPrivilegedResource
 -ProviderId <String>
 -Id <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaPrivilegedResource` cmdlet get Microsoft Entra ID privileged resource.

## Examples

### Example 1: Get all resources

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.Read.AzureAD', 'PrivilegedAccess.Read.AzureResources' 'PrivilegedAccess.Read.AzureADGroup'
Get-EntraBetaPrivilegedResource -ProviderId 'aadRoles'
```

```Output
Id                                   DisplayName ExternalId                                                RegisteredDateTime RegisteredRoot Status Type
--                                   ----------- ----------                                                ------------------ -------------- ------ ----
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb AdminUnitName         /administrativeUnits/aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb                                  Active administrativeUnits
```

This example demonstrates how to retrieve all resources for aadRoles provider.

- `-ProviderId` Parameter specifies the ID of the specific provider.

### Example 2: Get a specific privileged resource

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.Read.AzureAD', 'PrivilegedAccess.Read.AzureResources' 'PrivilegedAccess.Read.AzureADGroup'
$params = @{
    ProviderId = 'aadRoles'
    Id = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
}
Get-EntraBetaPrivilegedResource @params
```

```Output
Id                                   DisplayName ExternalId                                                RegisteredDateTime RegisteredRoot Status Type
--                                   ----------- ----------                                                ------------------ -------------- ------ ----
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb AdminUnitName         /administrativeUnits/aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb                                  Active administrativeUnits
```

This example retrieves a resource for aadRoles provider with ID `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`.

- `-ProviderId` Parameter specifies the ID of the specific provider.
- `-Id` Parameter specifies the unique identifier of the specific resource.

### Example 3: Get a specific privileged resource by filter

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.Read.AzureAD', 'PrivilegedAccess.Read.AzureResources' 'PrivilegedAccess.Read.AzureADGroup'
$params = @{
    ProviderId = 'aadRoles'
    Filter = "DisplayName eq 'AdminUnitName'"
}
Get-EntraBetaPrivilegedResource @params
```

```Output
Id                                   DisplayName ExternalId                                                RegisteredDateTime RegisteredRoot Status Type
--                                   ----------- ----------                                                ------------------ -------------- ------ ----
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb AdminUnitName         /administrativeUnits/aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb                                  Active administrativeUnits
```

This example retrieves a resource for aadRoles provider Filter.

- `-ProviderId` Parameter specifies the ID of the specific provider.

### Example 4: Get top privileged resources

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.ReadWrite.AzureAD', 'PrivilegedAccess.Read.AzureResources' 'PrivilegedAccess.Read.AzureADGroup'
$params = @{
    ProviderId = 'aadRoles'
}
Get-EntraBetaPrivilegedResource @params -Top 1
```

```Output
Id                                   DisplayName ExternalId                                                RegisteredDateTime RegisteredRoot Status Type
--                                   ----------- ----------                                                ------------------ -------------- ------ ----
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Test         /administrativeUnits/aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb                                  Active administrativeUnits
```

This example retrieves top resources for aadRoles provider.

- `-ProviderId` Parameter specifies the ID of the specific provider.

## Parameters

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

### -Id

The unique identifier of the specific resource.

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

### -ProviderId

The unique identifier of the specific provider.

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

### -Top

The top result count.

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

### System.String

## Outputs

### System.Object

## Notes

## Related Links
