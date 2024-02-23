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

### GetValue
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
PS C:\> Get-EntraBetaMSUser -Id d67d8b7b-57e1-486e-9361-26a1e2f0e8fe

DisplayName Id                                   Mail UserPrincipalName
----------- --                                   ---- -----------------
test1       d67d8b7b-57e1-486e-9361-26a1e2f0e8fe      test1@M365x99297270.OnMicrosoft.com
```

This command gets the specified user.

### Example 2: Get five users
```
PS C:\>Get-EntraBetaMSUser -Top 5

DisplayName       Id                                   Mail                                 UserPrincipalName
-----------       --                                   ----                                 -----------------
Conf Room Adams   fd560167-ff1f-471a-8d74-3b0070abcea1 Adams@M365x99297270.OnMicrosoft.com  Adams@M365x99297270.OnMicrosoft.com
Adele Vance       412be9d1-1460-4061-8eed-cca203fcb215 AdeleV@M365x99297270.OnMicrosoft.com AdeleV@M365x99297270.OnMicrosoft.com
MOD Administrator 996d39aa-fdac-4d97-aa3d-c81fb47362ac admin@M365x99297270.onmicrosoft.com  admin@M365x99297270.onmicrosoft.com
Alex Wilber       a23541ee-4fe9-4cf2-b628-102ebaef8f7e AlexW@M365x99297270.OnMicrosoft.com  AlexW@M365x99297270.OnMicrosoft.com
Allan Deyoung     91d71f29-1c12-40db-8a5e-70dafbb0df6f AllanD@M365x99297270.OnMicrosoft.com AllanD@M365x99297270.OnMicrosoft.com
```

This command gets five users.

### Example 3: Get all users
```
PS C:\>Get-EntraBetaUser -All $true
```

This command gets all users in Microsoft Entra ID.

### Example 4: Get a user by DisplayName
```
PS C:\>Get-Get-EntraBetaMSUser -Filter "DisplayName eq 'Alex Wilber'"

DisplayName Id                                   Mail                                UserPrincipalName
----------- --                                   ----                                -----------------
Alex Wilber a23541ee-4fe9-4cf2-b628-102ebaef8f7e AlexW@M365x99297270.OnMicrosoft.com AlexW@M365x99297270.OnMicrosoft.com
```

This command gets the specified user.

### Example 5: Search among retrieved users
```
PS C:\>Get-EntraBetaMSUser -SearchString "test@"

DisplayName  Id                                   Mail             UserPrincipalName
-----------  --                                   ----             -----------------
Test Contoso 00cf5246-4c5c-4cee-b6cd-d37e62db6f27 Test@contoso.com Test_contoso.com#EXT#@M365x99297270.onmicrosoft.com
```

This cmdlet gets all users that match the value of SearchString against the first characters in DisplayName or UserPrincipalName .

### Example 6: Get CustomSecurityAttributes property values for a user
```
PS C:\>Get-EntraBetaMSUser -Id a23541ee-4fe9-4cf2-b628-102ebaef8f7e -Select CustomSecurityAttributes

CustomSecurityAttributes
------------------------
Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeValue
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