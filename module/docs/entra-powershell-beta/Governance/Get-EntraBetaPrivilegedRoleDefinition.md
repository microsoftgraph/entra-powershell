---
author: msewaweru
description: This article provides details on Get-EntraBetaPrivilegedRoleDefinition command.
external help file: Microsoft.Entra.Beta.Governance-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Governance
ms.author: eunicewaweru
ms.date: 08/12/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Governance/Get-EntraBetaPrivilegedRoleDefinition
schema: 2.0.0
title: Get-EntraBetaPrivilegedRoleDefinition
---

# Get-EntraBetaPrivilegedRoleDefinition

## SYNOPSIS

Get role definitions.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaPrivilegedRoleDefinition
 -ResourceId <String>
 -ProviderId <String>
 [-Filter <String>]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaPrivilegedRoleDefinition
 -ResourceId <String>
 -Id <String>
 -ProviderId <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaPrivilegedRoleDefinition` cmdlet gets role definitions from Microsoft Entra ID.

## EXAMPLES

### Example 1: Get role definitions for a specific provider and resource

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.Read.AzureAD', 'PrivilegedAccess.Read.AzureResources' 'PrivilegedAccess.Read.AzureADGroup'
$params = @{
    ProviderId = 'aadRoles'
    ResourceId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
}
Get-EntraBetaPrivilegedRoleDefinition @params
```

```Output
Id                                   DisplayName                         ExternalId                           ResourceId                           TemplateId
--                                   -----------                         ----------                           ----------                           ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb custom proxy                       aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 22223333-cccc-4444-dddd-5555eeee6666 aaaaaaaa-0000-1111-2222…
bbbbbbbb-1111-2222-3333-cccccccccccc Authentication Policy Administrator bbbbbbbb-1111-2222-3333-cccccccccccc 11112222-bbbb-3333-cccc-4444dddd5555 bbbbbbbb-1111-2222-3333…
cccccccc-2222-3333-4444-dddddddddddd Search Administrator                cccccccc-2222-3333-4444-dddddddddddd 00001111-aaaa-2222-bbbb-3333cccc4444 cccccccc-2222-3333-4444…
```

This example retrieves role definitions for a specific provider and resource.

- `-ProviderId` Parameter specifies the ID of the specific provider.
- `-ResourceId` Parameter specifies the ID of the specific resource.

### Example 2: Get a role definition for a specific provider

```Powershell
Connect-Entra -Scopes 'PrivilegedAccess.Read.AzureAD', 'PrivilegedAccess.Read.AzureResources' 'PrivilegedAccess.Read.AzureADGroup'
$params = @{
    ProviderId = 'aadRoles'
    ResourceId = '11112222-bbbb-3333-cccc-4444dddd5555'
    Id = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Get-EntraBetaPrivilegedRoleDefinition @params
```

```Output
Id                                   DisplayName                         ExternalId                           ResourceId                           TemplateId
--                                   -----------                         ----------                           ----------                           ----------
bbbbbbbb-1111-2222-3333-cccccccccccc Authentication Policy Administrator bbbbbbbb-1111-2222-3333-cccccccccccc 11112222-bbbb-3333-cccc-4444dddd5555 bbbbbbbb-1111-2222-3333…
```

This example retrieves a role definition for a specific provider, resource, and ID.

- `-ProviderId` Parameter specifies the ID of the specific provider.
- `-ResourceId` Parameter specifies the ID of the specific resource.
- `-Id` Parameter specifies the ID of a role definition.

### Example 3: Get a specific role definition by filter

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.Read.AzureAD', 'PrivilegedAccess.Read.AzureResources' 'PrivilegedAccess.Read.AzureADGroup'
$params = @{
    ProviderId = 'aadRoles'
    ResourceId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    Filter = "DisplayName eq 'custom proxy'"
}
Get-EntraBetaPrivilegedRoleDefinition @params
```

```Output
Id                                   DisplayName                         ExternalId                           ResourceId                           TemplateId
--                                   -----------                         ----------                           ----------                           ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb custom proxy                       aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 22223333-cccc-4444-dddd-5555eeee6666 aaaaaaaa-0000-1111-2222…
```

This example retrieves a specific role definition by Filter.

- `-ProviderId` Parameter specifies the ID of the specific provider.
- `-ResourceId` Parameter specifies the ID of the specific resource.

### Example 4: Get top role definition

```powershell
Connect-Entra -Scopes 'PrivilegedAccess.Read.AzureAD', 'PrivilegedAccess.Read.AzureResources' 'PrivilegedAccess.Read.AzureADGroup'
$params = @{
    ProviderId = 'aadRoles'
    ResourceId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
}
Get-EntraBetaPrivilegedRoleDefinition @params -Top 1
```

```Output
Id                                   DisplayName                         ExternalId                           ResourceId                           TemplateId
--                                   -----------                         ----------                           ----------                           ----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb custom proxy                       aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 22223333-cccc-4444-dddd-5555eeee6666 aaaaaaaa-0000-1111-2222…
```

This example retrieves a top one role definition. You can use `-Limit` as an alias for `-Top`.

- `-ProviderId` Parameter specifies the ID of the specific provider.
- `-ResourceId` Parameter specifies the ID of the specific resource.

## PARAMETERS

### -Id

The ID of a role definition.

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

### -ResourceId

The unique identifier of the specific resource.

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

The top result count.

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

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
