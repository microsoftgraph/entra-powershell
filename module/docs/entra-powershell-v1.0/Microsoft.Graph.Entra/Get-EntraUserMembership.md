---
title: Get-EntraUserMembership.
description: This article provides details on the Get-EntraUserMembership command.

ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 03/07/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraUserMembership

## SYNOPSIS
Get user memberships.

## SYNTAX

```powershell
Get-EntraUserMembership 
 -ObjectId <String>
 [-All <Boolean>]  
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUserMembership cmdlet gets user memberships in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get user memberships
```powershell
PS C:\>Get-EntraUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
```
```output
Id                                   DeletedDateTime
--                                   ---------------
056b2531-005e-4f3e-be78-01a71ea30a04
3da073b9-e731-4ec1-a4f6-6e02865a8c8a
cc3cc7a2-ba9a-4158-814c-d5ee1af66d24
2788a657-62c9-4546-9d4d-2ddee8a8bc9b
0bdddeb1-88a6-4251-aaa5-98b48271158b
eeee7782-696d-4be3-ace0-e20c1df6693e
```

This example demonstrates how to retrieve user memberships in Microsoft Entra ID.   
This command gets the memberships for the specified user.

### Example 2: Get All memberships
```powershell
PS C:\>Get-EntraUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -All $true
```
```output
Id                                   DeletedDateTime
--                                   ---------------
056b2531-005e-4f3e-be78-01a71ea30a04
3da073b9-e731-4ec1-a4f6-6e02865a8c8a
cc3cc7a2-ba9a-4158-814c-d5ee1af66d24
2788a657-62c9-4546-9d4d-2ddee8a8bc9b
0bdddeb1-88a6-4251-aaa5-98b48271158b
eeee7782-696d-4be3-ace0-e20c1df6693e
```

This example demonstrates how to retrieve users all memberships in Microsoft Entra ID.     
This command gets the all memberships for the specified user.

### Example 3: Get top five memberships
```powershell
PS C:\>Get-EntraUserMembership -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top 5
```
```output
Id                                   DeletedDateTime
--                                   ---------------
056b2531-005e-4f3e-be78-01a71ea30a04
3da073b9-e731-4ec1-a4f6-6e02865a8c8a
cc3cc7a2-ba9a-4158-814c-d5ee1af66d24
2788a657-62c9-4546-9d4d-2ddee8a8bc9b
0bdddeb1-88a6-4251-aaa5-98b48271158b
```

This example demonstrates how to retrieve users top five memberships in Microsoft Entra ID.      
This command gets the top five memberships for the specified user.

## PARAMETERS

### -All
If true, return all memberships of this user.
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
Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.

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
