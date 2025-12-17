---
author: givinalis
description: This article provides details on the Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal
schema: 2.0.0
title: Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal
---

# Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal

## SYNOPSIS

Opens admin consent page in browser for Agent Identity Blueprint Principal to inherit permissions.

## SYNTAX

```powershell
Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal
 [-AgentBlueprintId <String>]
 [-Scopes <String[]>]
 [-RedirectUri <String>]
 [-State <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal` cmdlet launches the system browser with the admin consent URL for the Agent Identity Blueprint Principal. This allows the administrator to grant permissions that the blueprint can inherit and use. Uses the stored AgentBlueprintId from the last New-AgentIdentityBlueprint call.

## EXAMPLES

### Example 1: Open admin consent page using stored blueprint ID

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("user1@contoso.com")
Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal
```

This example opens the admin consent page in the browser for the Agent Identity Blueprint that was just created. The cmdlet will prompt for permission scopes if not provided.

### Example 2: Open admin consent page with specific scopes

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -Scopes @("user.read", "mail.read", "calendars.read")
```

This example opens the admin consent page with specific permission scopes (user.read, mail.read, calendars.read).

### Example 3: Open admin consent page with specific blueprint ID and scopes

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal -AgentBlueprintId "7c0c1226-1e81-41a5-ad6c-532c95504443" -Scopes @("user.read")
```

This example opens the admin consent page for a specific Agent Identity Blueprint by providing the blueprint ID and requested scopes.

## PARAMETERS

### -AgentBlueprintId

The Application ID (AppId) of the Agent Identity Blueprint to grant consent for. If not provided, uses the stored ID from the last blueprint creation.

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

The permission scopes to request consent for. If not provided, will prompt for input or use previously configured inheritable scopes.

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

Returns an object with the consent URL and parameters used.

## NOTES

This cmdlet opens the default system browser to the admin consent page. An administrator must complete the consent process in the browser.

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint](Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint.md)

[New-EntraBetaAgentIdentityBlueprintPrincipal](New-EntraBetaAgentIdentityBlueprintPrincipal.md)
