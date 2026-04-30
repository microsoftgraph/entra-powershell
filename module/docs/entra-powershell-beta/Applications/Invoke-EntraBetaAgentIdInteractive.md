---
author: givinalis
description: This article provides details on the Invoke-EntraBetaAgentIdInteractive command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Invoke-EntraBetaAgentIdInteractive
schema: 2.0.0
title: Invoke-EntraBetaAgentIdInteractive
---

# Invoke-EntraBetaAgentIdInteractive

## SYNOPSIS

Interactive cmdlet to create and configure an Agent ID.

## SYNTAX

```powershell
Invoke-EntraBetaAgentIdInteractive
 [<CommonParameters>]
```

## DESCRIPTION

The `Invoke-EntraBetaAgentIdInteractive` cmdlet demonstrates the full workflow of creating and configuring an Agent Identity Blueprint, including creating Agent Identities and Agent Users as needed.

This interactive cmdlet guides you through the complete Agent Identity setup process with prompts at key decision points:

1. **Blueprint creation** — Create an Agent Identity Blueprint with optional sponsors
2. **Security configuration** — Add a client secret for API authentication
3. **Interactive agent support** — Configure scopes for agents acting on behalf of users
4. **Agent user creation** — Configure the blueprint to allow creating Agent ID users without a user
5. **Inheritable permissions** — Set up permissions that agent identities inherit from the blueprint
6. **Permission model** — Choose between static (recommended for Agent 365) or dynamic permissions
7. **Admin consent** — Obtain tenant admin consent for the blueprint's permissions
8. **Agent Identity and User creation** — Create one or more Agent Identities and Agent Users

The cmdlet maintains state between operations, automatically passing Blueprint IDs and other required values to subsequent operations. You can create multiple Agent Identities and Users in a single session.

## EXAMPLES

### Example 1: Start the interactive Agent Identity configuration workflow

```powershell
Connect-Entra -Scopes 'AgentIdentity.Create.All', 'AgentIdentityBlueprint.UpdateAuthProperties.All', 'AgentIdUser.ReadWrite.All', 'User.ReadBasic.All', 'AgentIdentityBlueprint.AddRemoveCreds.All', 'AgentIdentityBlueprint.ReadWrite.All' -TenantId <tenant ID>
Invoke-EntraBetaAgentIdInteractive
```

This example starts the interactive Agent Identity configuration workflow. The cmdlet will prompt you for all required inputs and guide you through the complete setup process.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

This cmdlet requires the following Microsoft Graph permissions:

- AgentIdentity.Create.All
- AgentIdentityBlueprint.UpdateAuthProperties.All
- AgentIdUser.ReadWrite.All
- User.ReadBasic.All
- AgentIdentityBlueprint.AddRemoveCreds.All
- AgentIdentityBlueprint.ReadWrite.All

The cmdlet requires an active Microsoft Graph connection with the above permissions before running. Use `Connect-Entra -Scopes` to connect first. The cmdlet checks for an active connection at startup and throws an error if not connected.

The cmdlet stores state in module-scoped variables (such as `$script:CurrentAgentBlueprintId`) that are passed automatically to subsequent operations within the session.

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Add-EntraBetaClientSecretToAgentIdentityBlueprint](Add-EntraBetaClientSecretToAgentIdentityBlueprint.md)

[Add-EntraBetaScopeToAgentIdentityBlueprint](Add-EntraBetaScopeToAgentIdentityBlueprint.md)

[Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint](Add-EntraBetaInheritablePermissionsToAgentIdentityBlueprint.md)

[Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint](Add-EntraBetaRequiredResourceAccessToAgentIdentityBlueprint.md)

[New-EntraBetaAgentIdentityBlueprintPrincipal](New-EntraBetaAgentIdentityBlueprintPrincipal.md)

[Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal](Add-EntraBetaPermissionToCreateAgentUsersToAgentIdentityBlueprintPrincipal.md)

[Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal](Add-EntraBetaPermissionsToInheritToAgentIdentityBlueprintPrincipal.md)

[New-EntraBetaAgentIDForAgentIdentityBlueprint](New-EntraBetaAgentIDForAgentIdentityBlueprint.md)

[New-EntraBetaAgentUserForAgentId](../Users/New-EntraBetaAgentUserForAgentId.md)
