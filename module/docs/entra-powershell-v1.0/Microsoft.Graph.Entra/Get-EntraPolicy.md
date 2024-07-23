---
title: Get-EntraPolicy
description: This article provides details on the Get-EntraPolicy command.

ms.topic: reference
ms.date: 07/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/en-us/powershell/module/Microsoft.Graph.Entra/Get-EntraPolicy

schema: 2.0.0
---

# Get-EntraPolicy

## SYNOPSIS

Gets a policy.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraPolicy 
 [-Top <Int32>] 
 [-All] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraPolicy 
 -Id <String> 
 [-All] 
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraPolicy` cmdlet gets a policy in Microsoft Entra ID. Specify `Id` parameter to get a policy.

## EXAMPLES

### Example 1: Gets all policy

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraPolicy
```

```Output
Name                           Value
----                           -----
deletedDateTime
id                             'bbbbbbbb-1111-2222-3333-cccccccccccc
displayName                    New update
definition                     {{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}
isOrganizationDefault          False
Type                           HomeRealmDiscoveryPolicy
deletedDateTime
id                             bbbbbbbb-1111-2222-3333-cccccccccccc
displayName                    MyPolicy
definition                     {{"HomeRealmDisccccoveryPolicy":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}
isOrganizationDefault          False
Type                           HomeRealmDiscoveryPolicy
```

This example shows how to return all policies.

### Example 2: Get a policy with specific ID

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraPolicy -Id 'bbbbbbbb-1111-2222-3333-cccccccccccc'
```

```Output
Name                           Value
----                           -----
deletedDateTime
id                             bbbbbbbb-1111-2222-3333-cccccccccccc
displayName                    MyPolicy
definition                     {{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}
isOrganizationDefault          False
Type                           HomeRealmDiscoveryPolicy
```

This example demonstrated how to receive policy with specific ID.

- `Id` parameter specifies the unique policy ID, which you want to receive. In this example, `bbbbbbbb-1111-2222-3333-cccccccccccc` represents the ID of the policy.

### Example 3: Get a top one policy

```powershell
Connect-Entra -Scopes 'Policy.Read.All'
Get-EntraPolicy -Top 1
```

```Output
Name                           Value
----                           -----
deletedDateTime
id                             bbbbbbbb-1111-2222-3333-cccccccccccc
displayName                    MyPolicy
definition                     {{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}
isOrganizationDefault          False
Type                           HomeRealmDiscoveryPolicy
```

This example Return top one policy.

## PARAMETERS

### -Id

The ID of the policy you want to retrieve

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -All

List all policies.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraPolicy](New-EntraPolicy.md)

[Remove-EntraPolicy](Remove-EntraPolicy.md)

[Set-EntraPolicy](Set-EntraPolicy.md)
