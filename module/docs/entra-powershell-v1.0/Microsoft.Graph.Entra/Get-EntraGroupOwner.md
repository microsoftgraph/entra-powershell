---
Title: Get-EntraGroupOwner.
Description: This article provides details on the Get-EntraGroupOwner command.

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

# Get-EntraGroupOwner

## Synopsis

Gets an owner of a group.

## Syntax

```powershell
Get-EntraGroupOwner 
 -ObjectId <String>  
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## Description

The Get-EntraGroupOwner cmdlet gets an owner of a group in Microsoft Entra ID.

## Examples

### Example 1: Get a group owner by ID

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupOwner -ObjectId 'vvvvvvvv-7777-9999-7777-jjjjjjjjjjjj'
```

```output
AgeGroup                        :
OnPremisesLastSyncDateTime      :
CreationType                    :
ImAddresses                     : {HaydenL@contoso.com}
PreferredLanguage               : en
Mail                            : HaydenL@contoso.com
SecurityIdentifier              : B-2-33-4-5555555555-6666666666-7777777-8888888888
Identities                      : {@{signInType=userPrincipalName; issuer=contoso.com; issuerAssignedId=HaydenL@contoso.com}}
ConsentProvidedForMinor         :
OnPremisesUserPrincipalName     :
```

This example demonstrates how to retrieve the owner of a specific group.  

### Example 2: Gets all group owners

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupOwner -ObjectId 'zzzzzzzz-6666-8888-9999-pppppppppppp' -All
```

```output
AgeGroup                        :
OnPremisesLastSyncDateTime      :
CreationType                    :
ImAddresses                     : {BlakeM@contoso.com}
PreferredLanguage               : en
Mail                            : BlakeM@contoso.com
SecurityIdentifier              : E-5-66-7-8888888888-9999999999-0000000-1111111111
Identities                      : {System.Collections.Hashtable}
ConsentProvidedForMinor         :
OnPremisesUserPrincipalName     :
AssignedLicenses                : {System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable...}
Department                      :
JobTitle                        :
```

This example demonstrates how to retrieve the all owner of a specific group.  

### Example 3: Gets two group owners

```powershell
Connect-Entra -Scopes 'GroupMember.Read.All'
Get-EntraGroupOwner -ObjectId 'vvvvvvvv-8888-9999-0000-jjjjjjjjjjjj' -Top 2
```

```output
AgeGroup                        :
OnPremisesLastSyncDateTime      :
CreationType                    :
ImAddresses                     : {QuinnA@contoso.com}
PreferredLanguage               : en
Mail                            : QuinnA@contoso.com
SecurityIdentifier              : D-4-55-6-7777777777-8888888888-9999999-0000000000
Identities                      : {System.Collections.Hashtable}
ConsentProvidedForMinor         :
OnPremisesUserPrincipalName     :
AssignedLicenses                : {System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable...}
Department                      :
JobTitle                        :
ProxyAddresses                  : {SMTP:QuinnA@contoso.com}
LegalAgeGroupClassification     :
AssignedPlans                   : {System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hashtable...}
Id                              : tttttttt-0000-2222-0000-aaaaaaaaaaaa
```

This example demonstrates how to retrieve the top two owners of a specific group.  

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

[Add-EntraGroupOwner](Add-EntraGroupOwner.md)

[Remove-EntraGroupOwner](Remove-EntraGroupOwner.md)
