---
author: givinalis
description: This article provides details on the Add-EntraBetaClientSecretToAgentIdentityBlueprint command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Add-EntraBetaClientSecretToAgentIdentityBlueprint
schema: 2.0.0
title: Add-EntraBetaClientSecretToAgentIdentityBlueprint
---

# Add-EntraBetaClientSecretToAgentIdentityBlueprint

## SYNOPSIS

Adds a client secret to the current Agent Identity Blueprint.

## SYNTAX

```powershell
Add-EntraBetaClientSecretToAgentIdentityBlueprint
 [-AgentBlueprintId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaClientSecretToAgentIdentityBlueprint` cmdlet creates an application password for the most recently created Agent Identity Blueprint using New-MgApplicationPassword. Uses the stored AgentBlueprintId from the last New-AgentIdentityBlueprint call.

## EXAMPLES

### Example 1: Add a client secret using stored blueprint ID

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("user1@contoso.com")
Add-EntraBetaClientSecretToAgentIdentityBlueprint
```

This example adds a client secret to the Agent Identity Blueprint that was just created. The cmdlet uses the stored blueprint ID from the last blueprint creation.

### Example 2: Add a client secret using specific blueprint ID

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Add-EntraBetaClientSecretToAgentIdentityBlueprint -AgentBlueprintId "12345678-1234-1234-1234-123456789012"
```

This example adds a client secret to the specified Agent Identity Blueprint by providing an explicit AgentBlueprintId parameter.

## PARAMETERS

### -AgentBlueprintId

The ID of the Agent Identity Blueprint to add the secret to. If not provided, uses the stored ID from the last blueprint creation.

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

Returns the secret result object with KeyId, EndDateTime, and SecretText properties.

## NOTES

The client secret is valid for 90 days by default. The secret is returned only once and should be stored securely.

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[New-EntraBetaAgentIdentityBlueprintPrincipal](New-EntraBetaAgentIdentityBlueprintPrincipal.md)
