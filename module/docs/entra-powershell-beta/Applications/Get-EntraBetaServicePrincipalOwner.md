---
title: Get-EntraBetaServicePrincipalOwner
description: This article provides details on the Get-EntraBetaServicePrincipalOwner command.

ms.topic: reference
ms.date: 07/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Entra.Beta.Applications-Help.xml
Module Name: Microsoft.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaServicePrincipalOwner

schema: 2.0.0
---

# Get-EntraBetaServicePrincipalOwner

## Synopsis

Get the owner of a service principal.

## Syntax

```powershell
Get-EntraBetaServicePrincipalOwner
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaServicePrincipalOwner` cmdlet gets the owners of a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the owner of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalOwner -ServicePrincipalId $servicePrincipal.Id | Select-Object Id, userPrincipalName, DisplayName, '@odata.type'
```

```Output
Id                                   userPrincipalName                       displayName    @odata.type
--                                   -----------------                       -----------    -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb AlexW@Contoso.com     Alex Wilber    #microsoft.graph.user
bbbbbbbb-1111-2222-3333-cccccccccccc ChristieC@Contoso.com Christie Cline #microsoft.graph.user
```

This example gets the owners of a specified service principal. You can use the command `Get-EntraBetaServicePrincipal` to get service principal object ID.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal.

### Example 2: Retrieve all the owners of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalOwner -ServicePrincipalId $servicePrincipal.Id -All | Select-Object Id, userPrincipalName, DisplayName, '@odata.type'
```

```Output
Id                                   userPrincipalName                       displayName    @odata.type
--                                   -----------------                       -----------    -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb AlexW@Contoso.com     Alex Wilber    #microsoft.graph.user
bbbbbbbb-1111-2222-3333-cccccccccccc ChristieC@Contoso.com Christie Cline #microsoft.graph.user
```

This command gets all the owners of a service principal. You can use the command `Get-EntraBetaServicePrincipal` to get service principal object ID.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal.

### Example 3: Retrieve top two owners of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraBetaServicePrincipalOwner -ServicePrincipalId $servicePrincipal.Id -Top 2 | Select-Object Id, userPrincipalName, DisplayName, '@odata.type'
```

```Output
Id                                   userPrincipalName                       displayName    @odata.type
--                                   -----------------                       -----------    -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb AlexW@Contoso.com     Alex Wilber    #microsoft.graph.user
bbbbbbbb-1111-2222-3333-cccccccccccc ChristieC@Contoso.com Christie Cline #microsoft.graph.user
```

This command gets top two owners of a service principal. You can use the command `Get-EntraBetaServicePrincipal` to get service principal object ID. You can use `-Limit` as an alias for `-Top`.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal.

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

### -ServicePrincipalId

Specifies the ID of a service principal in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

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

## Inputs

## Outputs

## Notes

## Related links

[Add-EntraBetaServicePrincipalOwner](Add-EntraBetaServicePrincipalOwner.md)

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[Remove-EntraBetaServicePrincipalOwner](Remove-EntraBetaServicePrincipalOwner.md)
