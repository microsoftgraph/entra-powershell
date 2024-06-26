---
Title: Get-EntraUserManager.
Description: This article provides details on the Get-EntraUserManager command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG
Author: msewaweru
External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Get-EntraUserManager

## Synopsis

Gets the manager of a user.

## Syntax

```powershell
Get-EntraUserManager 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description

The Get-EntraUserManager cmdlet gets the manager of a user in Microsoft Entra ID.

## Examples

### Example 1: Get the manager of a user

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUserManager -ObjectId 'eeeeeeee-4444-5555-6666-ffffffffffff'
```

```output
AgeGroup                        :
OnPremisesLastSyncDateTime      :
CreationType                    :
ImAddresses                     : {miriamg@contoso.com}
PreferredLanguage               :
Mail                            : MiriamG@contoso.com
SecurityIdentifier              : B-2-33-4-5555555555-6666666666-7777777-8888888888
Identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=MiriamG@contoso.com}}
ConsentProvidedForMinor         :
OnPremisesUserPrincipalName     :
```

This example demonstrates how to retrieve the manager of a specific user.

## Parameters

### -ObjectId

The unique identifier of a user in Microsoft Entra ID (UserPrincipalName or ObjectId).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Remove-EntraUserManager](Remove-EntraUserManager.md)

[Set-EntraUserManager](Set-EntraUserManager.md)
