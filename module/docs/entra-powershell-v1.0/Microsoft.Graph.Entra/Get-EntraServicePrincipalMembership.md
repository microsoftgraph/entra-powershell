---
title: Get-EntraServicePrincipalMembership.
description: This article provides details on the Get-EntraServicePrincipalMembership command.

ms.service: entra
ms.topic: reference
ms.date: 06/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraServicePrincipalMembership

## SYNOPSIS

Get a service principal membership.

## SYNTAX

```powershell
Get-EntraServicePrincipalMembership 
 -ObjectId <String>
 [-All] 
 [-Top <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION

The Get-EntraServicePrincipalMembership cmdlet gets the memberships of a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the memberships of a service principal.

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
Get-EntraServicePrincipalMembership -ObjectId $ServicePrincipalId
```

The first command gets the ID of a service principal by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md) cmdlet. 
The command stores the ID in the $ServicePrincipalId variable.

The second command gets the memberships of a service principal identified by $ServicePrincipalId.

### Example 2: Retrieve all memberships of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipalMembership -ObjectId '33334444-dddd-5555-eeee-6666ffff7777' -All 
```

```output
Id                                   DeletedDateTime
--                                   ---------------
33334444-dddd-5555-eeee-6666ffff7777
```

This command gets all memberships of a specified service principal.

### Example 3: Retrieve top two memberships of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipalMembership -ObjectId '22223333-cccc-4444-dddd-5555eeee6666' -Top 2
```

```output
Id                                   DeletedDateTime
--                                   ---------------
22223333-cccc-4444-dddd-5555eeee6666
```

This command gets two memberships of a specified service principal.

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
### -ObjectId

Specifies the ID of a service principal in Microsoft Entra ID.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)
