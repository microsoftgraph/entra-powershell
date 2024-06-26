---
title: Get-EntraAdministrativeUnit
description: This article provides details on the Get-EntraAdministrativeUnit command.
ms.service: entra
ms.topic: reference
ms.date: 06/11/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraAdministrativeUnit

## SYNOPSIS

Gets an administrative unit.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraAdministrativeUnit 
 [-All] 
 [-Top <Int32>] 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraAdministrativeUnit 
 -ObjectId <String> 
 [-All] 
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraAdministrativeUnit` cmdlet gets a Microsoft Entra ID administrative unit. Specify the `ObjectId` parameter to get an administrative unit.

## EXAMPLES

### EXAMPLE 1: Gets a list of administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All, AdministrativeUnit.ReadWrite.All, Directory.Read.All, Directory.ReadWrite.All ' 
Get-EntraAdministrativeUnit
```

```Output
description                   : Updated Description
membershipRule                :
membershipRuleProcessingState :
id                            : CcDdEeFfGgHhIiJjKkLlMmNnOoPpQq3
deletedDateTime               :
visibility                    :
displayName                   : Updated DisplayName
membershipType                :
ObjectId                      : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
DeletionTimeStamp             :

```

This example gets a list of administrative unit.

### EXAMPLE 2: Gets a specific administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All, AdministrativeUnit.ReadWrite.All, Directory.Read.All, Directory.ReadWrite.All ' 
Get-EntraAdministrativeUnit  -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
description                   : Updated Description
membershipRule                :
membershipRuleProcessingState :
id                            : CcDdEeFfGgHhIiJjKkLlMmNnOoPpQq3
deletedDateTime               :
visibility                    :
displayName                   : Updated DisplayName
membershipType                :
ObjectId                      : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
DeletionTimeStamp             :

```

This example gets an administrative unit.

### EXAMPLE 3: Gets top one administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All, AdministrativeUnit.ReadWrite.All, Directory.Read.All, Directory.ReadWrite.All ' 
Get-EntraAdministrativeUnit  -Top 1
```

```Output
description                   : Updated Description
membershipRule                :
membershipRuleProcessingState :
id                            : CcDdEeFfGgHhIiJjKkLlMmNnOoPpQq3
deletedDateTime               :
visibility                    :
displayName                   : Updated DisplayName
membershipType                :
ObjectId                      : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
DeletionTimeStamp             :

```

This example gets a top one administrative unit.

### EXAMPLE 4: Gets an administrative unit with filter parameter

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All, AdministrativeUnit.ReadWrite.All, Directory.Read.All, Directory.ReadWrite.All ' 
Get-EntraAdministrativeUnit  -Filter "displayName eq 'Updated DisplayName'"
```

```Output
description                   : Updated Description
membershipRule                :
membershipRuleProcessingState :
id                            : CcDdEeFfGgHhIiJjKkLlMmNnOoPpQq3
deletedDateTime               :
visibility                    :
displayName                   : Updated DisplayName
membershipType                :
ObjectId                      : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
DeletionTimeStamp             :

```

This example gets an administrative unit with filter parameter.

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

Filter items by property values

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

### -ObjectId

Specifies the ID of an administrative unit in Microsoft Entra ID.

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

### -Top

Specifies the maximum number of records to return.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraAdministrativeUnit](New-EntraAdministrativeUnit.md)

[Remove-EntraAdministrativeUnit](Remove-EntraAdministrativeUnit.md)

[Set-EntraAdministrativeUnit](Set-EntraAdministrativeUnit.md)
