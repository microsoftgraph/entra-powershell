---
external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraDirSyncfeature

## SYNOPSIS
Used to check the status of identity synchronization features for a tenant.

## SYNTAX

```
Get-EntraDirSyncfeature [-TenantId <Guid>] [-Feature <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraDirSyncfeature cmdlet is used to check the status of identity synchronization features for a tenant.
Features that can be used with this cmdlet include:

    DeviceWriteback
    DirectoryExtensions
    DuplicateProxyAddressResiliency
    DuplicateUPNResiliency
    EnableSoftMatchOnUpn
    PasswordSync
    SynchronizeUpnForManagedUsers
    UnifiedGroupWriteback
    UserWriteback

    The cmdlet can also be run without any feature being specified, in which case it will return a list of all features and whether they are enabled or disabled.

## EXAMPLES

### EXAMPLE 1
```
Get-EntraDirSyncfeature
```

Description

-----------

Returns a list of all possible DirSync features and whether they are enabled (True) or disabled (False).

### EXAMPLE 2
```
Get-EntraDirSyncfeature -Feature PasswordSync
s
Description
```

-----------

Returns whether PasswordSync is enabled for the tenant (True) or disabled (False).

## PARAMETERS

### -TenantId
The unique ID of the tenant to perform the operation on.
If this is not provided then the value will default to the tenant of the current user.
This parameter is only applicable to partner users.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Feature
The DirSync feature to get the status of.

```yaml
Type: String
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
