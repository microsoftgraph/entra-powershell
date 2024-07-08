---
title: Get-EntraApplicationOwner.
description: This article provides details on the Get-EntraApplicationOwner command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraApplicationOwner

## Synopsis

Gets the owner of an application.

## Syntax

```powershell
Get-EntraApplicationOwner 
 -ObjectId <String> 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## Description

The `Get-EntraApplicationOwner` cmdlet gets an owner of a Microsoft Entra application.

## Examples

### Example 1: Get the owner of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
Get-EntraApplicationOwner -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {adelev@contoso.com}
preferredLanguage               :
mail                            : AdeleV@contoso.com
securityIdentifier              : S-1-12-1-2222222222-3333333333-4444444444-5555555555
identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=AdeleV@contoso.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
```

This example demonstrates how to get the owners of an application in Microsoft Entra ID.

### Example 2: Get all owners of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
Get-EntraApplicationOwner -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -All
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {adelev@contoso.com}
preferredLanguage               :
mail                            : AdeleV@contoso.com
securityIdentifier              : S-1-12-1-2222222222-3333333333-4444444444-5555555555
identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=AdeleV@contoso.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
```

This example demonstrates how to get the all owners of a specified application in Microsoft Entra ID.

### Example 3: Get top two owners of an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All' #Delegated Permission
Connect-Entra -Scopes 'Application.ReadWrite.OwnedBy' #Application Permission
Get-EntraApplicationOwner -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb' -Top 2
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {adelev@contoso.com}
preferredLanguage               :
mail                            : AdeleV@contoso.com
securityIdentifier              : S-1-12-1-2222222222-3333333333-4444444444-5555555555
identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=AdeleV@contoso.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
```

This example demonstrates how to get the two owners of a specified application in Microsoft Entra ID.

## Parameters

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

### -ObjectId

Specifies the ID of an application in Microsoft Entra ID.

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

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
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

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraApplicationOwner](Add-EntraApplicationOwner.md)

[Remove-EntraApplicationOwner](Remove-EntraApplicationOwner.md)
