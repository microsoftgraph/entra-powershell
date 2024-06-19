---
title: Get-EntraBetaMSApplication
description: This article provides details on the Get-EntraBetaMSApplication command.

ms.service: entra
ms.topic: reference
ms.date: 06/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSApplication

## SYNOPSIS

Retrieves the list of applications within the organization.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaMSApplication 
 [-Filter <String>] 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraBetaMSApplication 
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaMSApplication 
 -ObjectId <String> 
 [-All] 
 [<CommonParameters>]
```

## DESCRIPTION

Retrieves the list of applications within the organization.
With an ObjectId argument, it can retrieve the properties of the application object associated with the ObjectId.

## EXAMPLES

### Example 1: Retrieve a list of all applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaMSApplication -All
```

```output
DisplayName               Id                                   AppId                                SignInAudience             PublisherDomain
-----------               --                                   -----                                --------------             ---------------
Test App1                 aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg               Contoso.com
Test App2                 bbbbbbbb-1111-2222-3333-cccccccccccc 11112222-bbbb-3333-cccc-4444dddd5555 AzureADMyOrg               Contoso.com
Test App3                 cccccccc-2222-3333-4444-dddddddddddd 22223333-cccc-4444-dddd-5555eeee6666 AzureADMyOrg               Contoso.com
Test App4                 dddddddd-3333-4444-5555-eeeeeeeeeeee 33334444-dddd-5555-eeee-6666ffff7777 AzureADMyOrg               Contoso.com
Test App5                 eeeeeeee-4444-5555-6666-ffffffffffff 44445555-eeee-6666-ffff-7777aaaa8888 AzureADMyOrg               Contoso.com
```

This command gets all the applications.

### Example 2: Get the first two applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaMSApplication -Top 2
```

```output
DisplayName               Id                                   AppId                                SignInAudience             PublisherDomain
-----------               --                                   -----                                --------------             ---------------
Test App1                 aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg               Contoso.com
Test App2                 bbbbbbbb-1111-2222-3333-cccccccccccc 11112222-bbbb-3333-cccc-4444dddd5555 AzureADMyOrg               Contoso.com            
```

This command gets the first two applications.

### Example 3: Get an application by display name

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaMSApplication -Filter "DisplayName eq 'Test App1'"
```

```output
DisplayName               Id                                   AppId                                SignInAudience             PublisherDomain
-----------               --                                   -----                                --------------             ---------------
Test App1                 aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg               Contoso.com
```

This command gets an application by its display name.

### Example 4: Get an application by ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaMSApplication -Filter "AppId eq '00001111-aaaa-2222-bbbb-3333cccc4444'"
```

```output
DisplayName               Id                                   AppId                                SignInAudience             PublisherDomain
-----------               --                                   -----                                --------------             ---------------
Test App1                 aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg               Contoso.com
```

This command gets an application by its ID.

### Example 5: Retrieve an application by identifierUris

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaMSApplication -Filter "identifierUris/any(uri:uri eq 'https://wingtips.wingtiptoysonline.com')"
```

```output
DisplayName               Id                                   AppId                                SignInAudience             PublisherDomain
-----------               --                                   -----                                --------------             ---------------
Test App1                 aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg               Contoso.com
```

This command gets an application by its IdentifierUris.

### Example 6: Get an application by object ID

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaMSApplication -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```output
DisplayName               Id                                   AppId                                SignInAudience             PublisherDomain
-----------               --                                   -----                                --------------             ---------------
Test App1                 aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg               Contoso.com
```

This command gets an application by its object ID.

### Example 7: Retrieve a list of all applications, which have a display name that contains "Test"

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaMSApplication -SearchString 'Test'
```

```output
DisplayName               Id                                   AppId                                SignInAudience             PublisherDomain
-----------               --                                   -----                                --------------             ---------------
Test App1                 aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMyOrg               Contoso.com
Test App2                 bbbbbbbb-1111-2222-3333-cccccccccccc 11112222-bbbb-3333-cccc-4444dddd5555 AzureADMyOrg               Contoso.com
Test App3                 cccccccc-2222-3333-4444-dddddddddddd 22223333-cccc-4444-dddd-5555eeee6666 AzureADMyOrg               Contoso.com
Test App4                 dddddddd-3333-4444-5555-eeeeeeeeeeee 33334444-dddd-5555-eeee-6666ffff7777 AzureADMyOrg               Contoso.com
Test App5                 eeeeeeee-4444-5555-6666-ffffffffffff 44445555-eeee-6666-ffff-7777aaaa8888 AzureADMyOrg               Contoso.com
```

This command gets a list of applications, which have the specified display name.

## PARAMETERS

### -ObjectId

Specifies the ID of an application in Microsoft Entra ID

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Bool?

### Int?

### String

## OUTPUTS

### Microsoft.Open.MSGraph.Model.MsApplication

## NOTES

## RELATED LINKS

[New-EntraBetaMSApplication](New-EntraBetaMSApplication.md)

[Remove-EntraBetaMSApplication](Remove-EntraBetaMSApplication.md)

[Set-EntraBetaMSApplication](Set-EntraBetaMSApplication.md)
