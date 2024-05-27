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

```powershell
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
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupMember -ObjectId 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```output
ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {meganb@contoso.com}
preferredLanguage               :
mail                            : MeganB@contoso.com
securityIdentifier              : S-1-12-1-555555555-44444444-2440872119-9999999
identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=MeganB@contoso.com}}
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
imAddresses                     : {hakeem@mcontoso.com}
preferredLanguage               : en
mail                            : hakeem@contoso.com
securityIdentifier              : S-1-12-1-8888888-343434343-533216682-7676767676
identities                      : {System.Collections.Hashtable}
consentProvidedForMinor         :
onPremisesUserPrincipalName     :

ageGroup                        :
onPremisesLastSyncDateTime      :
creationType                    :
imAddresses                     : {binti@contoso.com}
preferredLanguage               :
mail                            : binti@contoso.com
securityIdentifier              : S-1-12-1-2222222-111111-676767678-33333333
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
imAddresses                     : {adellV@contoso.com}
preferredLanguage               : en
mail                            : adellV@contoso.com
securityIdentifier              : S-1-12-1-111111-000000000-3333333333-22222222
identities                      : {System.Collections.Hashtable}
consentProvidedForMinor         :
```

This command is used to retrieve all members of a specific group. The `-ObjectId` parameter specifies the ID of the group whose members should be retrieved. The `-All` parameter indicates that all members of the group should be retrieved.

## PARAMETERS

### -All

If true, return all group members.
If false, return the number of objects specified by the Top parameter.

```yaml
Type: System.Boolean
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Add-EntraGroupMember](Add-EntraGroupMember.md)

[Remove-EntraGroupMember](Remove-EntraGroupMember.md)
