---
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Update-EntraBetaSignedInUserPassword

## Synopsis
Updates the password for the signed-in user.

## Syntax

```
Update-EntraBetaSignedInUserPassword -CurrentPassword <SecureString> -NewPassword <SecureString>[<CommonParameters>]
```

## Description
The Update-EntraBetaSignedInUserPassword cmdlet updates the password for the signed-in user in Azure Active Directory (AD).

## Examples

### Example 1: Update a password
```
PS C:\>Update-EntraBetaSignedInUserPassword -CurrentPassword $CurrentPassword -NewPassword $NewPassword
```

This command updates the password for the signed-in user.

## Parameters

### -CurrentPassword
Specifies the current password of the signed-in user.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -NewPassword
Specifies the new password for the signed-in user.

```yaml
Type: SecureString
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
