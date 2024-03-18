---
title: Get-EntraServicePrincipalMembership.
description: This article provides details on the Get-EntraServicePrincipalMembership command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/06/2024
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

```
Get-EntraServicePrincipalMembership 
 -ObjectId <String>
 [-All <Boolean>] 
 [-Top <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraServicePrincipalMembership cmdlet gets the memberships of a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the memberships of a service principal.

```powershell
PS C:\> $ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
PS C:\> Get-EntraServicePrincipalMembership -ObjectId $ServicePrincipalId
```

The first command gets the ID of a service principal by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md) cmdlet. 
The command stores the ID in the $ServicePrincipalId variable.

The second command gets the memberships of a service principal identified by $ServicePrincipalId.

### Example 2: Retrieve all memberships of a service principal

```powershell
PS C:\> Get-EntraServicePrincipalMembership -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -All $true
```
```output
Id                                   DeletedDateTime
--                                   ---------------
7dc3a38a-4c92-40bd-b290-ea00f85b478c

```
This command gets all memberships of a specified service principal.

### Example 3: Retrieve top two memberships of a service principal
```powershell
PS C:\> Get-EntraServicePrincipalMembership -ObjectId "02ed943d-6eca-4f99-83d6-e6fbf9dc63ae" -Top 2
```
```output
Id                                   DeletedDateTime
--                                   ---------------
7dc3a38a-4c92-40bd-b290-ea00f85b478c

```

This command gets two memberships of a specified service principal.

## PARAMETERS

### -All
If true, return all memberships.
If false, return the number of objects specified by the Top parameter.

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

### -ObjectId
Specifies the ID of a service principal in Microsoft Entra ID.

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

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

