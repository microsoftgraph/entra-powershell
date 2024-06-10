---
title: Get-EntraContact
description: This article provides details on the Get-EntraContact command.

ms.service: entra
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
```powershell
Get-EntraContact 
 [-Filter <String>] 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraContact 
 -ObjectId <String> 
 [-All] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraContact cmdlet gets a contact from Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve all contact objects in the directory
```powershell
PS C:\> Get-EntraContact
```

```output
ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
b052db07-e7ec-4c0e-b481-a5ba550b9ee7 contact@contoso.com  Contoso Contact
16e268fb-2379-4806-bcad-80e60b855acc contact1@contoso.com Contoso Contact1
b8ec01f4-0cf5-485e-9215-8db9c7acdde8 contact2@contoso.com Contoso Contact2
```

This command retrieves all contact objects in the directory.  

### Example 2: Retrieve specific contact object in the directory
```powershell
PS C:\> Get-EntraContact -ObjectId b052db07-e7ec-4c0e-b481-a5ba550b9ee7
```

```output
ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
b052db07-e7ec-4c0e-b481-a5ba550b9ee7 contact@contoso.com  Contoso Contact
```

This command retrieves specified contact in the directory.  

### Example 3: Retrieve all contacts objects in the directory
```powershell
PS C:\> Get-EntraContact -All 
```

```output
ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
b052db07-e7ec-4c0e-b481-a5ba550b9ee7 contact@contoso.com  Contoso Contact
16e268fb-2379-4806-bcad-80e60b855acc contact1@contoso.com Contoso Contact1
b8ec01f4-0cf5-485e-9215-8db9c7acdde8 contact2@contoso.com Contoso Contact2
```

This command retrieves all the contacts in the directory.

### Example 4: Retrieve top two contacts objects in the directory
```powershell
PS C:\> Get-EntraContact -Top 2
```

```output
ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
b052db07-e7ec-4c0e-b481-a5ba550b9ee7 contact@contoso.com  Contoso Contact
16e268fb-2379-4806-bcad-80e60b855acc contact1@contoso.com Contoso Contact1
```

This command retrieves top two contacts in the directory.

### Example 5: Retrieve all contacts objects in the directory filter by DisplayName
```powershell
PS C:\> Get-EntraContact -Filter "DisplayName eq 'Contoso Contact'"
```

```output
ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
b052db07-e7ec-4c0e-b481-a5ba550b9ee7 contact@contoso.com  Contoso Contact
16e268fb-2379-4806-bcad-80e60b855acc contact1@contoso.com Contoso Contact1
```

This command retrieves contacts having the specified display name.

## PARAMETERS

### -All
List all pages.
```yaml
Type: SwitchParameter
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Remove-EntraContact](Remove-EntraContact.md)