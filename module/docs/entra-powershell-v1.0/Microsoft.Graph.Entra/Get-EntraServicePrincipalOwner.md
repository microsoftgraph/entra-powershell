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
 -ObjectId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraServicePrincipalOwner` command gets the owners of a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the owner of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-displayName>'"
Get-EntraServicePrincipalOwner -ObjectId $servicePrincipal.ObjectId
```

```Output
ObjectId                             DisplayName    UserPrincipalName   UserType
--------                             -----------    -----------------   --------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Adams Smith    Adams@contoso.com   Member
bbbbbbbb-1111-2222-3333-cccccccccccc Peter Kons     Peter@contoso.com   Member
cccccccc-2222-3333-4444-dddddddddddd Mary Kom       Mary@contoso.com    Member
```

This example gets the owners of a specified service principal. You can use the comand `Get-EntraServicePrincipal` to get service principal object Id.

- `ObjectId` parameter specifies the unique identifier of a service principal.

### Example 2: Retrieve all the owners of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-displayName>'"
Get-EntraServicePrincipalOwner -ObjectId $servicePrincipal.ObjectId -All
```

```Output
ObjectId                             DisplayName    UserPrincipalName   UserType
--------                             -----------    -----------------   --------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Adams Smith    Adams@contoso.com   Member
bbbbbbbb-1111-2222-3333-cccccccccccc Peter Kons     Peter@contoso.com   Member
cccccccc-2222-3333-4444-dddddddddddd Mary Kom       Mary@contoso.com    Member
```

This example retrieves all the owners of a service principal. You can use the comand `Get-EntraServicePrincipal` to get service principal object Id.

- `ObjectId` parameter specifies the unique identifier of a service principal.

### Example 3: Retrieve top two owners of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-displayName>'"
Get-EntraServicePrincipalOwner -ObjectId $servicePrincipal.ObjectId -Top 2
```

```Output
ObjectId                             DisplayName    UserPrincipalName   UserType
--------                             -----------    -----------------   --------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Adams Smith    Adams@contoso.com   Member
bbbbbbbb-1111-2222-3333-cccccccccccc Peter Kons     Peter@contoso.com   Member
```

This example retrieves the top two owners of a service principal. You can use the comand `Get-EntraServicePrincipal` to get service principal object Id.

- `-ObjectId` parameter specifies the unique identifier of a service principal.

### Example 4: Retrieve service principal owner details

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq '<service-principal-displayName>'"
# Get the owners of the service principal
$owners = Get-EntraServicePrincipalOwner -ObjectId $servicePrincipal.ObjectId -All
$result = @()

# Loop through each owner and get their UserPrincipalName and DisplayName
foreach ($owner in $owners) {
    $userId = $owner.Id
    $user = Get-EntraUser -ObjectId $userId
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

This example retrieve additional details of a service principal owners such as displayName, userPrincipalName.

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
