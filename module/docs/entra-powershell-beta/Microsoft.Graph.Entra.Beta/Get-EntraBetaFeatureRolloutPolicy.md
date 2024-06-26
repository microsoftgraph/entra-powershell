---
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Get-EntraBetaFeatureRolloutPolicy

## Synopsis
Gets the policy for cloud authentication roll-out in Azure Active Directory.

## Syntax

### GetQuery (Default)
```
Get-EntraBetaFeatureRolloutPolicy [-Filter <String>] [<CommonParameters>]
```

### GetVague
```
Get-EntraBetaFeatureRolloutPolicy [-SearchString <String>] [<CommonParameters>]
```

### GetById
```
Get-EntraBetaFeatureRolloutPolicy -Id <String> [<CommonParameters>]
```

## Description
This cmdlet allows an admin to get the policy for cloud authentication rollout (users moving from federation to cloud auth) in Azure AD.
This policy is in the form of one or two FeatureRolloutPolicy objects holding groups that are assigned for cloud auth (Pass-through auth or Password hash-sync) and groups that are assigned for Seamless Single Sign-On (feature on top of PTA or PHS).

## Examples

### Example 1: Retrieves a list of all cloud authentication roll-out in Azure AD.
```
PS C:\> Get-EntraBetaFeatureRolloutPolicy

          Feature                 : PassthroughAuthentication
          Id                      : 7ca3e599-e8cc-4d31-9ed6-19dd4f88e833
          DisplayName             : Passthrough Authentication Rollout Policy
          Description             :
          IsEnabled               : True
          IsAppliedToOrganization : False
          AppliesTo               :
```

This command retrieves a list of all cloud authentication roll-out ploicies in Azure AD.

### Example 2: Retrieves cloud authentication roll-out in Azure AD with given Id.
```
PS C:\> Get-EntraBetaFeatureRolloutPolicy -Id "a03b6d9e-6654-46e6-8d0a-8ed83c675ca9"

          Feature                 : PassthroughAuthentication
          Id                      : a03b6d9e-6654-46e6-8d0a-8ed83c675ca9
          DisplayName             : Passthrough Authentication Rollout Policy
          Description             :
          IsEnabled               : True
          IsAppliedToOrganization : False
          AppliesTo               :
```

This command retrieves the policy for cloud authentication roll-out policy in Azure AD.

### Example 3: Retrieves cloud authentication roll-out in Azure AD with given Search String.
```
PS C:\> Get-EntraBetaFeatureRolloutPolicy -SearchString "Default PasswordHashSync Rollout Policy"

          Feature                 : PasswordHashSync
          Id                      : a03b6d9e-6654-46e6-8d0a-8ed83c675ca9
          DisplayName             : Default PasswordHashSync Rollout Policy
          Description             : Default PasswordHashSync Rollout Policy
          IsEnabled               : True
          IsAppliedToOrganization : False
          AppliesTo               :
```

This command retrieves the policy for cloud authentication roll-out policy in Azure AD.

## Parameters

### -Id
The unique identifier of the cloud authentication roll-out policy in Azure AD.

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SearchString
Specifies a search string.

```yaml
Type: String
Parameter Sets: GetVague
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter
The oData v3.0 filter statement. 
Controls which objects are returned.

```yaml
Type: String
Parameter Sets: GetQuery
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

### Microsoft.Online.Administration.MsFeatureRolloutPolicy
## Notes
## Related Links

[New-EntraBetaFeatureRolloutPolicy]()

[Set-EntraBetaFeatureRolloutPolicy]()

[Remove-EntraBetaFeatureRolloutPolicy]()

