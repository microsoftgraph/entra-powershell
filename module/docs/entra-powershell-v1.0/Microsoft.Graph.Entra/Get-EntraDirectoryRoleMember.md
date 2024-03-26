---
title: Get-EntraDirectoryRoleMember.
description: This article provides details on the Get-EntraDirectoryRoleMember command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDirectoryRoleMember

## SYNOPSIS
Gets members of a directory role.

## SYNTAX

```
Get-EntraDirectoryRoleMember 
 -ObjectId <String> 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraDirectoryRoleMember cmdlet gets the members of a directory role in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get members by role ID
```powershell
PS C:\>Get-EntraDirectoryRoleMember -ObjectId 1d73e796-aac5-4b3a-b7e7-74a3d1926a85
```
```Output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {admin@m365x99297270.onmicrosoft.com}
preferredLanguage               : en
mail                            : admin@M365x99297270.onmicrosoft.com
securityIdentifier              : S-1-12-1-2574072234-1301806508-533216682-2892133300
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=admin@M365x99297270.onmicrosoft.com}}
```

This command demonstrates how to get the members of the specified role.

## PARAMETERS

### -ObjectId
Specifies the ID of a directory role in Microsoft Entra ID.

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

[Add-EntraDirectoryRoleMember](Add-EntraDirectoryRoleMember.md)

[Remove-EntraDirectoryRoleMember](Remove-EntraDirectoryRoleMember.md)

