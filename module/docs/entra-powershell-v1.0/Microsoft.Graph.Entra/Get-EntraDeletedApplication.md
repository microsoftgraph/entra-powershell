---
title: Get-EntraDeletedApplication
description: This article provides details on the Get-EntraDeletedApplication command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDeletedApplication

## SYNOPSIS
Retrieves the list of previously deleted applications.

## SYNTAX

### GetQuery (Default)
```powershell
Get-EntraDeletedApplication 
 [-Filter <String>] 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

### GetByValue
```powershell
Get-EntraDeletedApplication 
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

## DESCRIPTION
Retrieves the list of previously deleted applications.

## EXAMPLES

### Example 1: Get list of deleted applications.
```powershell
PS C:\> Get-EntraDeletedApplication
```

```output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
TestApp1    01157307-373c-47b0-889a-3bc57033d73e 9c17362d-20b6-4572-bb6f-600e57c840e5 AzureADMyOrg   contoso.com
TestApp2    021b7606-8ad9-4a99-a305-32c7e9d4ef42 ed463582-f4c6-401e-963c-8b1207f11ff0 AzureADMyOrg   contoso.com
TestApp3    028f64e2-df14-4211-95ac-d97012de48e4 6bb88aa2-5525-4711-9091-0379c9119547 AzureADMyOrg   contoso.com
TestApp4    04a4b3be-a050-4627-83e3-0cbe80be8946 e29d0e59-86f7-41db-9d72-cd007dff50ea AzureADMyOrg   contoso.com
```

This cmdlet retrieves the list of deleted applications.  

### Example 2: Get list of deleted applications using All parameter.
```powershell
PS C:\> Get-EntraDeletedApplication -All
```

```output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
TestApp1    01157307-373c-47b0-889a-3bc57033d73e 9c17362d-20b6-4572-bb6f-600e57c840e5 AzureADMyOrg   contoso.com
TestApp2    021b7606-8ad9-4a99-a305-32c7e9d4ef42 ed463582-f4c6-401e-963c-8b1207f11ff0 AzureADMyOrg   contoso.com
TestApp3    028f64e2-df14-4211-95ac-d97012de48e4 6bb88aa2-5525-4711-9091-0379c9119547 AzureADMyOrg   contoso.com
TestApp4    04a4b3be-a050-4627-83e3-0cbe80be8946 e29d0e59-86f7-41db-9d72-cd007dff50ea AzureADMyOrg   contoso.com
```

This cmdlet retrieves the list of deleted applications using All parameter.  

### Example 3: Get top two deleted applications.
```powershell
PS C:\> Get-EntraDeletedApplication -Top 2
```

```output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
TestApp1    01157307-373c-47b0-889a-3bc57033d73e 9c17362d-20b6-4572-bb6f-600e57c840e5 AzureADMyOrg   contoso.com
TestApp2    021b7606-8ad9-4a99-a305-32c7e9d4ef42 ed463582-f4c6-401e-963c-8b1207f11ff0 AzureADMyOrg   contoso.com
```

This cmdlet retrieves top two deleted applications.

### Example 4: Get deleted applications using SearchString parameter.
```powershell
PS C:\> Get-EntraDeletedApplication -SearchString 'TestApp1'
```

```output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
TestApp1    01157307-373c-47b0-889a-3bc57033d73e 9c17362d-20b6-4572-bb6f-600e57c840e5 AzureADMyOrg   contoso.com
```

This cmdlet retrieves deleted applications using SearchString parameter.  

### Example 5: Get deleted applications filter by display name.
```powershell
PS C:\> Get-EntraDeletedApplication -Filter "DisplayName contains 'TestApp1'"
```

```output
DisplayName Id                                   AppId                                SignInAudience PublisherDomain
----------- --                                   -----                                -------------- ---------------
TestApp1    01157307-373c-47b0-889a-3bc57033d73e 9c17362d-20b6-4572-bb6f-600e57c840e5 AzureADMyOrg   contoso.com
```

This cmdlet retrieves deleted applications having specified display name.  

## PARAMETERS

### -All
List all pages.

```yaml
Type: Boolean
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
Type: String
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
The maximum number of applications returned by this cmdlet.
The default value is 100.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS