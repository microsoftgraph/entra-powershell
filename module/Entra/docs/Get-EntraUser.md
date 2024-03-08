---
title: Get-EntraUser
description: This article provides details on the Get-EntraUser command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/06/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraUser

## SYNOPSIS
Gets a user.

## SYNTAX

### GetQuery (Default)
```
Get-EntraUser 
[-Filter <String>] 
[-All <Boolean>] 
[-Top <Int32>] 
[<CommonParameters>]
```

### GetByValue
```
Get-EntraUser 
[-SearchString <String>] 
[-All <Boolean>] 
[<CommonParameters>]
```

### GetById
```
Get-EntraUser 
-ObjectId <String> 
[-All <Boolean>] 
[<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUser cmdlet gets a user from Microsoft Entra ID.

## EXAMPLES

### Example 1: Get top ten users
```powershell
PS C:\>Get-EntraUser -Top 10
```
```output
DisplayName         Id                                   Mail                                 UserPrincipalName
-----------         --                                   ----                                 -----------------
Conf Room Adams     fd560167-ff1f-471a-8d74-3b0070abcea1 Adams@M365x99297270.OnMicrosoft.com  Adams@M365x99297270.OnMicrosoft.com
Adele Vance         412be9d1-1460-4061-8eed-cca203fcb215 AdeleV@M365x99297270.OnMicrosoft.com AdeleV@M365x99297270.OnMicrosoft.com
admin-M365x56114267 eefcad6d-7bf7-48f3-978e-22ac0788277d                                      admin-M365x56114267@M365x99297270.mail.onmicrosoft.com
MOD Administrator   996d39aa-fdac-4d97-aa3d-c81fb47362ac admin@M365x99297270.onmicrosoft.com  admin@M365x99297270.onmicrosoft.com
Alex Wilber         a23541ee-4fe9-4cf2-b628-102ebaef8f7e AlexW@M365x99297270.OnMicrosoft.com  AlexW@M365x99297270.OnMicrosoft.com
Allan Deyoung       91d71f29-1c12-40db-8a5e-70dafbb0df6f AllanD@M365x99297270.OnMicrosoft.com AllanD@M365x99297270.OnMicrosoft.com
André van den Berg  56937e4b-eb3e-4bfc-b833-8939236b2e13                                      andre5@M365x99297270.OnMicrosoft.com
Ashwini             d6873b36-81d6-4c5e-bec0-9e3ca2c86846 ashwini.karke@perennialsys.com       ashwini.karke_perennialsys.com#EXT#@M365x99297270.onmicrosoft.com
Automate Bot        c26aa946-90cd-4e9a-a8f1-43eeef655500                                      AutomateB@M365x99297270.OnMicrosoft.com
Conf Room Baker     a3ee30fe-b00d-4d7d-8921-b72ff03bb77d Baker@M365x99297270.OnMicrosoft.com  Baker@M365x99297270.OnMicrosoft.com
```

This example demonstrates how to get top ten users from Microsoft Entra ID.  

This command gets ten users.

### Example 2: Get a user by ID
```powershell
PS C:\>Get-EntraUser -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
```
```output
DisplayName     Id                                   Mail                                UserPrincipalName
-----------     --                                   ----                                -----------------
Conf Room Adams fd560167-ff1f-471a-8d74-3b0070abcea1 Adams@M365x99297270.OnMicrosoft.com Adams@M365x99297270.OnMicrosoft.com
```

This example demonstrates how to retrieve specific user by providing ID.  

This command gets the details of specified user.

### Example 3: Search among retrieved users
```powershell
PS C:\> Get-EntraUser -SearchString "New"
```
```output
ObjectId                             DisplayName UserPrincipalName                   UserType
--------                             ----------- -----------------                   --------
5e8b0f4d-2cd4-4e17-9467-b0f6a5c0c4d0 New user    NewUser@contoso.onmicrosoft.com     Member
2b450b8e-1db6-42cb-a545-1b05eb8a358b New user    NewTestUser@contoso.onmicrosoft.com Member
```

This example demonstrates how to retrieve users for specific string from Microsoft Entra ID.  

This cmdlet gets all users that match the value of SearchString against the first characters in DisplayName or UserPrincipalName.

### Example 4: Get a user by userPrincipalName
```powershell
PS C:\>Get-EntraUser -Filter "userPrincipalName eq 'jondoe@contoso.com'"
```
```output
ObjectId                             DisplayName UserPrincipalName                   UserType
--------                             ----------- -----------------                   --------
5e8b0f4d-2cd4-4e17-9467-b0f6a5c0c4d0 New user    NewUser@contoso.onmicrosoft.com     Member
2b450b8e-1db6-42cb-a545-1b05eb8a358b New user    NewTestUser@contoso.onmicrosoft.com Member
```

In this example we'll retrieve user by userPrincipalName from Microsoft Entra ID.  

This command gets the specified user.

### Example 5: Get a user by MailNickname
```powershell
PS C:\>Get-EntraUser -Filter "startswith(MailNickname,'Ada')"
```
```output
DisplayName     Id                                   Mail                                UserPrincipalName
-----------     --                                   ----                                -----------------
Conf Room Adams fd560167-ff1f-471a-8d74-3b0070abcea1 Adams@M365x99297270.OnMicrosoft.com Adams@M365x99297270.OnMicrosoft.com
```

In this example we'll retrieve all users whose MailNickname starts with Ada.


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

### -ObjectId
Specifies the ID (as a UPN or ObjectId) of a user in Microsoft Entra ID.

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

[New-EntraUser](New-EntraUser.md)

[Remove-EntraUser](Remove-EntraUser.md)

[Set-EntraUser](Set-EntraUser.md)

