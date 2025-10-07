---
author: msewaweru
description: This article provides details on the Set-EntraBetaDomainFederationSettings command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 08/19/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Set-EntraBetaDomainFederationSettings
schema: 2.0.0
title: Set-EntraBetaDomainFederationSettings
---

# Set-EntraBetaDomainFederationSettings

## SYNOPSIS

Updates settings for a federated domain.

## SYNTAX

```powershell
Set-EntraBetaDomainFederationSettings
 -DomainName <String>
 [-SigningCertificate <String>]
 [-NextSigningCertificate <String>]
 [-LogOffUri <String>]
 [-PassiveLogOnUri <String>]
 [-ActiveLogOnUri <String>]
 [-IssuerUri <String>]
 [-FederationBrandName <String>]
 [-MetadataExchangeUri <String>]
 [-PreferredAuthenticationProtocol <AuthenticationProtocol>]
 [-SigningCertificateUpdateStatus <SigningCertificateUpdateStatus>]
 [-PromptLoginBehavior <PromptLoginBehavior>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaDomainFederationSettings` cmdlet is used to update the settings of a single sign-on domain.

For delegated scenarios, the calling user must be assigned at least one of the following Microsoft Entra roles:

- Domain Name Administrator
- External Identity Provider Administrator
- Hybrid Identity Administrator
- Security Administrator

## EXAMPLES

### Example 1: Set the PromptLoginBehavior

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'
$domain = 'contoso.com'
$authProtocol = 'WsFed'
$promptLoginBehavior = 'TranslateToFreshPasswordAuth' # Or 'NativeSupport' or 'Disabled', depending on the requirement
Set-EntraBetaDomainFederationSettings -DomainName $domain -PreferredAuthenticationProtocol $authProtocol -PromptLoginBehavior $promptLoginBehavior
```

This command updates the `PromptLoginBehavior` to either `TranslateToFreshPasswordAuth`, `NativeSupport`, or `Disabled`. These possible values are described:

- `TranslateToFreshPasswordAuth` - means the default Microsoft Entra ID behavior of translating `prompt=login` to `wauth=https://schemas.microsoft.com/ws/2008/06/identity/authenticationmethod/password` and `wfresh=0`.
- `NativeSupport` - means that the `prompt=login` parameter is sent as is to ADFS.
- `Disabled` - means that only wfresh=0 is sent to ADFS

Use the `Get-EntraBetaDomainFederationSettings -DomainName <your_domain_name> | Format-List *` to get the values for `PreferredAuthenticationProtocol` and `PromptLoginBehavior` for the federated domain.

- `-DomainName` parameter specifies the fully qualified domain name to retrieve.
- `-PreferredAuthenticationProtocol` parameter specifies the preferred authentication protocol.
- `-PromptLoginBehavior` parameter specifies the prompt sign-in behavior.

### Example 2: Set the domain federation uri's

```powershell
Connect-Entra -Scopes 'Domain.ReadWrite.All'

$params = @{
    DomainName = 'contoso.com'
    LogOffUri = 'https://adfs1.entra.lab/adfs/'
    PassiveLogOnUri = 'https://adfs1.entra.lab/adfs/'
    ActiveLogOnUri = 'https://adfs1.entra.lab/adfs/services/trust/2005/'
    IssuerUri = 'http://adfs1.entra.lab/adfs/services/'
    MetadataExchangeUri = 'https://adfs1.entra.lab/adfs/services/trust/'
}
Set-EntraBetaDomainFederationSettings @params
```

This command updates the domain federation domain settings.

- `-DomainName` parameter specifies the fully qualified domain name to retrieve.
- `-LogOffUri` parameter specifies the URL clients are redirected to when they sign out of Microsoft Entra ID services.
- `-PassiveLogOnUri` parameter specifies URL that web-based clients will be directed to when signing in to Microsoft Entra ID services.
- `-ActiveLogOnUri` parameter specifies the end point used by active clients when authenticating with domains set up for single sign-on.
- `-IssuerUri` parameter specifies the unique identifier of the domain in the Microsoft Entra ID Identity platform derived from the federation server.
- `-MetadataExchangeUri` parameter specifies the metadata exchange end point used for authentication from client applications.

## PARAMETERS

### -DomainName

The fully qualified domain name (FQDN) to update.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SigningCertificate

The current certificate used to sign tokens passed to the Microsoft Entra ID Identity platform.

```yaml
Type: System.String
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
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -LogOffUri

The URL clients are redirected to when they sign out of Microsoft Entra ID services.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -PassiveLogOnUri

The URL that web-based clients will be directed to when signing in to Microsoft Entra ID services.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ActiveLogOnUri

A URL that specifies the end point used by active clients when authenticating with domains set up for single sign-on (also known as identity federation) in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -IssuerUri

The unique identifier of the domain in the Microsoft Entra ID Identity platform derived from the federation server.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -FederationBrandName

The name of the string value shown to users when signing in to Microsoft Entra ID.
We recommend that customers use something that is familiar to
users such as "Contoso Inc."

```yaml
Type: System.String
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
Type: System.String
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
Type: System.String
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
Type: System.Object
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
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaDomainFederationSettings](Get-EntraBetaDomainFederationSettings.md)
