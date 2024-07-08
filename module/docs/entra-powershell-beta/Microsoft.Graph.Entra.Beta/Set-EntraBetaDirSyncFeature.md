---
external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Set-EntraBetaDirSyncFeature

## Synopsis
Used to set identity synchronization features for a tenant.

## Syntax

```
Set-EntraBetaDirSyncFeature -Feature <String> -Enabled <Boolean> [-TenantId <Guid>] [-Force]
 [<CommonParameters>]
```

## Description
The Set-EntraBetaDirSyncFeature cmdlet is used to turn identity synchronization features on or off for 
a tenant.
Features that can be used with this cmdlet include:

    SynchronizeUpnForManagedUsers- allows for the synchronization of UserPrincipalName updates from on-premises for managed (non-federated) users that have been assigned a license.
These updates will be blocked if this feature is not enabled.
Once this feature is enabled it cannot be disabled.

    EnableSoftMatchOnUpn- Soft Match is the process used to link an object being synced from on-premises for the first time with one that already exists in the cloud.
When this feature is enabled Soft Match will first be attempted using the standard logic, based on primary SMTP address.
If a match is not found based on primary SMTP, then a match will be attempted based on UserPrincipalName.
Once this feature is enabled it cannot be disabled.

    DuplicateUPNResiliency (preview)- normally if a user was attempted to be provisioned with a non-unique UserPrincipalName, the user would fail to be created/updated due to the uniqueness violation.
When this feature is enabled the conflicting UPN value will be â€œquarantinedâ€, a temporary UPN will be generated, and the user will be provisioned with that temporary UPN.
This UPN will have the format of "\<UserName\>+\<Random Integer\>@\<Tenant Initial Domain\>.onmicrosoft.com".

    DuplicateProxyAddressResiliency (preview)- normally if an object was attempted to be provisioned with a non-unique ProxyAddress, the object would fail to be created/updated due to the uniqueness violation.
When this feature is enabled the conflicting ProxyAddress value will be â€œquarantinedâ€ and the object will be provisioned without that specific ProxyAddress value.

## Examples

### Example 1
```
--------------------------  Example 1  --------------------------
    
    Set-EntraBetaDirSyncFeature -Feature EnableSoftMatchOnUpn -Enable $true
    
    Description
    
    -----------
    
    Enables the SoftMatchOnUpn feature for the tenant.
```

## Parameters

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

### -Enabled
{{ Fill Enabled Description }}

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
If this is not provided then the value will default to the tenant of the current user.
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
{{ Fill Force Description }}

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

## Inputs

## Outputs

## Notes

## Related Links
