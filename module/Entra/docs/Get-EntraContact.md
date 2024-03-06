---
title: Get-EntraContact
description: This article provides details on the Get-EntraContact command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraContact

## SYNOPSIS
Gets a contact from Microsoft Entra ID.

## SYNTAX

### GetQuery (Default)
```
Get-EntraContact [-Filter <String>] [-All <Boolean>] [-Top <Int32>] [<CommonParameters>]
```

### GetById
```
Get-EntraContact -ObjectId <String> [-All <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraContact cmdlet gets a contact from Microsoft Entra ID.

## EXAMPLES

### Example 1 Retrieve all contact objects in the directory
```
PS C:\> Get-EntraContact

ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
b052db07-e7ec-4c0e-b481-a5ba550b9ee7 contact@contoso.com  Contoso Contact
16e268fb-2379-4806-bcad-80e60b855acc contact1@contoso.com Contoso Contact1
b8ec01f4-0cf5-485e-9215-8db9c7acdde8 contact2@contoso.com Contoso Contact2
```

This command retrieves all contact objects in the directory.

### Example 2 Retrieve specific contact object in the directory
```
PS C:\> Get-EntraContact -ObjectId b052db07-e7ec-4c0e-b481-a5ba550b9ee7

ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
b052db07-e7ec-4c0e-b481-a5ba550b9ee7 contact@contoso.com  Contoso Contact
```

### Example 3 Retrieve all contacts objects in the directory
```
PS C:\> Get-EntraContact -All $true

ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
b052db07-e7ec-4c0e-b481-a5ba550b9ee7 contact@contoso.com  Contoso Contact
16e268fb-2379-4806-bcad-80e60b855acc contact1@contoso.com Contoso Contact1
b8ec01f4-0cf5-485e-9215-8db9c7acdde8 contact2@contoso.com Contoso Contact2
```

### Example 4 Retrieve top 2 contacts objects in the directory
```
PS C:\> Get-EntraContact -Top 2

ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
b052db07-e7ec-4c0e-b481-a5ba550b9ee7 contact@contoso.com  Contoso Contact
16e268fb-2379-4806-bcad-80e60b855acc contact1@contoso.com Contoso Contact1
```

### Example 5 Retrieve all contacts objects in the directory filter by DisplayName
```
PS C:\> Get-EntraContact -Filter "DisplayName eq 'Contoso Contact'"

ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
b052db07-e7ec-4c0e-b481-a5ba550b9ee7 contact@contoso.com  Contoso Contact
16e268fb-2379-4806-bcad-80e60b855acc contact1@contoso.com Contoso Contact1
```

## PARAMETERS

### -All
If true, return all contacts.
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
Specifies the ID of a contact in Microsoft Entra ID.

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

[Remove-EntraContact](Remove-EntraContact.md)

[Set-EntraContact](Set-EntraContact.md)

