---
title: Get-EntraDeletedServicePrincipal
description: This article provides details on the Get-EntraDeletedServicePrincipal command.


ms.topic: reference
ms.date: 11/14/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Entra.Applications-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraDeletedServicePrincipal

schema: 2.0.0
---

# Get-EntraDeletedServicePrincipal

## Synopsis

Retrieves the list of previously deleted service principals.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraDeletedServicePrincipal
 [-Filter <String>]
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraDeletedServicePrincipal
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraDeletedServicePrincipal
 -ServicePrincipalId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraDeletedServicePrincipal` cmdlet Retrieves the list of previously deleted service principals.

## Examples

### Example 1: Get list of deleted service principals

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraDeletedServicePrincipal
```

```Output
DisplayName                  Id                                     AppId                                SignInAudience       ServicePrincipalType
-----------                  --                                     -----                                --------------       --------------------
Contoso Marketing            bbbbbbbb-1111-2222-3333-cccccccccccc  00001111-aaaa-2222-bbbb-3333cccc4444 Application         Application
ProjectWorkManagement        aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  22223333-cccc-4444-dddd-5555eeee6666 Application         ManagedIdentity
Enterprise App1              dddddddd-3333-4444-5555-eeeeeeeeeeee  33334444-dddd-5555-eeee-6666ffff7777 Application         ManagedIdentity
```

This cmdlet retrieves the list of deleted service principals.  

### Example 2: Get list of deleted service principals using All parameter

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraDeletedServicePrincipal -All
```

```Output
DisplayName                  Id                                     AppId                                SignInAudience       ServicePrincipalType
-----------                  --                                     -----                                --------------       --------------------
Contoso Marketing            bbbbbbbb-1111-2222-3333-cccccccccccc  00001111-aaaa-2222-bbbb-3333cccc4444 Application         Application
ProjectWorkManagement        aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  22223333-cccc-4444-dddd-5555eeee6666 Application         ManagedIdentity
Enterprise App1              dddddddd-3333-4444-5555-eeeeeeeeeeee  33334444-dddd-5555-eeee-6666ffff7777 Application         ManagedIdentity
```

This cmdlet retrieves the list of deleted service principals using All parameter.  

### Example 3: Get top two deleted service principals

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraDeletedServicePrincipal -Top 2
```

```Output
DisplayName                  Id                                     AppId                                SignInAudience       ServicePrincipalType
-----------                  --                                     -----                                --------------       --------------------
Contoso Marketing            bbbbbbbb-1111-2222-3333-cccccccccccc  00001111-aaaa-2222-bbbb-3333cccc4444 Application         Application
ProjectWorkManagement        aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  22223333-cccc-4444-dddd-5555eeee6666 Application         ManagedIdentity
```

This cmdlet retrieves top two deleted service principals.

### Example 4: Get deleted service principals using SearchString parameter

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraDeletedServicePrincipal -SearchString 'Contoso Marketing'
```

```Output
DisplayName                  Id                                     AppId                                SignInAudience       ServicePrincipalType
-----------                  --                                     -----                                --------------       --------------------
Contoso Marketing            bbbbbbbb-1111-2222-3333-cccccccccccc  00001111-aaaa-2222-bbbb-3333cccc4444 Application         Application
```

This cmdlet retrieves deleted service principals using SearchString parameter.  

### Example 5: Get deleted service principals filter by display name

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraDeletedServicePrincipal -Filter "DisplayName eq 'Contoso Marketing'"
```

```Output
DisplayName                  Id                                     AppId                                SignInAudience       ServicePrincipalType
-----------                  --                                     -----                                --------------       --------------------
Contoso Marketing            bbbbbbbb-1111-2222-3333-cccccccccccc  00001111-aaaa-2222-bbbb-3333cccc4444 Application         Application
```

This cmdlet retrieves deleted service principals having specified display name.

### Example 6: Get deleted service principal by ServicePrincipalId

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraDeletedServicePrincipal -ServicePrincipalId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
DisplayName                  Id                                     AppId                                SignInAudience       ServicePrincipalType
-----------                  --                                     -----                                --------------       --------------------
Contoso Marketing            bbbbbbbb-1111-2222-3333-cccccccccccc  00001111-aaaa-2222-bbbb-3333cccc4444 Application         Application
```

This cmdlet retrieves the deleted service principal specified by ServicePrincipalId.

- `-ServicePrincipalId` parameter specifies the deleted service principal Id.

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

Retrieve only those deleted service principals that satisfy the filter.

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

### -SearchString

Retrieve only those service principals that satisfy the -SearchString value.

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

The maximum number of service principals.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases: Limit

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
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ServicePrincipalId

The unique ID of the deleted service principal to be retrieved.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

## Related Links

[Get-EntraApplication](Get-EntraApplication.md)
