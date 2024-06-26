---
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Remove-EntraBetaFeatureRolloutPolicyDirectoryObject

## Synopsis
allows an admin to remove a group from the cloud authentication rollout policy in Azure AD.
Users in this group will revert back to the authenticating using the global policy (in most cases this will be federation).

## Syntax

```
Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -ObjectId <String> -Id <String> [<CommonParameters>]
```

## Description
an admin will use this cmdlet to remove groups from the cloud authentication roll-out policy.
Users in these groups will start authenticating against the global authentication policy (e.g.
federation).

## Examples

### Example 1: Removes a group from the cloud authentication roll-out policy from Azure AD.
```
PS C:\> Remove-EntraBetaFeatureRolloutPolicyDirectoryObject -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9" -ObjectId "0a1068c0-dbb6-4537-9db3-b48f3e31dd76"
```

This command removes a group from the cloud authentication roll-out policy from Azure AD.

## Parameters

### -Id
The unique identifier of the cloud authentication roll-out policy in Azure AD.

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

### -ObjectId
The unique identifier of the specific Azure AD object that will be assigned to the cloud authentication roll-out policy in Azure AD.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes
## Related Links

[Add-EntraBetaFeatureRolloutPolicyDirectoryObject]()

