---
title: New-EntraPolicy
description: This article provides details on the New-EntraPolicy command.


ms.topic: reference
ms.date: 08/02/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/New-EntraPolicy

schema: 2.0.0
---

# New-EntraPolicy

## Synopsis

Creates a policy.

## Syntax

```powershell
New-EntraPolicy
 -Definition <System.Collections.Generic.List`1[System.String]>
 -DisplayName <String>
 -Type <String>
 [-IsOrganizationDefault <Boolean>]
 [<CommonParameters>]
```

## Description

The `New-EntraPolicy` cmdlet creates a policy in Microsoft Entra ID. Specify `DisplayName`, `Definition` and `Type` parameters for create a new policy.

## Examples

### Example 1: Create a new policy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$definition = @('{"HomeRealmDiscoveryPolicy":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}')
New-EntraPolicy -Definition $definition -DisplayName 'NewPolicy' -Type 'HomeRealmDiscoveryPolicy'
```

```Output
Definition                                                                     DeletedDateTime Description DisplayName Id                                   IsOrganizationD
                                                                                                                                                            efault
----------                                                                     --------------- ----------- ----------- --                                   ---------------
{{"HomeReayPolicy":{"AlternateLoginIDLookup":true, "IncluderIds":["UserID"]}}}                              NewPolicy aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb False
```

This command creates a new policy in Microsoft Entra ID.

- `-Definition` Parameter specifies an array of JSON that contains all the rules of the policy.

- `-Type` Parameter specifies the type of policy.

### Example 2: Create a ClaimsMappingPolicy policy by 'IsOrganizationDefault' parameter

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$definition = @('{ "definition": [ "{\"ClaimsMappingPolicy\":{\"Version\":1,\"IncludeBasicClaimSet\":\"true\",\"ClaimsSchema\":[{\"Source\":\"user\",\"ID\":\"userPrincipalName\",\"SAMLClaimType\":\"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name\",\"JwtClaimType\":\"upn\"},{\"Source\":\"user\",\"ID\":\"displayName\",\"SAMLClaimType\":\"http://schemas.microsoft.com/identity/claims/displayname\",\"JwtClaimType\":\"name\"}]}}" ], "displayName": "Custom Claims Issuance Policy", "isOrganizationDefault": false }')
New-EntraPolicy -Definition $definition -DisplayName 'ClaimstestPolicy' -Type 'claimsMappingPolicies' -IsOrganizationDefault $false
```

```Output
Definition
----------
{{ "definition": [ "{\"ClaimsMappingPolicy\":{\"Version\":1,\"IncludeBasicClaimSet\":\"true\",\"ClaimsSchema\":[{\"Source\":\"user\",\"ID\":\"userPrincipalName\",\"SAMLCl…
```

This command creates a ClaimsMappingPolicy using 'IsOrganizationDefault' parameter in Microsoft Entra ID.

- `-Definition` Parameter specifies an array of JSON that contains all the rules of the policy.

- `-Type` - Parameter specifies the type of policy. In this example, `ClaimsMappingPolicy`
 represents the type of policy.

- `-IsOrganizationDefault` If true, activates this policy. Only one policy of the same type can be the organization default. Optional, default is false.

### Example 3: Create a TokenLifetimePolicy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$definition = @('{"TokenLifetimePolicy":{"Version":1,"AccessTokenLifetime":"8:00:00"}}')
New-EntraPolicy -Definition $definition -DisplayName 'TokenLifetimePolicy' -Type 'TokenLifetimePolicy' -IsOrganizationDefault $false
```

```Output
Definition                                                              DeletedDateTime Description DisplayName          Id                                   IsOrganizatio
                                                                                                                                                              nDefault
----------                                                              --------------- ----------- -----------          --                                   -------------
{{"TokenLifetimePolicy":{"Version":1,"AccessTokenLifetime":"8:00:00"}}}                             TokenLifetimePolicy aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb False
```

This command creates a TokenLifetimePolicy in Microsoft Entra ID.

- `-Definition` Parameter specifies an array of JSON that contains all the rules of the policy.

- `-Type` Parameter specifies the type of policy.

### Example 4: Create a TokenIssuancePolicy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$definition = @('{"TokenIssuancePolicy":{"Version":1,"SigningAlgorithm":"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256","SamlTokenVersion":1.1,"TokenResponseSigningPolicy":"TokenOnly","EmitSAMLNameFormat":"true"}}')
New-EntraPolicy -Definition $definition -DisplayName 'tokenIssuance' -Type 'TokenIssuancePolicy'
```

```Output
Definition
----------
{{"TokenIssuancePolicy":{"Version":1,"SigningAlgorithm":"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256","SamlTokenVersion":1.1,"TokenResponseSigningPolicy":"TokenOnly…
```

This command creates a TokenIssuancePolicy in Microsoft Entra ID.

- `-Definition` Parameter specifies an array of JSON that contains all the rules of the policy.

- `-Type` Parameter specifies the type of policy.

### Example 5: Create a ActivityBasedTimeoutPolicy

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.ApplicationConfiguration'
$definition = @('{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}')
New-EntraPolicy -Definition $definition -DisplayName 'ActivityBasedTimeoutPolicyname' -Type 'ActivityBasedTimeoutPolicy'
```

```Output
Definition                                                                                       DeletedDateTime Description DisplayName                    Id
----------                                                                                       --------------- ----------- -----------                    --
{{"activityBasedTimeoutPolicies":{"AlternateLoginIDLookup":true, "IncludedUserIds":["UserID"]}}}                             ActivityBasedTimeoutPolicyname aaaaaaaa-0000-1111-2222...

```

This command creates a ActivityBasedTimeoutPolicy in Microsoft Entra ID.

- `-Definition` Parameter specifies an array of JSON that contains all the rules of the policy.

- `-Type` Parameter specifies the type of policy.

## Parameters

### -Definition

Specifies an array of JSON that contains all the rules of the policy, for example: -Definition @("{"TokenLifetimePolicy":{"Version":1,"MaxInactiveTime":"20:00:00"}}").

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName

String of the policy name.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IsOrganizationDefault

True if this policy is the organizational default.

```yaml
Type: System.Boolean
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
For token lifetimes, specify "TokenLifetimePolicy."

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraPolicy](Get-EntraPolicy.md)

[Remove-EntraPolicy](Remove-EntraPolicy.md)

[Set-EntraPolicy](Set-EntraPolicy.md)
