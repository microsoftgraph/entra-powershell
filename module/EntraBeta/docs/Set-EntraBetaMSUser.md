---
title: Set-EntraBetaMSUser.
description: This article provides details on the Set-EntraBetaMSUser command.

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

# Set-EntraBetaMSUser

## SYNOPSIS
Updates a user.

## SYNTAX

```
Set-EntraBetaMSUser 
 -Id <String> 
 [-CustomSecurityAttributes <Object>] 
 [-UserPrincipalName <String>]
 [-DisplayName <String>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraBetaMSUser cmdlet updates a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Update a user's display name and user principal name
```powershell
PS C:\> Set-EntraBetaMSUser -Id d67d8b7b-57e1-486e-9361-26a1e2f0e8fe -UserPrincipalName Test2@M365x99297270.onmicrosoft.com -DisplayName "Test One Updated"
```

This command updates the specified user's display name and user principal name.


### Example 2: Update a user's custom security attributes
```powershell
PS C:\> $attributes = @{
>>       engineering = @{
>>           "@odata.type" = "#Microsoft.DirectoryServices.CustomSecurityAttributeValue"
>>           "newvalue@odata.type" = "#Collection(String)"
>>          newvalue = @("Baker","Cascade")
>>       }
>> }
PS C:\> Set-EntraBetaMSUser -Id d67d8b7b-57e1-486e-9361-26a1e2f0e8fe -CustomSecurityAttributes $attributes
```

This command updates the specified user's custom security attributes.

## PARAMETERS

### -CustomSecurityAttributes
Custom security attributes for the user.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName
Specifies the user's display name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Specifies the ID of a user in Microsoft Entra ID.

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

### -UserPrincipalName
Specifies the user principal name of a user in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
