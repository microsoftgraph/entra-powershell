---
title: Get-EntraApplication.
description: This article provides details on the Get-EntraApplication command.

ms.service: active-directory
ms.topic: reference
ms.date: 06/04/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraApplication

## SYNOPSIS

Gets an application.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraApplication 
 [-Filter <String>] 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraApplication 
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraApplication 
 -ObjectId <String> 
 [-All] 
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraApplication` cmdlet gets a Microsoft Entra ID application.

## EXAMPLES

### Example 1: Get an application by ObjectId

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplication -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```output
DisplayName         Id                                   AppId                                SignInAudience PublisherDomain
-----------         --                                   -----                                -------------- ---------------
ToGraph_443democc3c aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADMyOrg   contoso.com
```

This example demonstrates how to retrieve specific application by providing ID.  
This command gets an application for the specified ObjectId.

### Example 2: Get all applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplication -All 
```

```output
DisplayName         Id                                   AppId                                SignInAudience                     PublisherDomain
-----------         --                                   -----                                --------------                     ---------------
test app            aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADandPersonalMicrosoftAccount contoso.com
ToGraph_443DEM      cccccccc-4444-5555-6666-dddddddddddd dddddddd-5555-6666-7777-eeeeeeeeeeee AzureADMyOrg                       contoso.com
test adms           eeeeeeee-6666-7777-8888-ffffffffffff ffffffff-7777-8888-9999-gggggggggggg AzureADandPersonalMicrosoftAccount contoso.com
test adms app azure gggggggg-8888-9999-aaaa-hhhhhhhhhhhh hhhhhhhh-9999-aaaa-bbbb-iiiiiiiiiiii AzureADandPersonalMicrosoftAccount contoso.com
test adms2          iiiiiiii-aaaa-bbbb-cccc-jjjjjjjjjjjj jjjjjjjj-bbbb-cccc-dddd-kkkkkkkkkkkk AzureADandPersonalMicrosoftAccount contoso.com
```

This example demonstrates how to get all applications from Microsoft Entra ID.  

### Example 3: Get top five applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplication -Top 5
```

```output
DisplayName         Id                                   AppId                                SignInAudience                     PublisherDomain
-----------         --                                   -----                                --------------                     ---------------
test app            aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADandPersonalMicrosoftAccount contoso.com
ToGraph_443DEM      cccccccc-4444-5555-6666-dddddddddddd dddddddd-5555-6666-7777-eeeeeeeeeeee AzureADMyOrg                       contoso.com
test adms           eeeeeeee-6666-7777-8888-ffffffffffff ffffffff-7777-8888-9999-gggggggggggg AzureADandPersonalMicrosoftAccount contoso.com
test adms app azure gggggggg-8888-9999-aaaa-hhhhhhhhhhhh hhhhhhhh-9999-aaaa-bbbb-iiiiiiiiiiii AzureADandPersonalMicrosoftAccount contoso.com
test adms2          iiiiiiii-aaaa-bbbb-cccc-jjjjjjjjjjjj jjjjjjjj-bbbb-cccc-dddd-kkkkkkkkkkkk AzureADandPersonalMicrosoftAccount contoso.com
```

This example demonstrates how to get top five applications from Microsoft Entra ID.

### Example 4: Get an application by display name

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplication -Filter "DisplayName eq 'ToGraph_443DEMO'"
```

```output
DisplayName     Id                                   AppId                                SignInAudience PublisherDomain
-----------     --                                   -----                                -------------- ---------------
ToGraph_443DEMO cccccccc-4444-5555-6666-dddddddddddd dddddddd-5555-6666-7777-eeeeeeeeeeee AzureADMyOrg   contoso.com
```

In this example, we retrieve application by its display name from Microsoft Entra ID.

### Example 5: Search among retrieved applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplication -SearchString 'My new application 2'
```

```output
DisplayName          Id                                   AppId                                SignInAudience                     PublisherDomain
-----------          --                                   -----                                --------------                     ---------------
My new application 2 kkkkkkkk-cccc-dddd-eeee-llllllllllll llllllll-dddd-eeee-ffff-mmmmmmmmmmmm AzureADandPersonalMicrosoftAccount contoso.com
```

This cmdlet gets all applications that match the value of SearchString against the first characters in DisplayName.

### Example 6: Retrieve an application by identifierUris

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraApplication -Filter "identifierUris/any(uri:uri eq 'http://wingtips.wingtiptoysonline.com')"
```

This example demonstrates how to retrieve applications by its identifierUris from Microsoft Entra ID.  

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

Specifies the ID of an application in Microsoft Entra ID.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

- [New-EntraApplication](New-EntraApplication.md)

- [Remove-EntraApplication](Remove-EntraApplication.md)

- [Set-EntraApplication](Set-EntraApplication.md)
