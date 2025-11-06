---
author: giomachar
description: This article provides details on the Revoke-EntraBetaMCPServerPermission command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 11/06/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Revoke-EntraBetaMCPServerPermission
schema: 2.0.0
title: Revoke-EntraBetaMCPServerPermission
---

# Revoke-EntraBetaMCPServerPermission

## SYNOPSIS

Revokes MCP Server permissions from specified clients.

## SYNTAX

### PredefinedClients (Default)

```powershell
Revoke-EntraBetaMCPServerPermission
 [-MCPClient <String[]>]
 [-Scopes <String[]>]
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

### CustomClients

```powershell
Revoke-EntraBetaMCPServerPermission
 -MCPClientServicePrincipalId <String[]>
 [-Scopes <String[]>]
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Revoke-EntraBetaMCPServerPermission` cmdlet revokes Microsoft MCP Server permissions from specified clients in Microsoft Entra ID. This cmdlet can revoke permissions from predefined MCP clients (Visual Studio Code, Visual Studio, Visual Studio MSAL) or from custom clients using their service principal IDs.

The cmdlet supports both full permission revocation (removing all granted scopes) and partial revocation (removing specific scopes while keeping others intact).

For delegated scenarios, the calling user needs at least one of the following Microsoft Entra roles:
- Application Administrator
- Cloud Application Administrator
- Global Administrator

## EXAMPLES

### Example 1: Revoke all permissions from Visual Studio Code

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
Revoke-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode'
```

This example revokes all MCP Server permissions from Visual Studio Code client.

### Example 2: Revoke specific scopes from multiple predefined clients

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
Revoke-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode', 'VisualStudio' -Scopes 'User.Read', 'Directory.Read.All'
```

This example revokes specific scopes from both Visual Studio Code and Visual Studio clients.

### Example 3: Revoke permissions from custom MCP client

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
Revoke-EntraBetaMCPServerPermission -MCPClientServicePrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222'
```

This example revokes all permissions from a custom MCP client using its service principal ID.

### Example 4: Revoke specific scopes from custom clients

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
Revoke-EntraBetaMCPServerPermission -MCPClientServicePrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222', 'bbbbbbbb-cccc-dddd-2222-333333333333' -Scopes 'User.Read'
```

This example revokes the 'User.Read' scope from multiple custom MCP clients.

### Example 5: Use WhatIf to preview changes

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
Revoke-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -WhatIf
```

This example shows what permissions would be revoked without actually making the changes.

## PARAMETERS

### -MCPClient

Specifies the predefined MCP client(s) from which to revoke permissions. Valid values are:
- VisualStudioCode
- VisualStudio  
- VisualStudioMSAL

```yaml
Type: System.String[]
Parameter Sets: PredefinedClients
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MCPClientServicePrincipalId

Specifies the service principal ID(s) of custom MCP client(s) from which to revoke permissions. Must be valid GUIDs.

```yaml
Type: System.String[]
Parameter Sets: CustomClients
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scopes

Specifies the specific scope(s) to revoke. If not provided, all permissions will be revoked from the specified client(s).

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

This cmdlet displays results to the console but does not return objects.

## NOTES

- The cmdlet requires connection to Microsoft Entra with appropriate scopes: 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
- Use `-WhatIf` parameter to preview changes before execution
- The cmdlet supports both complete permission revocation and selective scope removal

## RELATED LINKS

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[Get-EntraBetaServicePrincipalOAuth2PermissionGrant](Get-EntraBetaServicePrincipalOAuth2PermissionGrant.md)