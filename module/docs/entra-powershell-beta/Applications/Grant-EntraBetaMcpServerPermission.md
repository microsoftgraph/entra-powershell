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

Grants delegated permissions to Model Context Protocol (MCP) clients for Microsoft MCP Server for Enterprise.

## SYNTAX

### PredefinedClients (Default)
```powershell
Grant-EntraBetaMcpServerPermission
 -MCPClient <String[]>
 [<CommonParameters>]
```

### CustomClients
```powershell
Grant-EntraBetaMcpServerPermission
 -MCPClientServicePrincipalId <String[]>
 [<CommonParameters>]
```

### PredefinedClientsScopes
```powershell
Grant-EntraBetaMcpServerPermission
 [-MCPClient <String[]>]
 -Scopes <String[]>
 [<CommonParameters>]
```

### CustomClientsScopes
```powershell
Grant-EntraBetaMcpServerPermission
 -MCPClientServicePrincipalId <String[]>
 -Scopes <String[]>
 [<CommonParameters>]
```

## DESCRIPTION

The `Grant-EntraBetaMcpServerPermission` cmdlet grants delegated permissions to Model Context Protocol (MCP) clients for accessing the Microsoft MCP Server for Enterprise. This cmdlet can work with predefined MCP clients (Visual Studio Code, Visual Studio, Visual Studio MSAL) or custom MCP clients specified by their service principal IDs.

The cmdlet creates OAuth2 permission grants that allow the specified MCP clients to access the Microsoft MCP Server for Enterprise on behalf of users. You can grant all available scopes or specify particular scopes to grant.

For delegated scenarios, the calling user needs at least one of the following Microsoft Entra roles:
- Global Administrator
- Cloud Application Administrator  
- Application Administrator
- Privileged Role Administrator

## EXAMPLES

### Example 1: Grant permissions to all predefined MCP clients

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
Grant-EntraBetaMcpServerPermission -MCPClient 'VisualStudioCode', 'VisualStudio', 'VisualStudioMSAL'
```

```Output
Operating on 3 MCP client(s): Visual Studio Code, Visual Studio, Visual Studio MSAL
Granting all available scopes: scope1 scope2 scope3

Results Summary:
Successfully processed: 3 client(s)

✓ Successfully granted permissions to Visual Studio Code
  Grant ID: aaaaaaaa-bbbb-cccc-1111-222222222222
  Granted scopes:
    - scope1
    - scope2  
    - scope3

✓ Successfully granted permissions to Visual Studio
  Grant ID: bbbbbbbb-cccc-dddd-2222-333333333333
  Granted scopes:
    - scope1
    - scope2
    - scope3

✓ Successfully granted permissions to Visual Studio MSAL
  Grant ID: cccccccc-dddd-eeee-3333-444444444444
  Granted scopes:
    - scope1
    - scope2
    - scope3
```

This example grants all available delegated permissions to the three predefined MCP clients: Visual Studio Code, Visual Studio, and Visual Studio MSAL.

### Example 2: Grant specific scopes to Visual Studio Code

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
Grant-EntraBetaMcpServerPermission -MCPClient 'VisualStudioCode' -Scopes 'User.Read', 'Mail.Read'
```

```Output
Operating on 1 MCP client(s): Visual Studio Code
Granting specific scopes: Mail.Read User.Read

Results Summary:
Successfully processed: 1 client(s)

✓ Successfully granted permissions to Visual Studio Code
  Grant ID: dddddddd-eeee-ffff-4444-555555555555
  Granted scopes:
    - Mail.Read
    - User.Read
```

This example grants only specific scopes (User.Read and Mail.Read) to Visual Studio Code.

### Example 3: Grant permissions to a custom MCP client

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
$customClientId = '12345678-1234-5678-9012-123456789012'
Grant-EntraBetaMcpServerPermission -MCPClientServicePrincipalId $customClientId
```

```Output
Operating on 1 MCP client(s): Custom MCP Client
Granting all available scopes: scope1 scope2 scope3

Results Summary:
Successfully processed: 1 client(s)

✓ Successfully granted permissions to Custom MCP Client
  Grant ID: eeeeeeee-ffff-aaaa-5555-666666666666
  Granted scopes:
    - scope1
    - scope2
    - scope3
```

This example grants all available permissions to a custom MCP client identified by its service principal ID.

### Example 4: Grant specific scopes to multiple custom clients

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
$customClients = @('12345678-1234-5678-9012-123456789012', '87654321-4321-8765-2109-210987654321')
Grant-EntraBetaMcpServerPermission -MCPClientServicePrincipalId $customClients -Scopes 'User.Read', 'Files.Read'
```

```Output
Operating on 2 MCP client(s): Custom MCP Client, Custom MCP Client
Granting specific scopes: Files.Read User.Read

Results Summary:
Successfully processed: 2 client(s)

✓ Successfully granted permissions to Custom MCP Client
  Grant ID: ffffffff-aaaa-bbbb-6666-777777777777
  Granted scopes:
    - Files.Read
    - User.Read

✓ Successfully granted permissions to Custom MCP Client
  Grant ID: aaaaaaaa-bbbb-cccc-7777-888888888888
  Granted scopes:
    - Files.Read
    - User.Read
```

This example grants specific scopes to multiple custom MCP clients.

## PARAMETERS

### -MCPClient

Specifies one or more predefined MCP clients to grant permissions to. Valid values are:
- VisualStudioCode: Visual Studio Code
- VisualStudio: Visual Studio
- VisualStudioMSAL: Visual Studio MSAL

```yaml
Type: System.String[]
Parameter Sets: PredefinedClients, PredefinedClientsScopes
Aliases:

Required: True (PredefinedClients), False (PredefinedClientsScopes)
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MCPClientServicePrincipalId

Specifies the service principal IDs of custom MCP clients to grant permissions to. Must be valid GUIDs in the format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.

```yaml
Type: System.String[]
Parameter Sets: CustomClients, CustomClientsScopes
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
Parameter Sets: PredefinedClientsScopes, CustomClientsScopes
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

### None

This cmdlet doesn't generate any output objects.

## NOTES
- The cmdlet automatically creates service principals for the resource and client applications if they don't exist.
- Existing permission grants are updated to match the specified scopes exactly.
- If no scopes are specified, all available delegated scopes from the resource application are granted.
- The cmdlet requires specific Microsoft Graph scopes: `Application.ReadWrite.All`, `Directory.Read.All`, and `DelegatedPermissionGrant.ReadWrite.All`.

## RELATED LINKS

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[Get-EntraBetaServicePrincipalOAuth2PermissionGrant](Get-EntraBetaServicePrincipalOAuth2PermissionGrant.md)

[New-MgBetaOauth2PermissionGrant](https://learn.microsoft.com/powershell/module/microsoft.graph.beta.identity.signins/new-mgbetaoauth2permissiongrant)