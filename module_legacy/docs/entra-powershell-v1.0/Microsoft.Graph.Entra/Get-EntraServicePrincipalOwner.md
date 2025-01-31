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
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraServicePrincipalOwner

schema: 2.0.0
---

# Get-EntraServicePrincipalOwner

## Synopsis

Get the owner of a service principal.

## Syntax

```powershell
Get-EntraServicePrincipalOwner
 -ServicePrincipalId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraServicePrincipalOwner` cmdlet gets the owners of a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the owner of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-displayName>'"
Get-EntraServicePrincipalOwner -ServicePrincipalId $servicePrincipal.ObjectId
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
```

This example gets the owners of a specified service principal. You can use the command `Get-EntraServicePrincipal` to get service principal object ID.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal.

### Example 2: Retrieve all the owners of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-displayName>'"
Get-EntraServicePrincipalOwner -ServicePrincipalId $servicePrincipal.ObjectId -All
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
cccccccc-2222-3333-4444-dddddddddddd
```

This command gets all the owners of a service principal. You can use the command `Get-EntraServicePrincipal` to get service principal object ID.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal.

### Example 3: Retrieve top two owners of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-displayName>'"
Get-EntraServicePrincipalOwner -ServicePrincipalId $servicePrincipal.ObjectId -Top 2
```

```Output
Id                                   DeletedDateTime
--                                   ---------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
bbbbbbbb-1111-2222-3333-cccccccccccc
```

This command gets top two owners of a service principal. You can use the command `Get-EntraServicePrincipal` to get service principal object ID.

- `-ServicePrincipalId` parameter specifies the unique identifier of a service principal.

### Example 4: Retrieve service principal owner details

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-displayName>'"
# Get the owners of the service principal
$owners = Get-EntraServicePrincipalOwner -ServicePrincipalId $servicePrincipal.ObjectId -All
$result = @()

# Loop through each owner and get their UserPrincipalName and DisplayName
foreach ($owner in $owners) {
    $userId = $owner.Id
    $user = Get-EntraUser -UserId $userId
    $userDetails = [PSCustomObject]@{
        Id                = $owner.Id
        UserPrincipalName = $user.UserPrincipalName
        DisplayName       = $user.DisplayName
    }
    $result += $userDetails
}

# Output the result in a table format
$result | Format-Table -AutoSize
```

```Output
Id                                   UserPrincipalName             DisplayName
--                                   -----------------             -----------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb AlexW@contoso.com  Alex Wilber
bbbbbbbb-1111-2222-3333-cccccccccccc AdeleV@contoso.com Adele Vance
```

This example shows how to retrieve more details of a service principal owner such as displayName, userPrincipalName.

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
Aliases:

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
Aliases:

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

## Related Links

[Add-EntraServicePrincipalOwner](Add-EntraServicePrincipalOwner.md)

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[Remove-EntraServicePrincipalOwner](Remove-EntraServicePrincipalOwner.md)
