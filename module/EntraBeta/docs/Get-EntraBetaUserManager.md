---
title: Get-EntraBetaUserManager.
description: This article provides details on the Get-EntraBetaUserManager command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaUserManager

## SYNOPSIS
Gets the manager of a user.

## SYNTAX

```
Get-EntraBetaUserManager 
 -ObjectId <String> 
 [-InformationAction <ActionPreference>]
 [-InformationVariable <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraBetaUserManager cmdlet gets the manager of a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get the manager of a user
```powershell
PS C:\>Get-EntraBetaUserManager -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
```
```output
DeletedDateTime                 :
Id                              : 26bb22db-6b8e-4adb-b761-264c869d5245
@odata.context                  : https://graph.microsoft.com/beta/$metadata#directoryObjects/$entity
@odata.type                     : #microsoft.graph.user
accountEnabled                  : True
businessPhones                  : {+1 858 555 0109}
city                            : San Diego
createdDateTime                 : 2023-07-07T14:18:05Z
country                         : United States
department                      : Sales & Marketing
displayName                     : Miriam Graham
```

This example demonstrates how to retrieve the manager of a specific user.  

This command gets the manager of a specified user.

### Example 2: Get the manager of a user
```powershell
PS C:\>Get-EntraBetaUserManager -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -InformationAction Continue -InformationVariable "Test"
```
```output
DeletedDateTime                 :
Id                              : 26bb22db-6b8e-4adb-b761-264c869d5245
@odata.context                  : https://graph.microsoft.com/beta/$metadata#directoryObjects/$entity
@odata.type                     : #microsoft.graph.user
accountEnabled                  : True
businessPhones                  : {+1 858 555 0109}
city                            : San Diego
createdDateTime                 : 2023-07-07T14:18:05Z
country                         : United States
department                      : Sales & Marketing
displayName                     : Miriam Graham
givenName                       : Miriam
```

This example demonstrates how to retrieve the manager of a specific user.  

This command gets the manager of the specified user for a specified information action and information variable.

## PARAMETERS

### -InformationAction
Specifies how this cmdlet responds to an information event.
The acceptable values for this parameter are:

- Continue
- Ignore
- Inquire
- SilentlyContinue
- Stop
- Suspend

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: infa

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InformationVariable
Specifies an information variable.

```yaml
Type: String
Parameter Sets: (All)
Aliases: iv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId
The unique identifier of a user in Microsoft Entra ID (UPN or ObjectId)

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Remove-EntraBetaUserManager](Remove-EntraBetaUserManager.md)

[Set-EntraBetaUserManager](Set-EntraBetaUserManager.md)

