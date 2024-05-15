---
title: Get-EntraApplication.
description: This article provides details on the Get-EntraApplication command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 03/18/2024
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
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

### GetByValue
```powershell
Get-EntraApplication 
 [-SearchString <String>] 
 [-All <Boolean>] 
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraApplication 
 -ObjectId <String> 
 [-All <Boolean>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraApplication cmdlet gets a Microsoft Entra ID application.

## EXAMPLES

### Example 1: Get an application by ObjectId
```powershell
PS C:\>Get-EntraApplication -ObjectId "faeae1cc-7353-4fe6-9eea-9c0ddee701f1"
```
```output
DisplayName         Id                                   AppId                                SignInAudience PublisherDomain
-----------         --                                   -----                                -------------- ---------------
ToGraph_443democc3c faeae1cc-7353-4fe6-9eea-9c0ddee701f1 ad1ca67f-4dbc-48cc-b437-dd289c58f464 AzureADMyOrg   M365x99297270.onmicrosoft.com
```
This example demonstrates how to retrieve specific application by providing ID.  
This command gets an application for the specified ObjectId.

### Example 2: Get all applications 
```powershell
PS C:\>Get- Get-EntraApplication -All $true
```
```output
DisplayName         Id                                   AppId                                SignInAudience                     PublisherDomain
-----------         --                                   -----                                --------------                     ---------------
test app            010cc9b5-fce9-485e-9566-c68debafac5f 5f783237-3457-45d8-93e7-a0edb1cfbfd1 AzureADandPersonalMicrosoftAccount M365x99297270.onmicrosoft.com
ToGraph_443DEM      02228a68-e98d-4b37-bc69-e2eaf8d324e9 3ee2fcac-fa2b-4080-a8fe-442c6536ca94 AzureADMyOrg                       M365x99297270.onmicrosoft.com
test adms           03a1489a-70ff-43e0-85f1-236e73088406 9f795b31-e4b5-4ca7-a333-6c0890d62e3c AzureADandPersonalMicrosoftAccount M365x99297270.onmicrosoft.com
test adms app azure 04080e6b-ade2-4f5e-84c5-748557d17839 f4778f5a-90a2-4a31-b9d4-b137da0848b3 AzureADandPersonalMicrosoftAccount M365x99297270.onmicrosoft.com
test adms2          049c66c6-df55-4694-b024-d07863a3f5dc 418f12ad-9795-49bb-aebd-a0102973258b AzureADandPersonalMicrosoftAccount M365x99297270.onmicrosoft.com
```

This example demonstrates how to get all applications from Microsoft Entra ID.  
This command gets the all applications in Microsoft Entra ID.

### Example 3: Get top five applications 
```powershell
PS C:\>Get-EntraApplication -Top 5
```
```output
DisplayName         Id                                   AppId                                SignInAudience                     PublisherDomain
-----------         --                                   -----                                --------------                     ---------------
test app            010cc9b5-fce9-485e-9566-c68debafac5f 5f783237-3457-45d8-93e7-a0edb1cfbfd1 AzureADandPersonalMicrosoftAccount M365x99297270.onmicrosoft.com
ToGraph_443DEM      02228a68-e98d-4b37-bc69-e2eaf8d324e9 3ee2fcac-fa2b-4080-a8fe-442c6536ca94 AzureADMyOrg                       M365x99297270.onmicrosoft.com
test adms           03a1489a-70ff-43e0-85f1-236e73088406 9f795b31-e4b5-4ca7-a333-6c0890d62e3c AzureADandPersonalMicrosoftAccount M365x99297270.onmicrosoft.com
test adms app azure 04080e6b-ade2-4f5e-84c5-748557d17839 f4778f5a-90a2-4a31-b9d4-b137da0848b3 AzureADandPersonalMicrosoftAccount M365x99297270.onmicrosoft.com
test adms2          049c66c6-df55-4694-b024-d07863a3f5dc 418f12ad-9795-49bb-aebd-a0102973258b AzureADandPersonalMicrosoftAccount M365x99297270.onmicrosoft.com
```

This example demonstrates how to get top five applications from Microsoft Entra ID.  
This command gets the top five applications.

### Example 4: Get an application by display name
```powershell
PS C:\>Get-EntraApplication -Filter "DisplayName eq 'ToGraph_443DEMO'"
```
```output
DisplayName     Id                                   AppId                                SignInAudience PublisherDomain
-----------     --                                   -----                                -------------- ---------------
ToGraph_443DEMO 5e1ac4d3-015e-404a-87df-b108a9a7f924 d92f1688-37a7-4b2d-9db4-7efdecd4db10 AzureADMyOrg   M365x99297270.onmicrosoft.com
```

In this example, we retrieve application by userPrincipalName from Microsoft Entra ID.   
This command gets an application by its display name.

### Example 5: Search among retrieved applications
```powershell
PS C:\>Get-EntraApplication -SearchString "My new application 2"
```
```output
DisplayName          Id                                   AppId                                SignInAudience                     PublisherDomain
-----------          --                                   -----                                --------------                     ---------------
My new application 2 88a329d6-9a3d-46bb-bd24-8ba1e218d4f5 b36127fd-3bca-4e1c-8698-78d26782ed65 AzureADandPersonalMicrosoftAccount M365x99297270.onmicrosoft.com
```

This example demonstrates how to retrieve applications for specific string from Microsoft Entra ID.    
This cmdlet gets all applications that match the value of SearchString against the first characters in DisplayName.

### Example 6: Retrieve an application by identifierUris
```powershell
Get-EntraApplication -Filter "identifierUris/any(uri:uri eq 'http://wingtips.wingtiptoysonline.com')"
```
This example demonstrates how to retrieve applications by its identifierUris from Microsoft Entra ID.  

## PARAMETERS

### -All
If true, return all applications.
If false, return the number of objects specified by the Top parameter.

```yaml
Type: Boolean
Parameter Sets: (All)
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
Type: String
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
Type: String
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
Type: String
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
Type: Int32
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraApplication](New-EntraApplication.md)

[Remove-EntraApplication](Remove-EntraApplication.md)

[Set-EntraApplication](Set-EntraApplication.md)