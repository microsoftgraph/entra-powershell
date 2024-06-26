---
title: Get-EntraGroupMember.
description: This article provides details on the Get-EntraGroupMember command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
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

## Synopsis

gets a member of a group.

## Syntax

```powershell
Get-EntraGroupMember 
 -ObjectId <String> 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## Description

the Get-EntraGroupMember cmdlet gets a member of a group in Microsoft Entra ID.

## Examples

### Example 1: Get a group member by ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -ObjectId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {averys@contoso.com}
preferredLanguage               :
mail                            : averys@contoso.com
securityIdentifier              : A-1-22-3-4444444444-5555555555-6666666-7777777777
identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=averys@contoso.com}}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :
```

This example demonstrates how to retrieve group member by ID.  

### Example 2: Get two group member

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -ObjectId 'hhhhhhhh-8888-9999-8888-cccccccccccc' -Top 2 
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {ParkerJ@contoso.com}
preferredLanguage               : en
mail                            : ParkerJ@contoso.com
securityIdentifier              : B-2-33-4-5555555555-6666666666-7777777-8888888888
identities                      : {System.Collections.Hashtable}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :

ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {ParkerJ@contoso.com}
preferredLanguage               :
mail                            : ParkerJ@contoso.com
securityIdentifier              : C-3-44-5-6666666666-7777777777-8888888-9999999999
identities                      : {System.Collections.Hashtable}
consentProvidedForMinor         :
```

This example demonstrates how to retrieve top two groups from Microsoft Entra ID.  

### Example 3: Get all members within a group by group ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -ObjectId 'tttttttt-0000-2222-0000-aaaaaaaaaaaa' -All 
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {SawyerM@contoso.com}
preferredLanguage               : en
mail                            : SawyerM@contoso.com
securityIdentifier              : D-4-55-6-7777777777-8888888888-9999999-0000000000
identities                      : {System.Collections.Hashtable}
consentProvidedForMinor         :
```

This command is used to retrieve all members of a specific group. The `-ObjectId` parameter specifies the ID of the group whose members should be retrieved. The `-All` parameter indicates that all members of the group should be retrieved.

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ObjectId

Specifies the ID of a group in Microsoft Entra ID.

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

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
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

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraGroupMember](Add-EntraGroupMember.md)

[Remove-EntraGroupMember](Remove-EntraGroupMember.md)
