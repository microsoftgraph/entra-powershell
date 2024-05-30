---
title: Get-EntraPolicy
description: This article provides details on the Get-EntraPolicy command.

ms.service: active-directory
ms.topic: reference
ms.date: 05/50/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
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
The Get-EntraPolicy cmdlet gets a policy in Microsoft Entra ID.

## EXAMPLES

### Example 1: Gets all policy 
```powershell
PS C:\> Get-EntraPolicy
```
```output
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
displayName                    ss44$false%%%
definition                     {{"HomeRealmDisccccoveryPolicy":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}
isOrganizationDefault          False
Type                           HomeRealmDiscoveryPolicy
```
This exmaple return all the policy.

### Example 2: Get a policy with specific ID.
```powershell
PS C:\> Get-EntraPolicy -Id "bbbbbbbb-1111-2222-3333-cccccccccccc"
```
```output
Name                           Value
----                           -----
deletedDateTime
id                             bbbbbbbb-1111-2222-3333-cccccccccccc
displayName                    New update
definition                     {{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}
isOrganizationDefault          False
Type                           HomeRealmDiscoveryPolicy
```
This example demonstrated how to receive policy with specific ID.

### Example 4: Get a top one policy 
```powershell
PS C:\> Get-EntraPolicy -Top 1
```
```output
Name                           Value
----                           -----
deletedDateTime
id                             bbbbbbbb-1111-2222-3333-cccccccccccc
displayName                    New update
definition                     {{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}
isOrganizationDefault          False
Type                           HomeRealmDiscoveryPolicy
```
This example Return top one policy.


## PARAMETERS

### -Id
The ID of the policy you want to retrieve

```yaml
Type: String
Parameter Sets: GetById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -All
List all pages.

```yaml
Type: SwitchParameter
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
Type: Int32
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraBetaPolicy](New-EntraBetaPolicy.md)

[Remove-EntraBetaPolicy](Remove-EntraBetaPolicy.md)

[Set-EntraBetaPolicy](Set-EntraBetaPolicy.md)