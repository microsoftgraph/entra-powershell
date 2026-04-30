---
author: givinalis
description: This article provides details on the Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Applications
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Applications/Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal
schema: 2.0.0
title: Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal
---

# Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal

## SYNOPSIS

Opens admin consent page in browser for Agent Identity Blueprint Principal to inherit permissions.

## SYNTAX

```powershell
Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal
 [-AgentBlueprintId <String>]
 [-Scopes <String[]>]
 [-Roles <String[]>]
 [-RedirectUri <String>]
 [-State <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal` cmdlet launches the system browser with the admin consent URL for the Agent Identity Blueprint Principal. This allows the administrator to grant delegated permissions (scopes) and/or application roles that the blueprint can inherit and pass to agent identities. The consent URL is built using the v2.0 admin consent endpoint. Uses the stored AgentBlueprintId from the last `New-EntraAgentIdentityBlueprint` call if no explicit ID is provided. If no stored ID is available, the cmdlet prompts interactively for the Agent Identity Blueprint ID. If neither `-Scopes` nor `-Roles` are provided, the cmdlet prompts interactively for scopes.

## EXAMPLES

### Example 1: Open admin consent page using stored blueprint ID

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All'
New-EntraAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("user1@contoso.com")
Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal
```

This example opens the admin consent page in the browser for the Agent Identity Blueprint that was just created. The cmdlet will prompt for permission scopes if not provided.

### Example 2: Open admin consent page with specific scopes

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All'
Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read", "mail.read", "calendars.read")
```

This example opens the admin consent page with specific permission scopes (user.read, mail.read, calendars.read).

### Example 3: Open admin consent page with specific blueprint ID and scopes

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All'
Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal -AgentBlueprintId "7c0c1226-1e81-41a5-ad6c-532c95504443" -Scopes @("user.read")
```

This example opens the admin consent page for a specific Agent Identity Blueprint by providing the blueprint ID and requested scopes.

### Example 4: Open admin consent page with application roles

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All'
Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal -Roles @("Mail.Read", "User.Read.All")
```

This example opens the admin consent page requesting application role (app-only) permissions instead of delegated scopes.

### Example 5: Open admin consent page with both scopes and roles

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.UpdateAuthProperties.All'
Add-EntraPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read") -Roles @("Mail.Read")
```

This example opens the admin consent page requesting both delegated scopes and application roles in a single consent flow.

## PARAMETERS

### -AgentBlueprintId

The Application ID (AppId) of the Agent Identity Blueprint to grant consent for. If not provided, uses the stored ID from the last blueprint creation. If no stored ID is available, prompts interactively.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scopes

The delegated permission scopes to request consent for. If neither `-Scopes` nor `-Roles` is provided, the cmdlet prompts interactively for scopes with a default suggestion of `user.read`.

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

### -Roles

The application roles (app-only permissions) to request consent for. These are included in the consent URL as the `role` parameter. Can be used together with `-Scopes` to request both delegated and app-only permissions.

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

### -RedirectUri

The redirect URI after consent. Defaults to "https://entra.microsoft.com/TokenAuthorize".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: https://entra.microsoft.com/TokenAuthorize
Accept pipeline input: False
Accept wildcard characters: False
```

### -State

State parameter for the consent request. Defaults to a random value.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

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

### System.Object

Returns a PSCustomObject with the following properties:

- **AgentBlueprintId** - The Application ID of the Agent Identity Blueprint.
- **TenantId** - The tenant ID where consent is being granted.
- **RequestedScopes** - Array of delegated permission scopes requested.
- **RequestedRoles** - Array of application roles requested.
- **RedirectUri** - The redirect URI used in the consent flow.
- **State** - The state parameter used in the consent request.
- **ConsentUrl** - The full admin consent URL that was opened in the browser.
- **Action** - The action taken (e.g., "Browser Launched").
- **Timestamp** - When the consent flow was initiated.

## NOTES

This cmdlet opens the default system browser to the admin consent page. An administrator must complete the consent process in the browser.

This cmdlet requires the following Microsoft Graph permission:

- AgentIdentityBlueprint.UpdateAuthProperties.All

The cmdlet does not make any Microsoft Graph API calls directly. It constructs a consent URL using the v2.0 admin consent endpoint (`https://login.microsoftonline.com/{tenantId}/v2.0/adminconsent`) and launches it in the system browser via `Start-Process`.

If no Agent Identity Blueprint ID is stored and none is provided as a parameter, the cmdlet prompts interactively for the ID.

If neither `-Scopes` nor `-Roles` is provided, the cmdlet prompts interactively with a default suggestion of `user.read`.

## RELATED LINKS

[New-EntraAgentIdentityBlueprint](New-EntraAgentIdentityBlueprint.md)

[Add-EntraInheritablePermissionsToAgentIdentityBlueprint](Add-EntraInheritablePermissionsToAgentIdentityBlueprint.md)

[New-EntraAgentIdentityBlueprintPrincipal](New-EntraAgentIdentityBlueprintPrincipal.md)
