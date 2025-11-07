---
author: giomachar
description: This article provides details on the Grant-EntraBetaMcpServerPermission command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: gmachar
ms.date: 11/06/2024
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
 -MCPClient <String>
 [<CommonParameters>]
```

### CustomClient
```powershell
Grant-EntraBetaMcpServerPermission
 -MCPClientServicePrincipalId <String>
 [<CommonParameters>]
```

### PredefinedClientScopes
```powershell
Grant-EntraBetaMcpServerPermission
 -MCPClient <String>
 -Scopes <String[]>
 [<CommonParameters>]
```

### CustomClientScopes
```powershell
Grant-EntraBetaMcpServerPermission
 -MCPClientServicePrincipalId <String>
 -Scopes <String[]>
 [<CommonParameters>]
```

## DESCRIPTION

The `Grant-EntraBetaMcpServerPermission` cmdlet grants delegated permissions to a Model Context Protocol (MCP) client for accessing the Microsoft MCP Server for Enterprise. This cmdlet can work with a predefined MCP client (Visual Studio Code, Visual Studio, ChatGPT, or Claude Desktop) or a custom MCP client specified by its service principal ID.

The cmdlet creates an OAuth2 permission grant that allows the specified MCP client to access the Microsoft MCP Server for Enterprise on behalf of users. You can grant all available scopes or specify particular scopes to grant. The cmdlet returns an OAuth2PermissionGrant object that conforms to the Microsoft Graph API resource specification.

For delegated scenarios, the calling user needs at least one of the following Microsoft Entra roles:
- Global Administrator
- Cloud Application Administrator  
- Application Administrator
- Privileged Role Administrator

## EXAMPLES

### Example 1: Grant permissions to Visual Studio Code

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
$grant = Grant-EntraBetaMcpServerPermission -MCPClient 'VisualStudioCode'
$grant
```

```Output
Operating on MCP client: Visual Studio Code
Granting all available scopes: scope1, scope2, scope3

✓ Successfully granted permissions to Visual Studio Code
  Grant ID: aaaaaaaa-bbbb-cccc-1111-222222222222
  Granted scopes:
    - scope1
    - scope2  
    - scope3

Id                                   ClientId                             ResourceId                           ConsentType   Scope
--                                   --------                             ----------                           -----------   -----
aaaaaaaa-bbbb-cccc-1111-222222222222 client-sp-id-1234                    resource-sp-id-5678                  AllPrincipals scope1 scope2 scope3
```

This example grants all available delegated permissions to Visual Studio Code and returns the OAuth2PermissionGrant object.

### Example 2: Grant specific scopes to Visual Studio Code

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
$grant = Grant-EntraBetaMcpServerPermission -MCPClient 'VisualStudioCode' -Scopes 'User.Read', 'Mail.Read'
$grant.Scope
```

```Output
Operating on MCP client: Visual Studio Code
Granting specific scopes: Mail.Read, User.Read

✓ Successfully granted permissions to Visual Studio Code
  Grant ID: dddddddd-eeee-ffff-4444-555555555555
  Granted scopes:
    - Mail.Read
    - User.Read

Mail.Read User.Read
```

This example grants only specific scopes (User.Read and Mail.Read) to Visual Studio Code and displays the granted scopes.

### Example 3: Grant permissions to a custom MCP client

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
$customClientId = '12345678-1234-5678-9012-123456789012'
$grant = Grant-EntraBetaMcpServerPermission -MCPClientServicePrincipalId $customClientId
Write-Host "Grant created with ID: $($grant.Id)"
```

```Output
Operating on MCP client: Custom MCP Client
Granting all available scopes: scope1, scope2, scope3

✓ Successfully granted permissions to Custom MCP Client
  Grant ID: eeeeeeee-ffff-aaaa-5555-666666666666
  Granted scopes:
    - scope1
    - scope2
    - scope3

Grant created with ID: eeeeeeee-ffff-aaaa-5555-666666666666
```

This example grants all available permissions to a custom MCP client identified by its service principal ID.

### Example 4: Grant specific scopes to Claude Desktop

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
$grant = Grant-EntraBetaMcpServerPermission -MCPClient 'ClaudeDesktop' -Scopes 'User.Read', 'Files.Read'
$grant | Select-Object Id, ClientId, ResourceId, ConsentType, Scope
```

```Output
Operating on MCP client: Claude Desktop
Granting specific scopes: Files.Read, User.Read

✓ Successfully granted permissions to Claude Desktop
  Grant ID: ffffffff-aaaa-bbbb-6666-777777777777
  Granted scopes:
    - Files.Read
    - User.Read

Id                                   ClientId         ResourceId       ConsentType   Scope
--                                   --------         ----------       -----------   -----
ffffffff-aaaa-bbbb-6666-777777777777 claude-sp-id     resource-sp-id   AllPrincipals Files.Read User.Read
```

This example grants specific scopes to Claude Desktop and displays selected properties of the returned OAuth2PermissionGrant object.

## PARAMETERS

### -MCPClient

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

### -MCPClientServicePrincipalId

Specifies the service principal ID of a custom MCP client to grant permissions to. Must be a valid GUID in the format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.

```yaml
Type: System.String
Parameter Sets: CustomClient, CustomClientScopes
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scopes

Specifies the specific delegated permission scopes to grant. If not specified, all available scopes from the Microsoft MCP Server for Enterprise will be granted.

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

- **Id**: Unique identifier for the permission grant
- **ClientId**: Object ID of the client service principal
- **ResourceId**: Object ID of the resource service principal (Microsoft MCP Server for Enterprise)
- **ConsentType**: Set to "AllPrincipals" for admin consent
- **Scope**: Space-separated list of granted permission scopes
- **PrincipalId**: Null (since consentType is AllPrincipals)

## NOTES
- The cmdlet processes one MCP client at a time and returns an OAuth2PermissionGrant object for that client.
- The cmdlet automatically creates service principals for the resource and client applications if they don't exist.
- Existing permission grants are updated to match the specified scopes exactly.
- If no scopes are specified, all available delegated scopes from the resource application are granted.
- The cmdlet requires specific Microsoft Graph scopes: `Application.ReadWrite.All`, `Directory.Read.All`, and `DelegatedPermissionGrant.ReadWrite.All`.
- The returned OAuth2PermissionGrant object conforms to the Microsoft Graph API resource specification.

## RELATED LINKS

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[Get-EntraBetaServicePrincipalOAuth2PermissionGrant](Get-EntraBetaServicePrincipalOAuth2PermissionGrant.md)

[New-MgBetaOauth2PermissionGrant](https://learn.microsoft.com/powershell/module/microsoft.graph.beta.identity.signins/new-mgbetaoauth2permissiongrant)

[OAuth2PermissionGrant resource type](https://learn.microsoft.com/en-us/graph/api/resources/oauth2permissiongrant?view=graph-rest-1.0)