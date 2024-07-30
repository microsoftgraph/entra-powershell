---
title: Get-EntraBetaServicePrincipalOwner
description: This article provides details on the Get-EntraBetaServicePrincipalOwner command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaServicePrincipalOwner

schema: 2.0.0
---

# Get-EntraBetaServicePrincipalOwner

## Synopsis
Get the owner of a service principal.

## Syntax

```powershell
Get-EntraBetaServicePrincipalOwner 
 -ObjectId <String> 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## Description
The Get-EntraBetaServicePrincipalOwner cmdlet gets the owners of a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the owner of a service principal
```powershell
PS C:\> $ServicePrincipalId = (Get-EntraBetaServicePrincipal -Top 1).ObjectId
PS C:\> Get-EntraBetaServicePrincipalOwner -ObjectId $ServicePrincipalId
```

```output
ObjectId                             DisplayName    UserPrincipalName   UserType
--------                             -----------    -----------------   --------
fd560167-ff1f-471a-8d74-3b0070abcea1 Adams Smith    Adams@contoso.com   Member
15b958d9-af43-40be-8e91-bcd5676556f7 Peter Kons     Peter@contoso.com   Member
b7753478-6cec-4965-96cc-560c5fb6fcd4 Mary Kom       Mary@contoso.com    Member
```

The first command gets the ID of a service principal by using the [Get-EntraBetaServicePrincipal](./Get-EntraBetaServicePrincipal.md) cmdlet. 
The command stores the ID in the $ServicePrincipalId variable.

The second command gets the owner of a service principal identified by $ServicePrincipalId.

### Example 2: Retrieve all the owners of a service principal
```powershell
PS C:\> $ServicePrincipalId = (Get-EntraBetaServicePrincipal -Top 1).ObjectId
PS C:\> Get-EntraBetaServicePrincipalOwner -ObjectId $ServicePrincipalId -All
```

```output
ObjectId                             DisplayName    UserPrincipalName   UserType
--------                             -----------    -----------------   --------
fd560167-ff1f-471a-8d74-3b0070abcea1 Adams Smith    Adams@contoso.com   Member
15b958d9-af43-40be-8e91-bcd5676556f7 Peter Kons     Peter@contoso.com   Member
b7753478-6cec-4965-96cc-560c5fb6fcd4 Mary Kom       Mary@contoso.com    Member
```

This command gets all the owners of a service principal.

### Example 3: Retrieve top two owners of a service principal
```powershell
PS C:\> $ServicePrincipalId = (Get-EntraBetaServicePrincipal -Top 1).ObjectId
PS C:\> Get-EntraBetaServicePrincipalOwner -ObjectId $ServicePrincipalId -Top 2
```

```output
ObjectId                             DisplayName    UserPrincipalName   UserType
--------                             -----------    -----------------   --------
fd560167-ff1f-471a-8d74-3b0070abcea1 Adams Smith    Adams@contoso.com   Member
15b958d9-af43-40be-8e91-bcd5676556f7 Peter Kons     Peter@contoso.com   Member
```

This command gets top two owners of a service principal.

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraBetaServicePrincipalOwner](Add-EntraBetaServicePrincipalOwner.md)

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[Remove-EntraBetaServicePrincipalOwner](Remove-EntraBetaServicePrincipalOwner.md)