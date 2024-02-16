---
title: Get-EntraBetaMSUser.
description: This article provides details on the Get-EntraBetaMSUser command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaMSUser

## SYNOPSIS
Gets a user.

## SYNTAX

### GetQuery (Default)
```
Get-EntraBetaMSUser 
 [-Top <Int32>] 
 [-All <Boolean>] 
 [-Filter <String>] 
 [-Select <String>] 
 [<CommonParameters>]
```

### GetById
```
Get-EntraBetaMSUser 
 -Id <String> 
 [-All <Boolean>] 
 [-Select <String>] 
 [<CommonParameters>]
```

### GetVague
```
Get-EntraBetaMSUser 
 [-SearchString <String>] 
 [-All <Boolean>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaMSUser cmdlet gets a user from Microsoft Entra ID. 

## EXAMPLES

### Example 1: Get a user by ID
```powershell
PS C:\> Get-EntraBetaMSUser -Id "d67d8b7b-57e1-486e-9361-26a1e2f0e8fe"
```

This command gets the specified user.

### Example 2: Get ten users
```
PS C:\>Get-EntraBetaUser -Top 10
```

This command gets ten users.

### Example 3: Get all users
```
PS C:\>Get-EntraBetaUser -All $true
```

This command gets all users in Microsoft Entra ID.

### Example 4: Get a user by DisplayName
```
PS C:\>Get-EntraBetaUser -Filter "DisplayName eq 'Alex Wilber'"
```

This command gets This command gets the specified user.

### Example 5: Search among retrieved users
```
PS C:\>Get-EntraBetaUser -SearchString "New"
```

This cmdlet gets all users that match the value of SearchString against the first characters in DisplayName or UserPrincipalName .

### Example 6: Get CustomSecurityAttributes property values for a user
```
PS C:\>Get-Get-EntraBetaMSUser -Id dbb22700-a7de-4372-ae78-0098ee60e55e -Select CustomSecurityAttributes
```

This command gets CustomSecurityAttributes property values for a specific user.

## PARAMETERS

### -All
If true, return all users.
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
Details on querying with oData can be found here.
http://www.odata.org/documentation/odata-version-3-0/odata-version-3-0-core-protocol/#queryingcollections

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

### -Id
Specifies the ID of a user in Microsoft Entra ID.

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

### -Select
Specifies the properties to be returned on the object.

```yaml
Type: String
Parameter Sets: GetQuery, GetById
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

### System.String

### System.Nullable`1[[System.Int32, System.Private.CoreLib, Version=7.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]]

### System.Nullable`1[[System.Boolean, System.Private.CoreLib, Version=7.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e]]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
[Set-EntraBetaMSUser]()