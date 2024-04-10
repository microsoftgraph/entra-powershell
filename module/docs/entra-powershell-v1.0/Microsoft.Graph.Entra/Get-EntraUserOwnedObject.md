---
title: Get-EntraUserOwnedObject
description: This article provides details on the Get-EntraUserOwnedObject command.

ms.service: active-directory
ms.topic: reference
ms.date: 02/29/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraUserOwnedObject

## SYNOPSIS
Get objects owned by a user.

## SYNTAX

```powershell
Get-EntraUserOwnedObject 
 -ObjectId <String> 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUserOwnedObject cmdlet gets objects owned by a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get objects owned by a user
```powershell
PS C:\>Get-EntraUserOwnedObject -ObjectId "df19e8e6-2ad7-453e-87f5-037f6529ae16"
```

```output
ObjectId                             ObjectType
--------                             ----------
9c2564d6-e4d7-4167-a79f-4b961512f232 Group
36db8aaf-022a-448d-aedc-34ef2ceb943c Group
529b48fb-6324-4899-88ab-fb9bd9ed0fd4 Group
0e6cf869-82ca-4647-b330-420b9a6f8ef7 Group
78045c26-218e-46fb-94b6-1a47320da153 Group
4c0ed9b7-cca2-4bb2-a2f1-736bb263ea0b Group
49a8bc01-2751-450b-a2e8-b4267f609513 Application
a0dada57-89ef-4db8-9e5f-46cca3bf2398 Group
```

This command gets objects owned by the specified user.

### Example 2: Get all objects owned by a user
```powershell
PS C:\>Get-EntraUserOwnedObject -ObjectId "df19e8e6-2ad7-453e-87f5-037f6529ae16" -All $true
```

```output
ObjectId                             ObjectType
--------                             ----------
9c2564d6-e4d7-4167-a79f-4b961512f232 Group
36db8aaf-022a-448d-aedc-34ef2ceb943c Group
529b48fb-6324-4899-88ab-fb9bd9ed0fd4 Group
0e6cf869-82ca-4647-b330-420b9a6f8ef7 Group
78045c26-218e-46fb-94b6-1a47320da153 Group
4c0ed9b7-cca2-4bb2-a2f1-736bb263ea0b Group
49a8bc01-2751-450b-a2e8-b4267f609513 Application
a0dada57-89ef-4db8-9e5f-46cca3bf2398 Group
```

This command gets all the objects owned by the specified user.

### Example 3: Get top three objects owned by a user
```powershell
PS C:\>Get-EntraUserOwnedObject -ObjectId "df19e8e6-2ad7-453e-87f5-037f6529ae16" -Top 3
```

```output
ObjectId                             ObjectType
--------                             ----------
9c2564d6-e4d7-4167-a79f-4b961512f232 Group
36db8aaf-022a-448d-aedc-34ef2ceb943c Group
49a8bc01-2751-450b-a2e8-b4267f609513 Application
```

This command gets the top three objects owned by the specified user.

## PARAMETERS

### -All
If true, return all objects owned by this user.
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
Specifies the ID of a user (as a UPN or ObjectId) in Microsoft Entra ID.

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
