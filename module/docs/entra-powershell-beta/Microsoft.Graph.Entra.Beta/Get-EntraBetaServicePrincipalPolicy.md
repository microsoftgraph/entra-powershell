---
title: Get-EntraBetaServicePrincipalPolicy.
description: This article provides details on the Get-EntraBetaServicePrincipalPolicy command.


ms.topic: reference
ms.date: 07/01/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaServicePrincipalPolicy

schema: 2.0.0
---

# Get-EntraBetaServicePrincipalPolicy

## Synopsis

Gets a servicePrincipal policy.

## Syntax

```powershell
Get-EntraBetaServicePrincipalPolicy 
 -Id <String> 
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaServicePrincipalPolicy` cmdlet gets the policy of a service principal in Microsoft Entra ID. Specify the `Id` parameter to get a specific servicePrincipal policy.

## Examples

### Example 1: Get a policy

```powershell
Connect-Entra -Scopes 'Policy.Read.All, Application.ReadWrite.All'
Get-EntraBetaServicePrincipalPolicy -Id 'bbbbbbbb-1111-1111-1111-cccccccccccc'
```

```Output
deletedDateTime        :
isManagementRestricted :
@odata.type            : #microsoft.graph.policy
alternativeIdentifier  :
definition             : {"HomeRealmDisccccoveryPolicy":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}
keyCredentials         :
id                     : ffffffff-5555-6666-7777-aaaaaaaaaaaa
displayName            : ss44$false%%%
type                   : HomeRealmDiscoveryPolicy
isOrganizationDefault  : False
createdDateTime        : 21-08-2023 10:33:27
odata.type             : #microsoft.graph.policy
```

This command retrieves the policy for a specified service principal in Microsoft Entra ID.

## Parameters

### -Id

The ID of the Service Principal for which you want to retrieve the policy

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraBetaServicePrincipalPolicy](Add-EntraBetaServicePrincipalPolicy.md)

[Remove-EntraBetaServicePrincipalPolicy](Remove-EntraBetaServicePrincipalPolicy.md)
