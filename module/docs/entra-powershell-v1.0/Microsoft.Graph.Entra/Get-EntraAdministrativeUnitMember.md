---
title: Get-EntraAdministrativeUnitMember
description: This article provides details on the Get-EntraAdministrativeUnitMember command.

ms.service: entra
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraAdministrativeUnitMember

## Synopsis

Gets a member of an administrative unit.

## Syntax

```powershell
Get-EntraAdministrativeUnitMember
 -ObjectId <String> 
 [-All] 
 [-Top <Int32>]
 [<CommonParameters>]
```

## Description

The `Get-EntraAdministrativeUnitMember` cmdlet gets a member of a Microsoft Entra ID administrative unit. Specify `ObjectId` parameter to gets a member.

## Examples

### Example 1: Get an administrative unit member by ObjectId

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnitMember -ObjectId 'bbbbbbbb-1111-1111-1111-cccccccccccc'
```

```Output
visibility                    : Private
description                   :
groupTypes                    : {Unified}
displayName                   : testentra
membershipRule                :
mail                          : testentra@M365x99297270.onmicrosoft.com
theme                         :
serviceProvisioningErrors     : {}
renewedDateTime               : 02/10/2023 09:42:25
onPremisesLastSyncDateTime    :
preferredDataLocation         :
proxyAddresses                : {SMTP:testentra@M365x99297270.onmicrosoft.com}
isAssignableToRole            : True
@odata.type                   : #microsoft.graph.group             :
mailNickname                  : testentra
onPremisesSamAccountName      :
resourceBehaviorOptions       : {}
deletedDateTime               :
membershipRuleProcessingState :
securityEnabled               : True
mailEnabled                   : True
securityIdentifier            : S-1-12-1-4266007001-1094819047-283928483-4102749171
createdDateTime               : 02/10/2023 09:42:25
onPremisesDomainName          :
id                            : bbbbbbbb-1111-1111-1111-cccccccccccc
expirationDateTime            :
onPremisesSecurityIdentifier  :
ObjectId                      : bbbbbbbb-1111-1111-1111-cccccccccccc

```

This example returns the list of administrative unit members from specified administrative unit ObjectID.

### Example 2: Get all administrative unit members by ObjectId

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnitMember -ObjectId 'bbbbbbbb-1111-1111-1111-cccccccccccc' -All
```

```Output
visibility                    : Private
description                   :
groupTypes                    : {Unified}
displayName                   : testentra
membershipRule                :
mail                          : testentra@M365x99297270.onmicrosoft.com
theme                         :
serviceProvisioningErrors     : {}
renewedDateTime               : 02/10/2023 09:42:25
onPremisesLastSyncDateTime    :
preferredDataLocation         :
proxyAddresses                : {SMTP:testentra@M365x99297270.onmicrosoft.com}
isAssignableToRole            : True
@odata.type                   : #microsoft.graph.group             :
mailNickname                  : testentra
onPremisesSamAccountName      :
resourceBehaviorOptions       : {}
deletedDateTime               :
membershipRuleProcessingState :
securityEnabled               : True
mailEnabled                   : True
securityIdentifier            : S-1-12-1-4266007001-1094819047-283928483-4102749171
createdDateTime               : 02/10/2023 09:42:25
onPremisesDomainName          :
id                            : bbbbbbbb-1111-1111-1111-cccccccccccc
expirationDateTime            :
onPremisesSecurityIdentifier  :
ObjectId                      : bbbbbbbb-1111-1111-1111-cccccccccccc

```

This example returns the list of administrative unit members from specified administrative unit ObjectID.

### Example 3: Get top one administrative unit members by ObjectId

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnitMember -ObjectId 'bbbbbbbb-1111-1111-1111-cccccccccccc' -Top 1
```

```Output
visibility                    : Private
description                   :
groupTypes                    : {Unified}
displayName                   : testentra
membershipRule                :
mail                          : testentra@M365x99297270.onmicrosoft.com
theme                         :
serviceProvisioningErrors     : {}
renewedDateTime               : 02/10/2023 09:42:25
onPremisesLastSyncDateTime    :
preferredDataLocation         :
proxyAddresses                : {SMTP:testentra@M365x99297270.onmicrosoft.com}
isAssignableToRole            : True
@odata.type                   : #microsoft.graph.group             :
mailNickname                  : testentra
onPremisesSamAccountName      :
resourceBehaviorOptions       : {}
deletedDateTime               :
membershipRuleProcessingState :
securityEnabled               : True
mailEnabled                   : True
securityIdentifier            : S-1-12-1-4266007001-1094819047-283928483-4102749171
createdDateTime               : 02/10/2023 09:42:25
onPremisesDomainName          :
id                            : bbbbbbbb-1111-1111-1111-cccccccccccc
expirationDateTime            :
onPremisesSecurityIdentifier  :
ObjectId                      : bbbbbbbb-1111-1111-1111-cccccccccccc
```

This example returns top specified administrative unit members from specified administrative unit ObjectID.

## Parameters

### -ObjectId

Specifies the ID of an administrative unit in Microsoft Entra ID.

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

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraAdministrativeUnitMember](Add-EntraAdministrativeUnitMember.md)

[Remove-EntraAdministrativeUnitMember](Remove-EntraAdministrativeUnitMember.md)
