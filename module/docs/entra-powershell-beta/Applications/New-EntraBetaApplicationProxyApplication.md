---
author: msewaweru
description: This article provides details on the New-EntraBetaApplicationProxyApplication command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Applications
ms.author: eunicewaweru
ms.date: 07/15/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/New-EntraBetaApplicationProxyApplication
schema: 2.0.0
title: New-EntraBetaApplicationProxyApplication
---

# New-EntraBetaApplicationProxyApplication

## SYNOPSIS

The `New-EntraBetaApplicationProxyApplication` cmdlet creates a new application configured for Application Proxy in Microsoft Entra ID.

## SYNTAX

```powershell
New-EntraBetaApplicationProxyApplication
 -DisplayName <String>
 -ExternalUrl <String>
 -InternalUrl <String>
 [-ExternalAuthenticationType <ExternalAuthenticationTypeEnum>]
 [-IsTranslateHostHeaderEnabled <Boolean>]
 [-IsHttpOnlyCookieEnabled <Boolean>]
 [-IsSecureCookieEnabled <Boolean>]
 [-IsPersistentCookieEnabled <Boolean>]
 [-IsTranslateLinksInBodyEnabled <Boolean>]
 [-ApplicationServerTimeout <ApplicationServerTimeoutEnum>]
 [-ConnectorGroupId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `New-EntraBetaApplicationProxyApplication` cmdlet creates a new application configured for Application Proxy in Microsoft Entra ID.
To ensure this application is usable, also make sure you assign users and configure SSO if needed.
Without specifying a ConnectorGroupId, this application by default uses the `Default` connector group in your tenant.

## EXAMPLES

### Example 1: Creating a new application with only the basic required settings, and the default domain for applications

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    DisplayName = 'Finance Tracker' 
    ExternalUrl = 'https://finance-awcycles.msappproxy.net/' 
    InternalUrl = 'http://finance/'
}
New-EntraBetaApplicationProxyApplication @params

```

```Output
ObjectId                                 : bbbbbbbb-1111-2222-3333-cccccccccccc
externalAuthenticationType               : 
applicationServerTimeout                 : 
externalUrl                              : https://finance-awcycles.msappproxy.net/
internalUrl                              : http://finance/
isTranslateHostHeaderEnabled             : False
isTranslateLinksInBodyEnabled            : False
isOnPremPublishingEnabled                : True
verifiedCustomDomainCertificatesMetadata :
verifiedCustomDomainKeyCredential        :
verifiedCustomDomainPasswordCredential   :
singleSignOnSettings                     : @{singleSignOnMode=none; kerberosSignOnSettings=}
isHttpOnlyCookieEnabled                  : False
isSecureCookieEnabled                    : False
isPersistentCookieEnabled                : False
```

This example creating a new application with only the basic required settings, and the default domain for applications.

- `-DisplayName` parameter specifies the display name of new application.
- `-ExternalUrl` parameter specifies the URL that use to access the application from outside user private network.
- `-InternalUrl` parameter specifies the URL that use to access the application from inside user private network.

### Example 2: Creating a new application with ApplicationServerTimeout and ExternalAuthenticationType parameter

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    DisplayName = 'Finance Tracker' 
    ExternalUrl = 'https://finance-awcycles.msappproxy.net/' 
    InternalUrl = 'http://finance/'
    ApplicationServerTimeout = Long  
    ExternalAuthenticationType = 'aadPreAuthentication'
}
New-EntraBetaApplicationProxyApplication @params
```

```Output
ObjectId                                 : bbbbbbbb-1111-2222-3333-cccccccccccc
externalAuthenticationType               : aadPreAuthentication
applicationServerTimeout                 : Long
externalUrl                              : https://testp4-m365x99297270.msappproxy.net/
internalUrl                              : https://testp4.com/
isTranslateHostHeaderEnabled             : False
isTranslateLinksInBodyEnabled            : False
isOnPremPublishingEnabled                : True
verifiedCustomDomainCertificatesMetadata :
verifiedCustomDomainKeyCredential        :
verifiedCustomDomainPasswordCredential   :
singleSignOnSettings                     : @{singleSignOnMode=none; kerberosSignOnSettings=}
isHttpOnlyCookieEnabled                  : False
isSecureCookieEnabled                    : False
isPersistentCookieEnabled                : False
```

This example creating a new application with `ApplicationServerTimeout` and `ExternalAuthenticationType` parameter.

- `-DisplayName` parameter specifies the display name of new application.
- `-ExternalUrl` parameter specifies the URL that use to access the application from outside user private network.
- `-InternalUrl` parameter specifies the URL that use to access the application from inside user private network.
- `-ApplicationServerTimeout` parameter specifies the application server timeout to set.
- `-ExternalAuthenticationType` parameter specifies the external authentication type.

### Example 3: Creating a new application with IsHttpOnlyCookieEnabled, IsSecureCookieEnabled, IsTranslateLinksInBodyEnabled and ConnectorGroupId parameter

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    DisplayName = 'Finance Tracker' 
    ExternalUrl = 'https://finance-awcycles.msappproxy.net/' 
    InternalUrl = 'http://finance/'
    IsHttpOnlyCookieEnabled = $false 
    IsSecureCookieEnabled = $false 
    IsPersistentCookieEnabled = $false 
    IsTranslateLinksInBodyEnabled = $false  
    ConnectorGroupId = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
}
New-EntraBetaApplicationProxyApplication @params
```

