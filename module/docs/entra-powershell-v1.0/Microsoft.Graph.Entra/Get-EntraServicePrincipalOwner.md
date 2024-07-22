---
title: Get-EntraServicePrincipalOwner
description: This article provides details on the Get-EntraServicePrincipalOwner command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraServicePrincipalOwner

## Synopsis

Get the owner of a service principal.

## Syntax

```powershell
Get-EntraServicePrincipalOwner
 -ObjectId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The Get-EntraServicePrincipalOwner cmdlet gets the owners of a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the owner of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
Get-EntraServicePrincipalOwner -ObjectId $ServicePrincipalId
```

```output
ObjectId                             DisplayName    UserPrincipalName   UserType
--------                             -----------    -----------------   --------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Adams Smith    Adams@contoso.com   Member
bbbbbbbb-1111-2222-3333-cccccccccccc Peter Kons     Peter@contoso.com   Member
cccccccc-2222-3333-4444-dddddddddddd Mary Kom       Mary@contoso.com    Member
```

The first command gets the ID of a service principal by using the [Get-EntraServicePrincipal](./Get-EntraServicePrincipal.md) cmdlet. 
The command stores the ID in the $ServicePrincipalId variable.

The second command gets the owner of a service principal identified by $ServicePrincipalId.

### Example 2: Retrieve all the owners of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
Get-EntraServicePrincipalOwner -ObjectId $ServicePrincipalId -All
```

```output
ObjectId                             DisplayName    UserPrincipalName   UserType
--------                             -----------    -----------------   --------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Adams Smith    Adams@contoso.com   Member
bbbbbbbb-1111-2222-3333-cccccccccccc Peter Kons     Peter@contoso.com   Member
cccccccc-2222-3333-4444-dddddddddddd Mary Kom       Mary@contoso.com    Member
```

This command gets all the owners of a service principal.

### Example 3: Retrieve top two owners of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
Get-EntraServicePrincipalOwner -ObjectId $ServicePrincipalId -Top 2
```

```output
ObjectId                             DisplayName    UserPrincipalName   UserType
--------                             -----------    -----------------   --------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Adams Smith    Adams@contoso.com   Member
bbbbbbbb-1111-2222-3333-cccccccccccc Peter Kons     Peter@contoso.com   Member
```

This command gets top two owners of a service principal.

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

### -Property

Specifies properties to be returned

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraServicePrincipalOwner](Add-EntraServicePrincipalOwner.md)

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[Remove-EntraServicePrincipalOwner](Remove-EntraServicePrincipalOwner.md)
