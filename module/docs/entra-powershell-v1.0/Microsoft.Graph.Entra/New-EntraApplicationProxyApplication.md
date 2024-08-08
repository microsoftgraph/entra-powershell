---
title: New-EntraApplicationProxyApplication
description: This article provides details on the New-EntraApplicationProxyApplication command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraApplicationProxyApplication

schema: 2.0.0
---

# New-EntraApplicationProxyApplication

## Synopsis
The New-EntraApplicationProxyApplication cmdlet creates a new application configured for Application Proxy in Microsoft Entra ID.

## Syntax

```powershell
New-EntraApplicationProxyApplication 
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

## Description
The New-EntraApplicationProxyApplication cmdlet creates a new application configured for Application Proxy in Microsoft Entra ID.
To ensure this application is usable, also make sure you assign users and configure SSO if needed.
Without specifying a ConnectorGroupId, this application by default uses the Default connector group in your tenant.

## Examples

### Example 1: Creating a new application with only the basic required settings, and the default domain for applications.
```powershell
PS C:\> New-EntraApplicationProxyApplication -DisplayName "Finance Tracker" -ExternalUrl "https://finance-awcycles.msappproxy.net/" -InternalUrl "https://finance/" 
```

```output
ExternalAuthenticationType               : AadPreAuthentication
ApplicationServerTimeout                 : Default
ExternalUrl                              : https://finance-awcycles.msappproxy.net/
InternalUrl                              : https://finance/
IsTranslateHostHeaderEnabled             : True
IsTranslateLinksInBodyEnabled            : False
IsOnPremPublishingEnabled                : True
VerifiedCustomDomainCertificatesMetadata : 
VerifiedCustomDomainKeyCredential        : 
VerifiedCustomDomainPasswordCredential   : 
SingleSignOnSettings                     :
```

This command creates a new application with only the basic required settings, and the default domain for applications.

### Example 2: Creating a new application that uses a custom domain and sets several optional flags.
```powershell
PS C:\> New-EntraApplicationProxyApplication -DisplayName "HR Resources" -ExternalUrl "https://hr.adventure-works.com/" -InternalUrl "https://hr.adventure-works.com/" -ApplicationServerTimeout Long 
```

```output
ExternalAuthenticationType               : AadPreAuthentication
ApplicationServerTimeout                 : Long
ExternalUrl                              : https://hr.adventure-works.com/
InternalUrl                              : https://hr.adventure-works.com/
IsTranslateHostHeaderEnabled             : True
IsTranslateLinksInBodyEnabled            : False
IsOnPremPublishingEnabled                : True
VerifiedCustomDomainCertificatesMetadata : class OnPremisesPublishingVerifiedCustomDomainCertificatesMetadataObject {
                                             Thumbprint: [XXXXX]
                                             SubjectName: [XXXXX]
                                             Issuer: 
                                             IssueDate: 11/9/2017 5:54:29
                                             ExpiryDate: 11/9/2019 5:54:29
                                           }
                                           
VerifiedCustomDomainKeyCredential        : 
VerifiedCustomDomainPasswordCredential   : 
SingleSignOnSettings                     :
```

This command creates a new application that uses a custom domain and sets several optional flags.


## Parameters

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
Provide the Id of the Connector group you would like assigned to this application.
You can find this value by using the [Get-EntraApplicationProxyConnectorGroup](./Get-EntraApplicationProxyConnectorGroup.md) command.
Connectors process the remote access to your application, and connector groups help you organize connectors and apps by region, network, or purpose.
If you don't have any connector groups created yet, your app is assigned to Default.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -DisplayName
The display name of the new Application

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
Type: String
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
Type: String
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
Type: Boolean
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
Keep this value as No unless your hardcode HTML links to other on-premises applications, and don't use custom domains.

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

### -IsHttpOnlyCookieEnabled
Yes allows application proxy to include the HTTPOnly flag in HTTP response headers. This flag provides extra security benefits, for example, it prevents client-side scripting (CSS) from copying or modifying the cookies.

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

### -IsPersistentCookieEnabled
Yes allows application proxy to set its access cookies to not expire when the web browser is closed. The persistence lasts until the access token expires, or until the user manually deletes the persistent cookies.

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

### -IsSecureCookieEnabled
Yes allows application proxy to include the Secure flag in HTTP response headers. Secure Cookies enhances security by transmitting cookies over a TLS secured channel such as HTTPS. TLS prevents cookie transmission in clear text.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String
System.Nullable\`1\[\[Microsoft.Open.MSGraph.Model.ApplicationProxyApplicationObject+ExternalAuthenticationTypeEnum, Microsoft.Open.MS.GraphV10.Client, Version=2.0.0.0, Culture=neutral, PublicKeyToken=null\]\] System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[Microsoft.Open.MSGraph.Model.ApplicationProxyApplicationObject+ApplicationServerTimeoutEnum, Microsoft.Open.MS.GraphV10.Client, Version=2.0.0.0, Culture=neutral, PublicKeyToken=null\]\]

## Outputs

### System.Object
## Notes

## RELATED LINKS