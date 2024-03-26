---
title: Get-EntraGroupMember.
description: This article provides details on the Get-EntraGroupMember command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/06/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraGroupMember

## SYNOPSIS
Gets a member of a group.

## SYNTAX

```
Get-EntraGroupMember 
 -ObjectId <String> 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraGroupMember cmdlet gets a member of a group in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get a group member by ID
```powershell
PS C:\>Get-EntraGroupMember -ObjectId "05b0552e-39cd-4df4-a8f5-00ade912e83d" 
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {meganb@m365x99297270.onmicrosoft.com}
preferredLanguage               :
mail                            : MeganB@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-719509883-1118456798-2440872119-1998244260
identities                      : {@{signInType=userPrincipalName; issuer=M365x99297270.onmicrosoft.com; issuerAssignedId=MeganB@M365x99297270.OnMicrosoft.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
```

This example demonstrates how to retrieve group member by ID.  

### Example 2: Get two group member
```powershell
PS C:\>Get-EntraGroupMember -ObjectId "0a58c57b-a9ae-49a2-824f-8e9cb86d4512" -Top 2 
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {admin@m365x99297270.onmicrosoft.com}
preferredLanguage               : en
mail                            : admin@M365x99297270.onmicrosoft.com
securityIdentifier              : S-1-12-1-2574072234-1301806508-533216682-2892133300
identities                      : {System.Collections.Hashtable}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :

ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {pradeepg@m365x99297270.onmicrosoft.com}
preferredLanguage               :
mail                            : PradeepG@M365x99297270.OnMicrosoft.com
securityIdentifier              : S-1-12-1-357891266-1147903342-476387998-329568156
identities                      : {System.Collections.Hashtable}
consentProvidedForMinor         :
```

This example demonstrates how to retrieve top two groups from Microsoft Entra ID.  

### Example 3: Get all members within a group by group ID
```powershell
PS C:\>Get-EntraGroupMember -ObjectId "0a58c57b-a9ae-49a2-824f-8e9cb86d4512" -All $true 
```
```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {admin@m365x99297270.onmicrosoft.com}
preferredLanguage               : en
mail                            : admin@M365x99297270.onmicrosoft.com
securityIdentifier              : S-1-12-1-2574072234-1301806508-533216682-2892133300
identities                      : {System.Collections.Hashtable}
consentProvidedForMinor         :
```

This example retrieves all members within a group by group ID.  

## PARAMETERS

### -All
If true, return all group members.
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
Specifies the ID of a group in Microsoft Entra ID.

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

[Add-EntraGroupMember](Add-EntraGroupMember.md)

[Remove-EntraGroupMember](Remove-EntraGroupMember.md)

