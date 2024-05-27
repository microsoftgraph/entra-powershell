---
title: Set-EntraDirSyncFeature
description: This article provides details on the Set-EntraDirSyncFeature command.

ms.service: entra
ms.topic: reference
ms.date: 03/28/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraDirSyncFeature

## SYNOPSIS
Used to set identity synchronization features for a tenant.

## SYNTAX

```powershell
Set-EntraDirSyncFeature 
 -Feature <String> 
 -Enabled <Boolean> 
 [-TenantId <Guid>] 
 [-Force] 
 [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraDirSyncFeature cmdlet sets identity synchronization features for a tenant.  

You can use the following synchronization features with this cmdlet:  
- **EnableSoftMatchOnUpn**: Soft match is the process used to link an object being synced from on-premises for the first time with one that already exists in the cloud. When this feature is enabled, soft match is attempted using the standard logic, based on the primary SMTP address. If a match isn't found based on primary SMTP, then a match is attempted based on UserPrincipalName. Once this feature is enabled, it can't be disabled.
- **PasswordSync**
- **SynchronizeUpnForManagedUsers**: Allows for the synchronization of UserPrincipalName updates from on-premises for managed (nonfederated) users that are assigned a license. These updates are blocked if this feature isn't enabled. Once this feature is enabled, it can't be disabled.
- **BlockSoftMatch**: When this feature is enabled, it blocks the soft match feature. Customers are encouraged to enable this feature and keep it enabled until soft matching is required again for their tenancy. This flag should be enabled again after any soft matching is completed and is no longer needed.
- **BlockCloudObjectTakeoverThroughHardMatch**: When this feature isn't enabled, and
    -  an object is synced for which an object with a matching source anchor already exists in Microsoft Entra ID and,
    - that object in Microsoft Entra ID doesn't have DirSyncEnabled set to "true", then    
    the default behavior would be to hard match the cloud object with the on premises object and set the DirSyncEnabled flag of the Cloud object to "true". <br><br>
    When enabling this feature, the cloud object is no longer matched and the DirSyncEnabled flag isn't set to "true". Instead, an error is thrown: Error Code: `InvalidHardMatch`, Error Message: `Another cloud created object with the same source anchor already exists in Microsoft Entra ID`.

Enabling some of these features, such as EnableSoftMatchOnUpn and SynchronizationUpnForManagedUsers, is a permanent operation.
You can't disable these features once they're enabled.

## EXAMPLES

### Example 1: Enable a feature for the tenant
```powershell
PS C:\> Set-EntraDirSyncFeature -Feature EnableSoftMatchOnUpn -Enable $True
```

This command enables the SoftMatchOnUpn feature for the tenant.

### Example 2: Block Soft Matching for the tenant
```powershell
PS C:\> Set-EntraDirSyncFeature -Feature BlockSoftMatch -Enable $True
```

This command enables the BlockSoftMatch feature for the tenant - effectively blocking the Soft Matching feature in the tenant.

### Example 3: Block Cloud object takeover through Hard Matching for the tenant
```powershell
PS C:\> Set-EntraDirSyncFeature -Feature BlockCloudObjectTakeoverThroughHardMatch -Enable $True
```

This command enables the BlockCloudObjectTakeoverThroughHardMatch feature for the tenant - effectively blocking the Hard Match object takeover.

## PARAMETERS

### -Feature
The DirSync feature to turn on or off.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Enable
Indicates whether the specified features are turned on for the company.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TenantId
The unique ID of the tenant to perform the operation on.
If this isn't provided then the value defaults to the tenant of the current user.
This parameter is only applicable to partner users.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Force
Forces the command to run without asking for user confirmation.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraDirSyncFeatures](./Get-EntraDirSyncFeatures.md)