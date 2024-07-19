---
title: Get-EntraServicePrincipal
description: This article provides details on the Get-EntraServicePrincipal command.


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

# Get-EntraServicePrincipal

## Synopsis

Gets a service principal.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraServicePrincipal
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraServicePrincipal
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraServicePrincipal
 -ObjectId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The Get-EntraServicePrincipal cmdlet gets a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve all service principal from the directory

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal
```

```output
ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
bbbbbbbb-1111-2222-3333-cccccccccccc 00001111-aaaa-2222-bbbb-3333cccc4444 Demo App
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 22223333-cccc-4444-dddd-5555eeee6666 Demo Two App
dddddddd-3333-4444-5555-eeeeeeeeeeee 33334444-dddd-5555-eeee-6666ffff7777 ProjectWorkManagement
```

This command retrieves all service principal from the directory.

### Example 2: Retrieve a service principal by ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
Get-EntraServicePrincipal $ServicePrincipalId
```

```output
ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
bbbbbbbb-1111-2222-3333-cccccccccccc 00001111-aaaa-2222-bbbb-3333cccc4444 Demo App
```

The first command gets the ID of a service principal by using the [Get-EntraServicePrincipal](./Get-EntraServicePrincipal.md) cmdlet.  

The command stores the ID in the $ServicePrincipalId variable.  

The second command gets the service principal identified by $ServicePrincipalId.

### Example 3: Retrieve all service principals from the directory

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal -All 
```

```output
ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
bbbbbbbb-1111-2222-3333-cccccccccccc 00001111-aaaa-2222-bbbb-3333cccc4444 Demo App
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 22223333-cccc-4444-dddd-5555eeee6666 Demo Two App
dddddddd-3333-4444-5555-eeeeeeeeeeee 33334444-dddd-5555-eeee-6666ffff7777 ProjectWorkManagement
ffffffff-5555-6666-7777-aaaaaaaaaaaa 44445555-eeee-6666-ffff-7777aaaa8888 Reports App
```

This command retrieves all service principals from the directory.

### Example 4: Retrieve top three service principal from the directory

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal -Top 3
```

```output
ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
bbbbbbbb-1111-2222-3333-cccccccccccc 00001111-aaaa-2222-bbbb-3333cccc4444 Demo App
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 22223333-cccc-4444-dddd-5555eeee6666 Demo Two App
dddddddd-3333-4444-5555-eeeeeeeeeeee 33334444-dddd-5555-eeee-6666ffff7777 ProjectWorkManagement
```

This command retrieves top three service principals from the directory.

### Example 5: Get a service principal by display name

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal -Filter "DisplayName eq 'ProjectWorkManagement'"
```

```output
ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
dddddddd-3333-4444-5555-eeeeeeeeeeee 33334444-dddd-5555-eeee-6666ffff7777 ProjectWorkManagement
```

This command gets a service principal by its display name.

### Example 6: Retrieve a list of all service principal that have a display name that contains "ProjectWorkManagement"

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal -SearchString "ProjectWorkManagement"
```

```output
ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
dddddddd-3333-4444-5555-eeeeeeeeeeee 33334444-dddd-5555-eeee-6666ffff7777 ProjectWorkManagement
```

This command gets a list of service principal, which has the specified display name.

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

### -Filter

Specifies an oData v3.0 filter statement.
This parameter controls which objects are returned.

```yaml
Type: System.String
Parameter Sets: GetQuery
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
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SearchString

Specifies a search string.

```yaml
Type: System.String
Parameter Sets: GetVague
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
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

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[Remove-EntraServicePrincipal](Remove-EntraServicePrincipal.md)

[Set-EntraServicePrincipal](Set-EntraServicePrincipal.md)
