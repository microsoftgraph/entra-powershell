---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraUserPassword

## SYNOPSIS
Sets the password of a user.

## SYNTAX

```
Set-EntraUserPassword [-ForceChangePasswordNextLogin <Boolean>] [-EnforceChangePasswordPolicy <Boolean>]
 -ObjectId <String> -Password <SecureString> [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraUserPassword cmdlet sets the password for a user in Microsoft Entra ID.

## EXAMPLES

### Example 1: Set a user's password
```
PS C:\>Set-EntraUserPassword -ObjectId  "df19e8e6-2ad7-453e-87f5-037f6529ae16" -Password $password
```

This command sets the specified user's password.

## PARAMETERS

### -EnforceChangePasswordPolicy
If set to true, force the user to change their password

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ForceChangePasswordNextLogin
Forces a user to change their password during their next log in.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of an object.

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

### -Password
Specifies the password.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
