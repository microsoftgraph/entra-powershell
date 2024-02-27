---
title: Set-EntraBetaPolicy.
description: This article provides details on the Set-EntraBetaPolicy command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Set-EntraBetaPolicy

## SYNOPSIS
Updates a policy.

## SYNTAX

```
Set-EntraBetaPolicy
 -Id <String>
 [-AlternativeIdentifier <String>]
 [-Definition <System.Collections.Generic.List`1[System.String]>]
 [-DisplayName <String>]
 [-Type <String>]
 [-KeyCredentials <System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]>]
 [-IsOrganizationDefault <Boolean>]
 [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraBetaPolicy cmdlet sets a policy in Microsoft Entra ID.

## EXAMPLES

### Example 1: Update a policy display name
```
PS C:\>Set-EntraBetaPolicy  -Id "364e07d3-529b-4ffc-96be-56bbacf34ace" -DisplayName "New update"
```

This command updates display name of the specified policy in Microsoft Entra ID.

### Example 2: Update a policy definition
```
PS C:\>Set-EntraBetaPolicy  -Id "364e07d3-529b-4ffc-96be-56bbacf34ace" -Definition @('{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}')
```

This command updates defination of the specified policy in Microsoft Entra ID.

### Example 3: Update a policy organization default
```
PS C:\Set-EntraBetaPolicy  -Id "364e07d3-529b-4ffc-96be-56bbacf34ace" -IsOrganizationDefault $false
```

This command updates organization default of the specified policy in Microsoft Entra ID.

### Example 4: Update policy type
```
PS C:\Set-EntraBetaPolicy  -Id "364e07d3-529b-4ffc-96be-56bbacf34ace" -Type "HomeRealmDiscoveryPolicy"
```

This command updates type of the specified policy in Microsoft Entra ID.

### Example 5: Update policy alternative Identifier
```
PS C:\Set-EntraBetaPolicy  -Id "364e07d3-529b-4ffc-96be-56bbacf34ace" -AlternativeIdentifier "4f2283ed-ad98-48ea-9ade-4c77d55ed983"
```

This command updates alternative identifier of the specified policy in Microsoft Entra ID.

## PARAMETERS

### -AlternativeIdentifier
Specifies an alternative ID for the policy.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Definition
Specifies the array of stringfied JSON that contains all the rules of the policy.
For example -Definition @("{"TokenLifetimePolicy":{"Version":1,"MaxInactiveTime":"20:00:00"}}") .

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName
Specifies the display name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsOrganizationDefault
True if this policy is the organisational default

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeyCredentials
Specifies the key credentials.

```yaml
Type: System.Collections.Generic.List`1[Microsoft.Open.MSGraph.Model.KeyCredential]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Specifies the type of policy.
For token lifetimes, use "TokenLifetimePolicy".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The Id pf the policy for which you want to set values.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaPolicy]()

[New-EntraBetaPolicy]()

[Remove-EntraBetaPolicy]()

