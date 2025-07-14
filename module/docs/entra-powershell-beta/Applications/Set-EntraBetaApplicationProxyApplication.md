---
author: msewaweru
description: This article provides details on the Set-EntraBetaApplicationProxyApplication command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/15/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaApplicationProxyApplication
schema: 2.0.0
title: Set-EntraBetaApplicationProxyApplication
---

# Set-EntraBetaApplicationProxyApplication

## SYNOPSIS

The `Set-EntraBetaApplicationProxyApplication` allows you to modify and set configurations for an application in Microsoft Entra ID configured to use ApplicationProxy.

## SYNTAX

```powershell
Set-EntraBetaApplicationProxyApplication
 -ApplicationId <String>
 [-ExternalUrl <String>]
 [-InternalUrl <String>]
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

The `Set-EntraBetaApplicationProxyApplication` allows you to modify and set other settings for an application in Microsoft Entra ID configured to use ApplicationProxy. Specify `ApplicationId` parameter to update application configured for application proxy.

## EXAMPLES

### Example 1: Update ExternalUrl, InternalUrl, ExternalAuthenticationType, and IsTranslateHostHeaderEnabled parameter

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    ApplicationId                = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    ExternalUrl                  = 'https://finance-awcycles.msappproxy.net/' 
    InternalUrl                  = 'http://finance/'
    ExternalAuthenticationType   = 'AadPreAuthentication' 
    IsTranslateHostHeaderEnabled = $false
}
Set-EntraBetaApplicationProxyApplication @params
```

```Output
ObjectId                                 : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
externalAuthenticationType               : aadPreAuthentication
applicationServerTimeout                 : Long
externalUrl                              : https://testp-m365x99297270.msappproxy.net/
internalUrl                              : https://testp.com/
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

This example update `ExternalUrl`, `InternalUrl`, `ExternalAuthenticationType`, and `IsTranslateHostHeaderEnabled` parameter.

- `-ApplicationId` parameter specifies the application ID.
- `-ExternalUrl` parameter specifies the URL that use to access the application from outside user private network.
- `-InternalUrl` parameter specifies the URL that use to access the application from inside user private network.
- `-ExternalAuthenticationType` parameter specifies the external authentication type.
- `-IsTranslateHostHeaderEnabled` parameter specifies the translates urls in headers.

### Example 2: Update IsHttpOnlyCookieEnabled, IsSecureCookieEnabled, and IsPersistentCookieEnabled  parameter

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    ApplicationId                = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    ExternalUrl                  = 'https://finance-awcycles.msappproxy.net/' 
    InternalUrl                  = 'http://finance/'
    ExternalAuthenticationType   = 'AadPreAuthentication' 
    IsTranslateHostHeaderEnabled = $false
    IsHttpOnlyCookieEnabled      = $false 
    IsSecureCookieEnabled        = $false 
    IsPersistentCookieEnabled    = $false
}
Set-EntraBetaApplicationProxyApplication @params
```

```Output
ObjectId                                 : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
externalAuthenticationType               : aadPreAuthentication
applicationServerTimeout                 : Long
externalUrl                              : https://testp-contoso.msappproxy.net/
internalUrl                              : https://testp.com/
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

This example update `IsHttpOnlyCookieEnabled`, `IsSecureCookieEnabled`, and `IsPersistentCookieEnabled` parameter.

- `-ApplicationId` parameter specifies the application ID.
- `-ExternalUrl` parameter specifies the URL that use to access the application from outside user private network.
- `-InternalUrl` parameter specifies the URL that use to access the application from inside user private network.
- `-ExternalAuthenticationType` parameter specifies the external authentication type.
- `-IsHttpOnlyCookieEnabled` parameter specifies the application proxy to include the HTTPOnly flag in HTTP response headers.
- `-IsSecureCookieEnabled` parameter specifies the application proxy to include the Secure flag in HTTP response headers.
- `-IsTranslateHostHeaderEnabled` parameter specifies the translates urls in headers.
- `-IsPersistentCookieEnabled` parameter specifies application proxy to set its access cookies to not expire when the web browser is closed.

### Example 3: Update IsTranslateLinksInBodyEnabled, ApplicationServerTimeout, and  ConnectorGroupId parameter

```powershell
Connect-Entra -Scopes 'Directory.ReadWrite.All'
$params = @{
    ApplicationId                = 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
    ExternalUrl                  = 'https://finance-awcycles.msappproxy.net/' 
    InternalUrl                  = 'http://finance/'
    ExternalAuthenticationType   = 'AadPreAuthentication' 
    IsTranslateHostHeaderEnabled = $false
    ApplicationServerTimeout     = Long  
    ConnectorGroupId             = 'bbbbbbbb-1111-2222-3333-cccccccccccc'
}
Set-EntraBetaApplicationProxyApplication @params
```

```Output
ObjectId                                 : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
externalAuthenticationType               : aadPreAuthentication
applicationServerTimeout                 : Long
externalUrl                              : https://testp-contoso.msappproxy.net/
internalUrl                              : https://testp.com/
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

This example update `IsTranslateLinksInBodyEnabled`, `ApplicationServerTimeout`, and  `ConnectorGroupId` parameter.

- `-ApplicationId` parameter specifies the application ID.
- `-ExternalUrl` parameter specifies the URL that use to access the application from outside user private network.
- `-InternalUrl` parameter specifies the URL that use to access the application from inside user private network.
- `-ConnectorGroupId` parameter specifies the Connector group ID that assigned to this application.
- `-ApplicationServerTimeout` parameter specifies the application server timeout to set.
- `-ExternalAuthenticationType` parameter specifies the external authentication type.
- `-IsTranslateHostHeaderEnabled` parameter specifies the translates urls in headers.

## PARAMETERS

### -ApplicationId

Specifies a unique application ID of an application in Microsoft Entra ID.
This objectid can be found using the `Get-EntraBetaApplication` command.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
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

Required: False
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

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExternalAuthenticationType

How Application Proxy verifies users before giving them access to your application.
AadPreAuth: Application Proxy redirects users to sign in with Microsoft Entra ID, which authenticates their permissions for the directory and application.
We recommend keeping this option as the default, so that you can take advantage of Microsoft Entra ID security features like conditional access and multifactor authentication.
Pass through: Users don't have to authenticate against Microsoft Entra ID to access the application.
You can still set up authentication requirements on the backend.

```yaml
Type: ExternalAuthenticationTypeEnum
Parameter Sets: (All)
Aliases:

Required: False
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

### -ApplicationServerTimeout

Specifies the backend server timeout type.
Set this value to Long only if your application is slow to authenticate and connect.

```yaml
Type: ApplicationServerTimeoutEnum
Parameter Sets: (All)
Aliases:

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

### -IsHttpOnlyCookieEnabled

Allows application proxy to include the HTTPOnly flag in HTTP response headers. This flag provides extra security benefits, for example, it prevents client-side scripting (CSS) from copying or modifying the cookies.

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

Allows application proxy to set its access cookies to not expire when the web browser is closed. The persistence lasts until the access token expires, or until the user manually deletes the persistent cookies.

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

Allows application proxy to include the Secure flag in HTTP response headers. Secure Cookies enhances security by transmitting cookies over a "TLS" secured channel such as HTTPS. TLS prevents cookie transmission in clear text.

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

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaApplicationProxyApplication](New-EntraBetaApplicationProxyApplication.md)

[Get-EntraBetaApplicationProxyApplication](Get-EntraBetaApplicationProxyApplication.md)

[Remove-EntraBetaApplicationProxyApplication](Remove-EntraBetaApplicationProxyApplication.md)
