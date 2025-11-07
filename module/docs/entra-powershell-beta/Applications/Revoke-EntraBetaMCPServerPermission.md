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

### PredefinedClient (Default)

```powershell
Revoke-EntraBetaMCPServerPermission
 [-MCPClient <String>]
 [-Scopes <String[]>]
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

### CustomClient

```powershell
Revoke-EntraBetaMCPServerPermission
 -MCPClientServicePrincipalId <String>
 [-Scopes <String[]>]
 [-WhatIf]
 [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

The `Revoke-EntraBetaMCPServerPermission` cmdlet revokes Microsoft MCP Server permissions from a specified client in Microsoft Entra ID. This cmdlet can revoke permissions from a predefined MCP client (Visual Studio Code, Visual Studio, Visual Studio MSAL) or from a custom client using its service principal ID.

The cmdlet supports both full permission revocation (removing all granted scopes) and partial revocation (removing specific scopes while keeping others intact). When permissions are partially revoked, the cmdlet returns an OAuth2PermissionGrant object representing the updated permission grant. When all permissions are revoked, the grant is deleted and the cmdlet returns null.

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

### Example 2: Revoke specific scopes from a predefined client

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
$result = Revoke-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes 'User.Read', 'Directory.Read.All'
```

This example revokes specific scopes from Visual Studio Code client and returns the updated OAuth2PermissionGrant object with remaining permissions.

### Example 3: Revoke permissions from custom MCP client

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
Revoke-EntraBetaMCPServerPermission -MCPClientServicePrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222'
```

This example revokes all permissions from a custom MCP client using its service principal ID.

### Example 4: Revoke specific scopes from custom client

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
$grant = Revoke-EntraBetaMCPServerPermission -MCPClientServicePrincipalId 'aaaaaaaa-bbbb-cccc-1111-222222222222' -Scopes 'User.Read'
```

This example revokes the 'User.Read' scope from a custom MCP client and stores the updated grant object.

### Example 5: Understanding return values

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'

# Partial revocation - returns updated OAuth2PermissionGrant object
$partialResult = Revoke-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -Scopes 'User.Read'
if ($partialResult) {
    Write-Host "Remaining scopes: $($partialResult.Scope)"
}

# Complete revocation - returns null
$completeResult = Revoke-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode'
if ($null -eq $completeResult) {
    Write-Host "All permissions have been revoked"
}
```

This example demonstrates the different return values: an OAuth2PermissionGrant object for partial revocation and null for complete revocation.

### Example 6: Use WhatIf to preview changes

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
Revoke-EntraBetaMCPServerPermission -MCPClient 'VisualStudioCode' -WhatIf
```

This example shows what permissions would be revoked without actually making the changes.

## PARAMETERS

### -MCPClient

Specifies a predefined MCP client from which to revoke permissions. Valid values are:
- VisualStudioCode
- VisualStudio  
- VisualStudioMSAL

```yaml
Type: System.String
Parameter Sets: PredefinedClient
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MCPClientServicePrincipalId

Specifies the service principal ID of a custom MCP client from which to revoke permissions. Must be a valid GUID.

```yaml
Type: System.String
Parameter Sets: CustomClient
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scopes

Specifies the specific scope(s) to revoke. If not provided, all permissions will be revoked from the specified client.

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

### Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphOAuth2PermissionGrant

When permissions are partially revoked (some scopes remain), the cmdlet returns an OAuth2PermissionGrant object representing the updated permission grant with the remaining scopes.

### System.Null

When all permissions are revoked, the permission grant is deleted and the cmdlet returns null.

## NOTES

- The cmdlet requires connection to Microsoft Entra with appropriate scopes: 'Application.ReadWrite.All', 'Directory.Read.All', 'DelegatedPermissionGrant.ReadWrite.All'
- Use `-WhatIf` parameter to preview changes before execution
- The cmdlet supports both complete permission revocation and selective scope removal
- **Return Values**: The cmdlet returns an OAuth2PermissionGrant object when permissions are partially revoked (some scopes remain), and returns null when all permissions are revoked (grant is deleted)
- The cmdlet processes one client at a time; use multiple invocations to process multiple clients

## RELATED LINKS

[Get-EntraBetaServicePrincipal](Get-EntraBetaServicePrincipal.md)

[Get-EntraBetaServicePrincipalOAuth2PermissionGrant](Get-EntraBetaServicePrincipalOAuth2PermissionGrant.md)