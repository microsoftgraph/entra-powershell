---
Title: Get-EntraBetaUserManager.
Description: This article provides details on the Get-EntraBetaUserManager command.

Ms.service: active-directory
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG
Author: msewaweru
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Get-EntraBetaUserManager

## Synopsis
Gets the manager of a user.

## Syntax

```
Get-EntraBetaUserManager 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description
The Get-EntraBetaUserManager cmdlet gets the manager of a user in Microsoft Entra ID.

## Examples

### Example 1: Get the manager of a user
```powershell
PS C:\>Get-EntraBetaUserManager -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
```
```output
DeletedDateTime                 :
Id                              : 26bb22db-6b8e-4adb-b761-264c869d5245
@odata.context                  : https://graph.microsoft.com/beta/$metadata#directoryObjects/$entity
@odata.type                     : #microsoft.graph.user
AccountEnabled                  : True
BusinessPhones                  : {+1 858 555 0109}
City                            : San Diego
CreatedDateTime                 : 2023-07-07T14:18:05Z
Country                         : United States
Department                      : Sales & Marketing
DisplayName                     : Miriam Graham
```

This example demonstrates how to retrieve the manager of a specific user.  

This command gets the manager of a specified user.

## Parameters

### -ObjectId
The unique identifier of a user in Microsoft Entra ID (UserPrincipalName or ObjectId)

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Remove-EntraBetaUserManager](Remove-EntraBetaUserManager.md)

[Set-EntraBetaUserManager](Set-EntraBetaUserManager.md)

