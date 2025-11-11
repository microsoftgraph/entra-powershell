---
author: giomachar
description: This article provides details on the Grant-EntraBetaMcpServerPermission command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: gmachar
ms.date: 11/10/2025
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Grant-EntraBetaMcpServerPermission
schema: 2.0.0
title: Grant-EntraBetaMcpServerPermission
---

# Grant-EntraBetaMcpServerPermission

## SYNOPSIS

Grants delegated permissions to a Model Context Protocol (MCP) client for Microsoft MCP Server for Enterprise.

## SYNTAX

### PredefinedClient (Default)
```powershell
Grant-EntraBetaMcpServerPermission
 -PredefinedClient <String>
 [<CommonParameters>]
```

### CustomClient
```powershell
Grant-EntraBetaMcpServerPermission
 -CustomClientAppId <Guid>
 [<CommonParameters>]
```

### PredefinedClientScopes
```powershell
Grant-EntraBetaMcpServerPermission
 -PredefinedClient <String>
 -Scopes <String[]>
 [<CommonParameters>]
```

### CustomClientScopes
```powershell
Grant-EntraBetaMcpServerPermission
 -CustomClientAppId <Guid>
 -Scopes <String[]>
 [<CommonParameters>]
```

## DESCRIPTION

The `Grant-EntraBetaMcpServerPermission` cmdlet grants delegated permissions to a Model Context Protocol (MCP) client for accessing the Microsoft MCP Server for Enterprise. This cmdlet can work with a predefined MCP client (Visual Studio Code, Visual Studio, ChatGPT, or Claude Desktop) or a custom MCP client specified by its application ID.

The cmdlet creates an OAuth2 permission grant that allows the specified MCP client to access the Microsoft MCP Server for Enterprise on behalf of users. When the `-Scopes` parameter is specified, the cmdlet operates in **additive mode**, adding the specified scopes to any existing grant while preserving other previously granted scopes. Without the `-Scopes` parameter, the cmdlet grants all available scopes (replacing any existing grant). The cmdlet returns an OAuth2PermissionGrant object that conforms to the Microsoft Graph API resource specification.

For delegated scenarios, the calling user needs at least one of the following Microsoft Entra roles:
- Cloud Application Administrator  
- Application Administrator
- Privileged Role Administrator

## EXAMPLES

### Example 1: Grant all available permissions to Visual Studio Code

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
$grant = Grant-EntraBetaMcpServerPermission -PredefinedClient 'VisualStudioCode'
$grant
```

```Output
Operating on MCP client: Visual Studio Code
Granting all available scopes: Files.Read MCP.Mail.Read MCP.User.Read

✓ Successfully granted permissions to Visual Studio Code
  Grant ID: aaaaaaaa-bbbb-cccc-1111-222222222222
  Granted scopes:
    - Files.Read
    - MCP.Mail.Read  
    - MCP.User.Read

Id                                   ClientId                             ResourceId                           ConsentType   Scope
--                                   --------                             ----------                           -----------   -----
aaaaaaaa-bbbb-cccc-1111-222222222222 client-sp-id-1234                    resource-sp-id-5678                  AllPrincipals Files.Read MCP.Mail.Read MCP.User.Read
```

This example grants all available delegated permissions (illustrative subset shown) to Visual Studio Code and returns the OAuth2PermissionGrant object.

### Example 2: Add specific scopes to Visual Studio Code (additive mode)

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
$grant = Grant-EntraBetaMcpServerPermission -PredefinedClient 'VisualStudioCode' -Scopes 'MCP.User.Read', 'MCP.Mail.Read'
$grant.Scope
```

```Output
Operating on MCP client: Visual Studio Code
Adding specific scopes (preserving existing grant): MCP.Mail.Read, MCP.User.Read

✓ Successfully granted permissions to Visual Studio Code
  Grant ID: dddddddd-eeee-ffff-4444-555555555555
  Granted scopes:
    - MCP.Files.Read
    - MCP.Mail.Read
    - MCP.User.Read

Files.Read MCP.Mail.Read MCP.User.Read
```

This example adds specific scopes (MCP.Mail.Read and MCP.User.Read) to Visual Studio Code's existing grant. Note that the existing Files.Read scope is preserved (additive mode).

### Example 3: Grant permissions to a custom MCP client

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
$customClientId = '12345678-1234-5678-9012-123456789012'
$grant = Grant-EntraBetaMcpServerPermission -CustomClientAppId $customClientId
Write-Host "Grant created with ID: $($grant.Id)"
```

```Output
Operating on MCP client: Custom MCP Client
Granting all available scopes: Files.Read MCP.Mail.Read MCP.User.Read

✓ Successfully granted permissions to Custom MCP Client
  Grant ID: eeeeeeee-ffff-aaaa-5555-666666666666
  Granted scopes:
    - Files.Read
    - MCP.Mail.Read
    - MCP.User.Read

