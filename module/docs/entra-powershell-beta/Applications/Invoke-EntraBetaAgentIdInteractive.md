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

- Blueprint creation with optional sponsors
- Client secret generation for API authentication
- Interactive agent scope configuration
- Inheritable permissions setup
- Service principal creation and permissions
- Admin consent flow (when applicable)
- Agent Identity and Agent User creation

The cmdlet maintains state between operations, automatically passing Blueprint IDs and other required values to subsequent operations. You can create multiple Agent Identities and Users in a single session.

## EXAMPLES

### Example 1: Start the interactive Agent Identity configuration workflow

```powershell
Connect-Entra -Scopes 'AgentIdentityBlueprint.Create', 'AgentIdentityBlueprintPrincipal.Create', 'AppRoleAssignment.ReadWrite.All', 'Application.ReadWrite.All', 'User.ReadWrite.All'
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

- AgentIdentityBlueprint.Create
- AgentIdentityBlueprintPrincipal.Create
- AppRoleAssignment.ReadWrite.All
- Application.ReadWrite.All
- User.ReadWrite.All

The cmdlet will automatically connect to Microsoft Graph with these permissions if not already connected.

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Add-EntraBetaClientSecretToAgentIdentityBlueprint](Add-EntraBetaClientSecretToAgentIdentityBlueprint.md)

[New-EntraBetaAgentIdentityBlueprintPrincipal](New-EntraBetaAgentIdentityBlueprintPrincipal.md)
