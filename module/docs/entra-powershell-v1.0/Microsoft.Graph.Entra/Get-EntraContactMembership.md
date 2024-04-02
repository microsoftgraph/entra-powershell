---
title: Get-EntraContactMembership
description: This article provides details on the Get-EntraContactMembership command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraContactMembership

## SYNOPSIS
Get a contact membership.

## SYNTAX

```powershell
Get-EntraContactMembership 
    -ObjectId <String> 
    [-All <Boolean>] 
    [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The **Get-EntraContactMembership** cmdlet gets a contact membership in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get the memberships of a contact
```powershell
PS C:\> $Contact = Get-EntraContact -Top 1
PS C:\> Get-EntraContactMembership -ObjectId $Contact.ObjectId
```

```output
Id                                   DeletedDateTime
--                                   ---------------
69641f6c-41dc-4f63-9c21-cc9c8ed12931
4484fbc1-0d0e-4cc3-96e3-162f1e4acf35
68ac8234-a304-4f1c-8b07-6f4a6bdcaca7
```

The first command gets a contact by using the [Get-EntraContact](./Get-EntraContact.md) cmdlet, and then stores it in the $Contact variable.  

The second command gets the memberships for $Contact.  

### Example 2: Get all memberships of a contact
```powershell
PS C:\> Get-EntraContactMembership -ObjectId d110c2ba-d5ef-4e4d-aa22-b964ba966895 -All $true
```

```output
Id                                   DeletedDateTime
--                                   ---------------
69641f6c-41dc-4f63-9c21-cc9c8ed12931
4484fbc1-0d0e-4cc3-96e3-162f1e4acf35
68ac8234-a304-4f1c-8b07-6f4a6bdcaca7
```

This command gets all the memberships for specified contact.

### Example 3: Get top two memberships of a contact
```powershell
PS C:\> Get-EntraContactMembership -ObjectId d110c2ba-d5ef-4e4d-aa22-b964ba966895 -Top 2
```

```output
Id                                   DeletedDateTime
--                                   ---------------
69641f6c-41dc-4f63-9c21-cc9c8ed12931
4484fbc1-0d0e-4cc3-96e3-162f1e4acf35
```

This command gets top two memberships for specified contact.

## PARAMETERS

### -All
If true, return all memberships.
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

### -ObjectId
Specifies the ID of a contact in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: (All)
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
Parameter Sets: (All)
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

[Get-EntraContact](Get-EntraContact.md)

