---
title: Get-EntraUserOwnedObject.
description: This article provides details on the Get-EntraUserOwnedObject command.

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

# Get-EntraUserOwnedObject

## SYNOPSIS
Get objects owned by a user.

## SYNTAX

```
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
PS C:\>Get-EntraUserOwnedObject -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
```
```output
onPremisesSamAccountName      :
preferredLanguage             :
isAssignableToRole            :
mail                          : Contoso@M365x99297270.onmicrosoft.com
securityIdentifier            : S-1-12-1-4098877435-1102923308-999175837-1598917863
membershipRule                :
classification                :
membershipRuleProcessingState :
description                   : Contoso
proxyAddresses                : {SPO:SPO_a3824036-6090-4b98-a524-36f7c1584e7f@SPO_d5aec55f-2d12-4442-8d2f-ccca95d4390e, SMTP:Contoso@M365x99297270.onmicrosoft.com}
onPremisesNetBiosName         :
id                            : f44fe7fb-462c-41bd-9d36-8e3be78c4d5f
```

This example demonstrates how to retrieve objects owned by the specified user in Microsoft Entra ID.  
This command gets objects owned by the specified user.

### Example 2: Get all objects owned by a user
```powershell
PS C:\> Get-EntraUserOwnedObject -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -All $true
```
```output
onPremisesSamAccountName      :
preferredLanguage             :
isAssignableToRole            :
mail                          : Contoso@M365x99297270.onmicrosoft.com
securityIdentifier            : S-1-12-1-4098877435-1102923308-999175837-1598917863
membershipRule                :
classification                :
membershipRuleProcessingState :
description                   : Contoso
proxyAddresses                : {SPO:SPO_a3824036-6090-4b98-a524-36f7c1584e7f@SPO_d5aec55f-2d12-4442-8d2f-ccca95d4390e, SMTP:Contoso@M365x99297270.onmicrosoft.com}
onPremisesNetBiosName         :
id                            : f44fe7fb-462c-41bd-9d36-8e3be78c4d5f
```

This example demonstrates how to retrieve all objects owned by the specified user in Microsoft Entra ID.  
This command gets all objects owned by the specified user.

### Example 3: Get top five objects owned by a user
```powershell
PS C:\> Get-EntraUserOwnedObject -ObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac" -Top 5
```
```output
onPremisesSamAccountName      :
preferredLanguage             :
isAssignableToRole            :
mail                          : Contoso@M365x99297270.onmicrosoft.com
securityIdentifier            : S-1-12-1-4098877435-1102923308-999175837-1598917863
membershipRule                :
classification                :
membershipRuleProcessingState :
description                   : Contoso
proxyAddresses                : {SPO:SPO_a3824036-6090-4b98-a524-36f7c1584e7f@SPO_d5aec55f-2d12-4442-8d2f-ccca95d4390e, SMTP:Contoso@M365x99297270.onmicrosoft.com}
onPremisesNetBiosName         :
id                            : f44fe7fb-462c-41bd-9d36-8e3be78c4d5f
```

This example demonstrates how to retrieve five objects owned by the specified user in Microsoft Entra ID.  
This command gets five objects owned by the specified user.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
