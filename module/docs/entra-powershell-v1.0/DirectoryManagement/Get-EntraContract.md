---
description: This article provides details on the Get-EntraContract command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraContract
schema: 2.0.0
title: Get-EntraContract
---

# Get-EntraContract

## Synopsis

Gets a contract.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraContract
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraContract
 -ContractId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraContract` cmdlet gets a contract information associated to a partner tenant.

In delegated scenarios with work or school accounts, the `Directory Readers` role is the only least privileged role that supports this operation for the signed-in user

## Examples

### Example 1: Get all contracts in the directory

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraContract
```

This command gets all contracts in the Microsoft Entra ID.

### Example 2: Get top two contracts in the directory

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraContract -Top 2
```

This command gets top two contracts in the Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

## Parameters

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

### -Filter

Specifies an OData v4.0 filter statement.
This parameter controls which objects are returned.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ContractId

Specifies the ID of a contract.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: ObjectId

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
Parameter Sets: GetQuery
Aliases: Limit

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: Select

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

The contract object contains the following attributes:

`contractType` - type of the contract.

Possible values are:

**SyndicationPartner** - indicates a partner that exclusively resells and manages O365 and Intune for this customer.
They resell and support their customers.
**BreadthPartner** - indicates that the partner has the ability to provide administrative support for this customer. However the partner isn't allowed to resell to the customer.
**ResellerPartner** - indicates a partner that is similar to a syndication partner, except that it doesn't have exclusive access to a tenant. In the syndication case, the customer can't buy additional direct subscriptions from Microsoft or from other partners.

`customerContextId` - unique identifier for the customer tenant referenced by this partnership.

Corresponds to the ObjectId property of the customer tenant's TenantDetail object.

`defaultDomainName` - a copy of the customer tenant's default domain name. The copy is made when the partnership with the customer is established. It isn't automatically updated if the customer tenant's default domain name changes.

`deletionTimestamp` - this property isn't valid for contracts and always returns null.

`displayName` - a copy of the customer tenant's display name. The copy is made when the partnership with the customer is established. It isn't automatically updated if the customer tenant's display name changes.

`objectType` - a string that identifies the object type. The value is always `Contract`.

`ContractId` - the unique identifier for the partnership.

## Related links
