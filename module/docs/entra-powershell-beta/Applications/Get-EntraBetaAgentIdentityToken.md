---
author: givinalis
description: This article provides details on the Get-EntraBetaAgentIdentityToken command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
Module Name: Microsoft.Entra.Beta.Applications
ms.author: giomachar
ms.date: 12/17/2024
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Get-EntraBetaAgentIdentityToken
schema: 2.0.0
title: Get-EntraBetaAgentIdentityToken
---

# Get-EntraBetaAgentIdentityToken

## SYNOPSIS

Acquires an access token for an agent identity using client credentials.

## SYNTAX

```powershell
Get-EntraBetaAgentIdentityToken
 [-BlueprintAppId <String>]
 [-AgentIdentityAppId <String>]
 [-BlueprintSecret <SecureString>]
 [-Scope <String>]
 [-Mode <String>]
 [-UserToken <String>]
 [-UserUpn <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaAgentIdentityToken` cmdlet acquires an access token for an agent identity using client credentials. To create a new agent identity for this session, use Invoke-EntraBetaAgentIdInteractive. The token is returned as a string.

## EXAMPLES

### Example 1: Get token using stored session values

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
# Create agent identity using interactive cmdlet
Invoke-EntraBetaAgentIdInteractive
# Get token using stored values from the session
$token = Get-EntraBetaAgentIdentityToken
```

This example retrieves an access token using the blueprint and agent identity created in the current session.

### Example 2: Get token with specific parameters

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$secret = ConvertTo-SecureString "your-secret-here" -AsPlainText -Force
$token = Get-EntraBetaAgentIdentityToken -BlueprintAppId "12345..." -AgentIdentityAppId "87654..." -BlueprintSecret $secret -Scope "https://graph.microsoft.com/.default"
```

This example retrieves an access token by providing all required parameters explicitly.

### Example 3: Get token for OBO (On-Behalf-Of) flow

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$userToken = "user-access-token"
$token = Get-EntraBetaAgentIdentityToken -BlueprintAppId "12345..." -AgentIdentityAppId "87654..." -Scope "https://graph.microsoft.com/.default" -Mode OBO -UserToken $userToken
```

This example retrieves an access token using the On-Behalf-Of (OBO) flow, where the agent acts on behalf of a user.

### Example 4: Get token for AutonomousUser mode

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$token = Get-EntraBetaAgentIdentityToken -BlueprintAppId "12345..." -AgentIdentityAppId "87654..." -Scope "https://graph.microsoft.com/.default" -Mode AutonomousUser -UserUpn "user@contoso.com"
```

This example retrieves an access token in AutonomousUser mode, specifying a user UPN.

## PARAMETERS

### -BlueprintAppId

The blueprint application ID. If not provided, the blueprint created in this session is used.

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

### -AgentIdentityAppId

The agent identity application ID. If not provided, the agent identity created in this session is used.

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

### -BlueprintSecret

The blueprint client secret. If not provided, the secret created in this session is used.

```yaml
Type: System.Security.SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope

The scope to acquire a token for (e.g., User.Read). If not provided, the default scope is used (https://graph.microsoft.com/.default).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: https://graph.microsoft.com/.default
Accept pipeline input: False
Accept wildcard characters: False
```

### -Mode

Authentication mode: AutonomousApp (default), OBO, or AutonomousUser.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: AutonomousApp
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserToken

User token for OBO mode (required when Mode is OBO).

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

### -UserUpn

User UPN for AutonomousUser mode (required when Mode is AutonomousUser).

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

### System.String

Returns the access token as a string.

## NOTES

This cmdlet supports three authentication modes:
- AutonomousApp: App-only authentication (default)
- OBO: On-Behalf-Of flow where the agent acts on behalf of a user
- AutonomousUser: User-specific authentication

## RELATED LINKS

[Invoke-EntraBetaAgentIdInteractive](Invoke-EntraBetaAgentIdInteractive.md)

[New-EntraBetaAgentIdentityBlueprint](New-EntraBetaAgentIdentityBlueprint.md)

[New-EntraBetaAgentIDForAgentIdentityBlueprint](New-EntraBetaAgentIDForAgentIdentityBlueprint.md)
