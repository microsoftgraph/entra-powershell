---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraMSAuthorizationPolicy

## SYNOPSIS
Updates an authorization policy.

## SYNTAX

```
Set-EntraMSAuthorizationPolicy [-BlockMsolPowerShell <Boolean>]
 [-AllowedToSignUpEmailBasedSubscriptions <Boolean>] [-AllowEmailVerifiedUsersToJoinOrganization <Boolean>]
 [-DisplayName <String>] [-Description <String>] [-DefaultUserRolePermissions <DefaultUserRolePermissions>]
 [-AllowedToUseSSPR <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraMSAuthorizationPolicy cmdlet updates a Microsoft Entra ID authorization policy.

## EXAMPLES

### Example 1: Update an authorization policy
```
PS C:\>Set-EntraMSAuthorizationPolicy -DisplayName "updated displayname" -Description "updated description" -DefaultUserRolePermissions @{ AllowedToCreateApps = $false }
```

## PARAMETERS

### -AllowedToSignUpEmailBasedSubscriptions
Specifies whether users can sign up for email based subscriptions.
The initial default value is true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowedToUseSSPR
Specifies whether the Self-Serve Password Reset feature can be used by users on the tenant.
The initial default value is true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllowEmailVerifiedUsersToJoinOrganization
Specifies whether a user can join the tenant by email validation.
The initial default value is true.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BlockMsolPowerShell
Specifies whether the user-based access to the legacy service endpoint used by MSOL PowerShell is blocked or not.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultUserRolePermissions
Contains various customizable default user role permissions.

```yaml
Type: DefaultUserRolePermissions
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Specifies the description of the authorization policy.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName
Specifies the display name of the authorization policy.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.Open.MSGraph.Model.DefaultUserRolePermissions
## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraMSAuthorizationPolicy]()

