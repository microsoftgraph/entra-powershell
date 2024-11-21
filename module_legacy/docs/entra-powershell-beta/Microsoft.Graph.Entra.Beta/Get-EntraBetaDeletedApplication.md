---
title: Get-EntraBetaDeletedApplication
description: This article provides details on the Get-EntraBetaDeletedApplication command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaDeletedApplication

schema: 2.0.0
---

# Get-EntraBetaDeletedApplication

## Synopsis

Retrieves the list of previously deleted applications.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaDeletedApplication
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraBetaDeletedApplication
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaDeletedApplication` cmdlet Retrieves the list of previously deleted applications.

Note: Deleted security groups are permanently removed and cannot be retrieved.

## Examples

### Example 1: Get list of deleted applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaDeletedApplication
```

```Output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
TestApp1    aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADMyOrg   contoso.com
TestApp2    cccccccc-4444-5555-6666-dddddddddddd dddddddd-5555-6666-7777-eeeeeeeeeeee AzureADMyOrg   contoso.com
TestApp3    eeeeeeee-6666-7777-8888-ffffffffffff ffffffff-7777-8888-9999-gggggggggggg AzureADMyOrg   contoso.com
TestApp4    gggggggg-8888-9999-aaaa-hhhhhhhhhhhh hhhhhhhh-9999-aaaa-bbbb-iiiiiiiiiiii AzureADMyOrg   contoso.com
```

This cmdlet retrieves the list of deleted applications.  

### Example 2: Get list of deleted applications using All parameter

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaDeletedApplication -All
```

```Output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
TestApp1    aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADMyOrg   contoso.com
TestApp2    cccccccc-4444-5555-6666-dddddddddddd dddddddd-5555-6666-7777-eeeeeeeeeeee AzureADMyOrg   contoso.com
TestApp3    eeeeeeee-6666-7777-8888-ffffffffffff ffffffff-7777-8888-9999-gggggggggggg AzureADMyOrg   contoso.com
TestApp4    gggggggg-8888-9999-aaaa-hhhhhhhhhhhh hhhhhhhh-9999-aaaa-bbbb-iiiiiiiiiiii AzureADMyOrg   contoso.com
```

This cmdlet retrieves the list of deleted applications using All parameter.  

### Example 3: Get top two deleted applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaDeletedApplication -Top 2
```

```Output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
TestApp1    aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADMyOrg   contoso.com
TestApp2    cccccccc-4444-5555-6666-dddddddddddd dddddddd-5555-6666-7777-eeeeeeeeeeee AzureADMyOrg   contoso.com
```

This cmdlet retrieves top two deleted applications.

### Example 4: Get deleted applications using SearchString parameter

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaDeletedApplication -SearchString 'TestApp1'
```

```Output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
TestApp1    aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADMyOrg   contoso.com
```

This cmdlet retrieves deleted applications using SearchString parameter.  

### Example 5: Get deleted applications filter by display name

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaDeletedApplication -Filter "DisplayName eq 'TestApp1'"
```

```Output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
TestApp1    aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADMyOrg   contoso.com
```

This cmdlet retrieves deleted applications having specified display name.  

### Example 6: Get deleted applications with deletion age in days

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaDeletedApplication |
    Select-Object DisplayName, Id, AppId, SignInAudience, PublisherDomain, DeletedDateTime,
        @{Name='DeletionAgeInDays'; Expression={(Get-Date) - $_.DeletedDateTime | Select-Object -ExpandProperty Days}} |
    Format-Table -AutoSize
```

```Output
DisplayName           Id                                   AppId                                SignInAudience PublisherDomain        DeletedDateTime      DeletionAgeInDays
-----------           --                                   -----                                -------------- ---------------        ---------------      -----------------
Entra PowerShell App aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADMyOrg   contoso.com 9/18/2024 7:41:44 AM                 1
```

This cmdlet retrieves deleted applications with deletion age in days.

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

Retrieve only those deleted applications that satisfy the filter.

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

Retrieve only those applications that satisfy the -SearchString value.

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

The maximum number of applications returned by this cmdlet.
The default value is 100.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

## Related Links

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)
