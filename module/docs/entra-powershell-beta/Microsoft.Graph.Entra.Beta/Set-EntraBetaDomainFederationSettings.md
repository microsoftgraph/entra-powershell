---
external help file: Microsoft.Graph.Entra.Beta-help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra.Beta/Set-EntraBetaDomainFederationSettings

schema: 2.0.0
---

# Set-EntraBetaDomainFederationSettings

## Synopsis
Updates settings for a federated domain.

## Syntax

```
Set-EntraBetaDomainFederationSettings [-DomainName] <String> [[-SigningCertificate] <String>]
 [[-NextSigningCertificate] <String>] [[-LogOffUri] <String>] [[-PassiveLogOnUri] <String>]
 [[-ActiveLogOnUri] <String>] [[-IssuerUri] <String>] [[-FederationBrandName] <String>]
 [[-MetadataExchangeUri] <String>] [[-PreferredAuthenticationProtocol] <String>]
 [[-SigningCertificateUpdateStatus] <Object>] [[-PromptLoginBehavior] <String>] [<CommonParameters>]
```

## Description
The Set-EntraBetaDomainFederationSettings cmdlet is used to update the settings of a single sign-on domain.

## Examples

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## Parameters

### -DomainName
The fully qualified domain name (FQDN) to update.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SigningCertificate
The current certificate used to sign tokens passed to the Microsoft Azure Active Directory Identity platform.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -NextSigningCertificate
The next token signing certificate that will be used to sign tokens when the primary signing certificate expires.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -LogOffUri
The URL clients are redirected to when they sign out of Microsoft Azure Active Directory services.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PassiveLogOnUri
The URL that web-based clients will be directed to when signing in to Microsoft Azure Active Directory services.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ActiveLogOnUri
A URL that specifies the end point used by active clients when authenticating with domains set up for single sign-on (also known as identity federation) in
Microsoft Azure Active Directory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -IssuerUri
The unique identifier of the domain in the Microsoft Azure Active Directory Identity platform derived from the federation server.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -FederationBrandName
The name of the string value shown to users when signing in to Microsoft Azure Active Directory.
We recommend that customers use something that is familiar to
users such as "Contoso Inc."

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -MetadataExchangeUri
The URL that specifies the metadata exchange end point used for authentication from rich client applications such as Lync Online.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PreferredAuthenticationProtocol
Specifies the preferred authentication protocol.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SigningCertificateUpdateStatus
Specifies the update status of the signing certificate.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PromptLoginBehavior
Specifies the prompt login behavior.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
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