Grant created with ID: eeeeeeee-ffff-aaaa-5555-666666666666
```

This example grants all available permissions (illustrative subset) to a custom MCP client identified by its service principal ID.

### Example 4: Add specific scopes to Claude Desktop

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
$grant = Grant-EntraBetaMcpServerPermission -PredefinedClient 'ClaudeDesktop' -Scopes 'MCP.User.Read', 'Files.Read'
$grant | Select-Object Id, ClientId, ResourceId, ConsentType, Scope
```

```Output
Operating on MCP client: Claude Desktop
Adding specific scopes (preserving existing grant): Files.Read, MCP.User.Read

✓ Successfully granted permissions to Claude Desktop
  Grant ID: ffffffff-aaaa-bbbb-6666-777777777777
  Granted scopes:
    - Files.Read
    - MCP.User.Read

Id                                   ClientId         ResourceId       ConsentType   Scope
--                                   --------         ----------       -----------   -----
ffffffff-aaaa-bbbb-6666-777777777777 claude-sp-id     resource-sp-id   AllPrincipals Files.Read MCP.User.Read
```

This example adds specific scopes to Claude Desktop in additive mode and displays selected properties of the returned OAuth2PermissionGrant object.

## PARAMETERS

### -PredefinedClient

Specifies a predefined MCP client to grant permissions to. Valid values are:
- VisualStudioCode: Visual Studio Code
- VisualStudio: Visual Studio
- ChatGPT: ChatGPT
- ClaudeDesktop: Claude Desktop

```yaml
Type: System.String
Parameter Sets: PredefinedClient, PredefinedClientScopes
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CustomClientAppId

Specifies the application ID (client ID) of a custom MCP client to grant permissions to. Must be a valid GUID.

```yaml
Type: System.Guid
Parameter Sets: CustomClient, CustomClientScopes
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scopes

Specifies the specific delegated permission scopes to add to the grant. When specified, the cmdlet operates in **additive mode**, adding these scopes to any existing grant while preserving previously granted scopes. If not specified, all available scopes from the Microsoft MCP Server for Enterprise will be granted (replacing any existing grant).

The cmdlet validates that all specified scopes are available on the resource application before applying them.

```yaml
Type: System.String[]
Parameter Sets: PredefinedClientScopes, CustomClientScopes
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You can't pipe objects to this cmdlet.

## OUTPUTS

### Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphOAuth2PermissionGrant

Returns an OAuth2PermissionGrant object that represents the delegated permission grant. This object conforms to the Microsoft Graph API OAuth2PermissionGrant resource type and contains the following key properties:

- **Id**: Unique identifier for the permission grant.
- **ClientId**: Object ID of the client service principal.
- **ResourceId**: Object ID of the resource service principal (Microsoft MCP Server for Enterprise).
- **ConsentType**: Set to "AllPrincipals" for admin consent.
- **Scope**: Space-separated list of granted permission scopes.
- **PrincipalId**: Null (since consentType is AllPrincipals).

The scopes string is normalized by sorting and de-duplicating the provided scope values before persisting.

## NOTES
- The cmdlet processes one MCP client at a time and returns an OAuth2PermissionGrant object for that client.
- The cmdlet automatically creates service principals for the resource and client applications if they don't exist.
- **Additive mode**: When the `-Scopes` parameter is specified, the cmdlet adds the specified scopes to any existing grant while preserving other previously granted scopes.
- **Replace mode**: When `-Scopes` is not specified, all available delegated scopes from the resource application are granted, replacing any existing grant.
- The cmdlet validates all specified scopes against the available scopes on the resource application and throws an error if any invalid scopes are provided.
- The cmdlet requires specific Microsoft Graph scopes: `Application.ReadWrite.All`, `Directory.Read.All`, and `DelegatedPermissionGrant.ReadWrite.All`.
- The returned OAuth2PermissionGrant object conforms to the Microsoft Graph API resource specification.

## RELATED LINKS

[Get-MgBetaServicePrincipal](https://learn.microsoft.com/powershell/module/microsoft.graph.beta.applications/get-mgbetaserviceprincipal)

[New-MgBetaServicePrincipal](https://learn.microsoft.com/powershell/module/microsoft.graph.beta.applications/new-mgbetaserviceprincipal)

[Get-MgBetaOauth2PermissionGrant](https://learn.microsoft.com/powershell/module/microsoft.graph.beta.identity.signins/get-mgbetaoauth2permissiongrant)

[New-MgBetaOauth2PermissionGrant](https://learn.microsoft.com/powershell/module/microsoft.graph.beta.identity.signins/new-mgbetaoauth2permissiongrant)

[Update-MgBetaOauth2PermissionGrant](https://learn.microsoft.com/powershell/module/microsoft.graph.beta.identity.signins/update-mgbetaoauth2permissiongrant)

[Remove-MgBetaOauth2PermissionGrant](https://learn.microsoft.com/powershell/module/microsoft.graph.beta.identity.signins/remove-mgbetaoauth2permissiongrant)

[OAuth2PermissionGrant resource type](https://learn.microsoft.com/graph/api/resources/oauth2permissiongrant)