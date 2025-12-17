---
author: givinalis
description: This article provides details on the Add-EntraBetaRedirectURIToAgentIdentityBlueprint command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Add-EntraBetaRedirectURIToAgentIdentityBlueprint
schema: 2.0.0
title: Add-EntraBetaRedirectURIToAgentIdentityBlueprint
---

# Add-EntraBetaRedirectURIToAgentIdentityBlueprint

## SYNOPSIS

Adds a web redirect URI to the current Agent Identity Blueprint.

## SYNTAX

```powershell
Add-EntraBetaRedirectURIToAgentIdentityBlueprint
 [-RedirectUri <String>]
 [-AgentBlueprintId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Add-EntraBetaRedirectURIToAgentIdentityBlueprint` cmdlet configures a web redirect URI for the Agent Identity Blueprint application registration. This allows the application to receive authorization callbacks at the specified URI. Uses the stored AgentBlueprintId from the last New-AgentIdentityBlueprint call.

## EXAMPLES

### Example 1: Add default redirect URI using stored blueprint ID

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
New-EntraBetaAgentIdentityBlueprint -DisplayName "My Blueprint" -SponsorUserIds @("user1@contoso.com")
Add-EntraBetaRedirectURIToAgentIdentityBlueprint
```

This example adds the default redirect URI "http://localhost" to the Agent Identity Blueprint that was just created.

### Example 2: Add custom redirect URI

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Add-EntraBetaRedirectURIToAgentIdentityBlueprint -RedirectUri "http://localhost:3000"
```

This example adds a custom redirect URI "http://localhost:3000" to the current Agent Identity Blueprint.

### Example 3: Add redirect URI with specific blueprint ID

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
Add-EntraBetaRedirectURIToAgentIdentityBlueprint -RedirectUri "https://myapp.com/callback" -AgentBlueprintId "12345678-1234-1234-1234-123456789012"
```

This example adds a custom redirect URI to a specific Agent Identity Blueprint by providing the blueprint ID.

## PARAMETERS

### -RedirectUri

The redirect URI to add to the Agent Identity Blueprint. Defaults to "http://localhost".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: http://localhost
Accept pipeline input: False
Accept wildcard characters: False
```

### -AgentBlueprintId

The ID of the Agent Identity Blueprint to configure. If not provided, uses the stored ID from the last blueprint creation.

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

Returns an object with redirect URI information including the blueprint ID and the list of redirect URIs.

## NOTES

If the specified redirect URI already exists, the cmdlet will skip adding it and return the existing configuration.

## RELATED LINKS

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[Add-EntraBetaScopeToAgentIdentityBlueprint](Add-EntraBetaScopeToAgentIdentityBlueprint.md)
