---
title: Get-EntraApplication
description: This article provides details on the Get-EntraApplication command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

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
```
Get-EntraApplication [-Filter <String>] [-All <Boolean>] [-Top <Int32>] [<CommonParameters>]
```

### GetVague
```
Get-EntraApplication [-SearchString <String>] [-All <Boolean>] [<CommonParameters>]
```

### GetById
```
Get-EntraApplication -ObjectId <String> [-All <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraApplication cmdlet gets a Microsoft Entra ID application.

## EXAMPLES

### Example 1: Get an application by display name
```
PS C:\>Get-EntraApplication -Filter "DisplayName eq 'TestName'"

ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
3ddd22e7-a150-4bb3-b100-e410dea1cb84 36ee4c6c-0812-40a2-b820-b22ebd02bce3 TestName
```

This command gets an application by its display name.

### Example 2: Get an application by ID
```
PS C:\>Get-EntraApplication -Filter "AppId eq '421599eb-eed7-4988-9b31-02b43a4d37b8'"

ObjectId                             AppId                                DisplayName     
--------                             -----                                -----------
ed192e92-84d4-4baf-997d-1e190a81f28e 421599eb-eed7-4988-9b31-02b43a4d37b8 MyNewApp
```

This command gets an application by its ID.

### Example 3: Retrieve an application by identifierUris
```
Get-EntraApplication -Filter "identifierUris/any(uri:uri eq 'http://wingtips.wingtiptoysonline.com')"
```

### Example 4: Gets top 2 applications
```
PS C:\>Get-EntraApplication -Top 2

ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
3ddd22e7-a150-4bb3-b100-e410dea1cb84 36ee4c6c-0812-40a2-b820-b22ebd02bce3 TestName
010cc9b5-fce9-485e-9566-c68debafac5f 5f783237-3457-45d8-93e7-a0edb1cfbfd1 test app
```

This command gets top 2 applications.

### Example 5: Gets all the applications
```
PS C:\>Get-EntraApplication -All $true

ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
3ddd22e7-a150-4bb3-b100-e410dea1cb84 36ee4c6c-0812-40a2-b820-b22ebd02bce3 TestName
010cc9b5-fce9-485e-9566-c68debafac5f 5f783237-3457-45d8-93e7-a0edb1cfbfd1 test app
fe8ec725-463b-4cad-aeda-545281946aac 23c4c550-62c6-4072-8fd9-4593c17282d8 test adms
```

This command gets all the applications.

## PARAMETERS

### -All
If true, return all applications.
If false, return the number of objects specified by the Top parameter

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

