---
description: This article provides details on the Get-EntraServicePrincipalOwner command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraServicePrincipalOwner
schema: 2.0.0
title: Get-EntraServicePrincipalOwner
---

# Get-EntraServicePrincipalOwner

## SYNOPSIS

Get the owner of a service principal.

## SYNTAX

```powershell
Get-EntraServicePrincipalOwner
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraServicePrincipalOwner` cmdlet gets the owners of a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve the owner of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalOwner -ServicePrincipalId $servicePrincipal.Id | Select-Object Id, userPrincipalName, DisplayName, '@odata.type'
```

```Output
Id                                   userPrincipalName                       displayName    @odata.type
--                                   -----------------                       -----------    -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb AlexW@Contoso.com     Alex Wilber    #microsoft.graph.user
bbbbbbbb-1111-2222-3333-cccccccccccc ChristieC@Contoso.com Christie Cline #microsoft.graph.user
```

This example gets the owners of a specified service principal. You can use the command `Get-EntraServicePrincipal` to get service principal object ID.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal.

### Example 2: Retrieve all the owners of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalOwner -ServicePrincipalId $servicePrincipal.Id -All | Select-Object Id, userPrincipalName, DisplayName, '@odata.type'
```

```Output
Id                                   userPrincipalName                       displayName    @odata.type
--                                   -----------------                       -----------    -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb AlexW@Contoso.com     Alex Wilber    #microsoft.graph.user
bbbbbbbb-1111-2222-3333-cccccccccccc ChristieC@Contoso.com Christie Cline #microsoft.graph.user
```

This command gets all the owners of a service principal. You can use the command `Get-EntraServicePrincipal` to get service principal object ID.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal.

### Example 3: Retrieve top two owners of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipalOwner -ServicePrincipalId $servicePrincipal.Id -Top 2 | Select-Object Id, userPrincipalName, DisplayName, '@odata.type'
```

```Output
Id                                   userPrincipalName                       displayName    @odata.type
--                                   -----------------                       -----------    -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb AlexW@Contoso.com     Alex Wilber    #microsoft.graph.user
bbbbbbbb-1111-2222-3333-cccccccccccc ChristieC@Contoso.com Christie Cline #microsoft.graph.user
```

This command gets top two owners of a service principal. You can use the command `Get-EntraServicePrincipal` to get service principal object ID. You can use `-Limit` as an alias for `-Top`.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraServicePrincipalOwner](Add-EntraServicePrincipalOwner.md)

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[Remove-EntraServicePrincipalOwner](Remove-EntraServicePrincipalOwner.md)