```Output
ObjectId                                 : bbbbbbbb-1111-2222-3333-cccccccccccc
externalAuthenticationType               : aadPreAuthentication
applicationServerTimeout                 : Long
externalUrl                              : https://testp4-m365x99297270.msappproxy.net/
internalUrl                              : https://testp4.com/
isTranslateHostHeaderEnabled             : False
isTranslateLinksInBodyEnabled            : False
isOnPremPublishingEnabled                : True
verifiedCustomDomainCertificatesMetadata :
verifiedCustomDomainKeyCredential        :
verifiedCustomDomainPasswordCredential   :
singleSignOnSettings                     : @{singleSignOnMode=none; kerberosSignOnSettings=}
isHttpOnlyCookieEnabled                  : False
isSecureCookieEnabled                    : False
isPersistentCookieEnabled                : False
```

This example creating a new application with `IsHttpOnlyCookieEnabled`, `IsSecureCookieEnabled`, `IsTranslateLinksInBodyEnabled`, and `ConnectorGroupId` parameter.

- `-DisplayName` parameter specifies the display name of new application.
- `-ExternalUrl` parameter specifies the URL that use to access the application from outside user private network.
- `-InternalUrl` parameter specifies the URL that use to access the application from inside user private network.
- `-ConnectorGroupId` parameter specifies the Connector group ID that assigned to this application.
- `-IsHttpOnlyCookieEnabled` parameter specifies the application proxy to include the HTTPOnly flag in HTTP response headers.
- `-IsSecureCookieEnabled` parameter specifies the application proxy to include the Secure flag in HTTP response headers.
- `-IsPersistentCookieEnabled` parameter specifies application proxy to set its access cookies to not expire when the web browser is closed.
- `-IsTranslateLinksInBodyEnabled` parameter specifies the translates urls in body.

## PARAMETERS

### -ApplicationServerTimeout

Set this value to Long only if your application is slow to authenticate and connect.

```yaml
Type: ApplicationServerTimeoutEnum
Parameter Sets: (All)
Aliases:
Accepted values: Default, Long

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ConnectorGroupId

Provide the ID of the Connector group you would like assigned to this application.
You can find this value by using the `Get-EntraBetaApplicationProxyConnectorGroup` command.
Connectors process the remote access to your application, and connector groups help you organize connectors and apps by region, network, or purpose.
If you don't have any connector groups created yet, your app is assigned to Default.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -DisplayName

The display name of the new application.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExternalAuthenticationType

How Application Proxy verifies users before giving them access to your application.
AadPreAuthentication: Application Proxy redirects users to sign in with Microsoft Entra ID, which authenticates their permissions for the directory and application.
We recommend keeping this option as the default, so that you can take advantage of Microsoft Entra ID security features like conditional access and multifactor authentication.
Pass through: Users don't have to authenticate against Microsoft Entra ID to access the application.
You can still set up authentication requirements on the backend.

```yaml
Type: ExternalAuthenticationTypeEnum
Parameter Sets: (All)
Aliases:
Accepted values: AadPreAuthentication, Passthru

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExternalUrl

The address your users go to in order to access the app from outside your network.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -InternalUrl

The URL that you use to access the application from inside your private network.
You can provide a specific path on the backend server to publish, while the rest of the server is unpublished.
In this way, you can publish different sites on the same server as different apps, and give each one its own name and access rules.
If you publish a path, make sure that it includes all the necessary images, scripts, and style sheets for your application.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -IsTranslateHostHeaderEnabled

If set to true, translates urls in headers.
Keep this value true unless your application required the original host header in the authentication request.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -IsTranslateLinksInBodyEnabled

If set to true, translates urls in body.
Keep this value as No unless you have to hardcoded HTML links to other on-premises applications, and don't use custom domains.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -IsHttpOnlyCookieEnabled

Yes allows application proxy to include the HTTPOnly flag in HTTP response headers. This flag provides extra security benefits, for example, it prevents client-side scripting (CSS) from copying or modifying the cookies.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -IsPersistentCookieEnabled

Yes allows application proxy to set its access cookies to not expire when the web browser is closed. The persistence lasts until the access token expires, or until the user manually deletes the persistent cookies.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -IsSecureCookieEnabled

Yes allows application proxy to include the Secure flag in HTTP response headers. Secure Cookies enhances security by transmitting cookies over a TLS secured channel such as HTTPS. TLS prevents cookie transmission in clear text.

```yaml
Type: System.Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

System.Nullable\`1\[\[Microsoft.Open.MSGraph.Model.ApplicationProxyApplicationObject+ExternalAuthenticationTypeEnum, Microsoft.Open.MS.GraphV10.Client, Version=2.0.0.0, Culture=neutral, PublicKeyToken=null\]\] System.Nullable\`1\[\[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[Microsoft.Open.MSGraph.Model.ApplicationProxyApplicationObject+ApplicationServerTimeoutEnum, Microsoft.Open.MS.GraphV10.Client, Version=2.0.0.0, Culture=neutral, PublicKeyToken=null\]\]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Set-EntraBetaApplicationProxyApplication](Set-EntraBetaApplicationProxyApplication.md)

[Get-EntraBetaApplicationProxyApplication](Get-EntraBetaApplicationProxyApplication.md)

[Remove-EntraBetaApplicationProxyApplication](Remove-EntraBetaApplicationProxyApplication.md)
