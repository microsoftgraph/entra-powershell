---
title: Get-EntraBetaApplication
description: This article provides details on the Get-EntraBetaApplication command.

ms.topic: reference
ms.date: 06/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaApplication

schema: 2.0.0
---

# Get-EntraBetaApplication

## Synopsis

Gets an application.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraBetaApplication
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraBetaApplication
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaApplication
 -ApplicationId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaApplication` cmdlet gets a Microsoft Entra ID application.

## Examples

### Example 1: Get an application by ApplicationId

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplication -ApplicationId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
DisplayName         Id                                   AppId                                SignInAudience PublisherDomain
-----------         --                                   -----                                -------------- ---------------
ToGraph_443democc3c aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADMyOrg   contoso.com
```

This example demonstrates how to retrieve specific application by providing ID.

### Example 2: Get all applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplication -All 
```

```Output
DisplayName         Id                                   AppId                                SignInAudience                     PublisherDomain
-----------         --                                   -----                                --------------                     ---------------
test app            aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADandPersonalMicrosoftAccount contoso.com
ToGraph_443DEM      cccccccc-4444-5555-6666-dddddddddddd dddddddd-5555-6666-7777-eeeeeeeeeeee AzureADMyOrg                       contoso.com
test adms           eeeeeeee-6666-7777-8888-ffffffffffff ffffffff-7777-8888-9999-gggggggggggg AzureADandPersonalMicrosoftAccount contoso.com
test adms app azure gggggggg-8888-9999-aaaa-hhhhhhhhhhhh hhhhhhhh-9999-aaaa-bbbb-iiiiiiiiiiii AzureADandPersonalMicrosoftAccount contoso.com
test adms2          iiiiiiii-aaaa-bbbb-cccc-jjjjjjjjjjjj jjjjjjjj-bbbb-cccc-dddd-kkkkkkkkkkkk AzureADandPersonalMicrosoftAccount contoso.com
```

This example demonstrates how to get all applications from Microsoft Entra ID.

### Example 3: Get applications with expiring secrets

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplication |
    Where-Object {
        $_.PasswordCredentials.keyId -ne $null -and
        $_.PasswordCredentials.EndDateTime -lt (Get-Date).AddDays(30)
    } |
    ForEach-Object {
        $_.DisplayName,
        $_.Id,
        $_.PasswordCredentials
    }
```

```Output
CustomKeyIdentifier DisplayName EndDateTime          Hint KeyId                                SecretText StartDateTime
------------------- ----------- -----------          ---- -----                                ---------- -------------
                    AppOne      8/19/2024 9:00:00 PM 1jQ  aaaaaaaa-0b0b-1c1c-2d2d-333333333333            8/6/2024 6:07:47 PM
```

This example retrieves applications with expiring secrets within 30 days.

### Example 4: Get an application by display name

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplication -Filter "DisplayName eq 'ToGraph_443DEMO'"
```

```Output
DisplayName     Id                                   AppId                                SignInAudience PublisherDomain
-----------     --                                   -----                                -------------- ---------------
ToGraph_443DEMO cccccccc-4444-5555-6666-dddddddddddd dddddddd-5555-6666-7777-eeeeeeeeeeee AzureADMyOrg   contoso.com
```

In this example, we retrieve application by its display name from Microsoft Entra ID.

### Example 5: Search among retrieved applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplication -SearchString 'My new application 2'
```

```Output
DisplayName          Id                                   AppId                                SignInAudience                     PublisherDomain
-----------          --                                   -----                                --------------                     ---------------
My new application 2 kkkkkkkk-cccc-dddd-eeee-llllllllllll llllllll-dddd-eeee-ffff-mmmmmmmmmmmm AzureADandPersonalMicrosoftAccount contoso.com
```

This example demonstrates how to retrieve applications for specific string from Microsoft Entra ID.

### Example 6: Retrieve an application by identifierUris

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplication -Filter "identifierUris/any(uri:uri eq 'https://wingtips.wingtiptoysonline.com')"
```

This example demonstrates how to retrieve applications by its identifierUris from Microsoft Entra ID.

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

Specifies an OData v4.0 filter statement.
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

### -ApplicationId

Specifies the ID of an application in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: ObjectId

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[New-EntraBetaApplication](New-EntraBetaApplication.md)

[Remove-EntraBetaApplication](Remove-EntraBetaApplication.md)

[Set-EntraBetaApplication](Set-EntraBetaApplication.md)
