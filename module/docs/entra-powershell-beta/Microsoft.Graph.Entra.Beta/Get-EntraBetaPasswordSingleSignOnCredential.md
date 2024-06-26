---
External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Get-EntraBetaPasswordSingleSignOnCredential

## Synopsis
Gets the password SSO credentials

## Syntax

```
Get-EntraBetaPasswordSingleSignOnCredential -ObjectId <String> -PasswordSSOObjectId <PasswordSSOObjectId>
 [<CommonParameters>]
```

## Description
This cmdlet enables users to read their Password Single-sign-on credentials for an application which they are part of.
Admin could read the group credentials as well.
Note that the password field will be hidden for security purpose.

## Examples

### Get password single-sign-on credentials
```
PS C:\> $get_creds_output = Get-EntraBetaPasswordSingleSignOnCredential -ObjectId 9ac9883e-0ac5-4c32-8737-4267f56a28cc -PasswordSSOObjectId a4210a97-5e26-4cfe-88f1-118ed4886f27
```

This command gets the password sso credentials for the given ObjectId and PasswordSSOObjectId.

## Parameters

### -ObjectId
The unique identifier of the object specific Azure Active Directory object

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

### -PasswordSSOObjectId
User or group id

```yaml
Type: PasswordSSOObjectId
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

### Microsoft.Online.Administration.PasswordSSOCredentials
## Notes
## Related Links
