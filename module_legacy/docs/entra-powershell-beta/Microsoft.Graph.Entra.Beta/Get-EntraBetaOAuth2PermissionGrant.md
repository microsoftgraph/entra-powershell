---
title: Get-EntraBetaOAuth2PermissionGrant
description: This article provides details on the Get-EntraBetaOAuth2PermissionGrant Command.


ms.topic: reference
ms.date: 10/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra.Beta/Get-EntraBetaOAuth2PermissionGrant

schema: 2.0.0
---

# Get-EntraBetaOAuth2PermissionGrant

## Synopsis

Gets OAuth2PermissionGrant entities.

## Syntax

```powershell
Get-EntraBetaOAuth2PermissionGrant
 [-Top <Int32>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaOAuth2PermissionGrant` cmdlet gets OAuth2PermissionGrant entities in Microsoft Entra ID.

In delegated scenarios with work or school accounts, the signed-in user must be assigned a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles are supported for this operation:

- Application Administrator
- Application Developer
- Cloud Application Administrator
- Directory Writers
- Privileged Role Administrator
- User Administrator
- Directory Readers
- Global Reader

## Examples

### Example 1: Get the OAuth2 permission grants

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaOAuth2PermissionGrant
```

```Output
Id                              ClientId                             ConsentType   ExpiryTime          PrincipalId                          ResourceId                            Scope
--                              --------                             -----------   ----------          -----------                          ----------                            -----
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u  00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals 1/3/2024 1:28:59 PM                                      a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  User.ReadBasic.All
C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w  00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals 1/3/2024 1:28:59 PM                                      b1b1b1b1-cccc-dddd-eeee-f2f2f2f2f2f2  User.Read
E3fH4iJ5kL6mN7oP8qR9sT0uV1wX2y  22223333-cccc-4444-dddd-5555eeee6666 Principal     1/3/2024 1:28:59 PM aaaaaaaa-bbbb-cccc-1111-222222222222 c2c2c2c2-dddd-eeee-ffff-a3a3a3a3a3a3  User.Read
H4iJ5kL6mN7oP8qR9sT0uV1wX2yZ3a  22223333-cccc-4444-dddd-5555eeee6666 Principal     1/3/2024 1:28:59 PM aaaaaaaa-bbbb-cccc-1111-222222222222 d3d3d3d3-eeee-ffff-aaaa-b4b4b4b4b4b4  ActivityFeed.Read ServiceHealth.Read
```

This command gets the OAuth2 permission grants.

### Example 2: Get all the OAuth2 permission grants

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaOAuth2PermissionGrant -All 
```

```Output
Id                              ClientId                             ConsentType   ExpiryTime          PrincipalId                          ResourceId                            Scope
--                              --------                             -----------   ----------          -----------                          ----------                            -----
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u  00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals 1/3/2024 1:28:59 PM                                      a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  User.ReadBasic.All
C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w  00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals 1/3/2024 1:28:59 PM                                      b1b1b1b1-cccc-dddd-eeee-f2f2f2f2f2f2  User.Read
E3fH4iJ5kL6mN7oP8qR9sT0uV1wX2y  22223333-cccc-4444-dddd-5555eeee6666 Principal     1/3/2024 1:28:59 PM aaaaaaaa-bbbb-cccc-1111-222222222222 c2c2c2c2-dddd-eeee-ffff-a3a3a3a3a3a3  User.Read
H4iJ5kL6mN7oP8qR9sT0uV1wX2yZ3a  22223333-cccc-4444-dddd-5555eeee6666 Principal     1/3/2024 1:28:59 PM aaaaaaaa-bbbb-cccc-1111-222222222222 d3d3d3d3-eeee-ffff-aaaa-b4b4b4b4b4b4  ActivityFeed.Read ServiceHealth.Read
```

This command gets all the OAuth2 permission grants.

### Example 3: Get OAuth2 permission grants for a user in a service principal

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$user = Get-EntraBetaUser -UserId 'SawyerM@contoso.com'
$servicePrincipal = Get-EntraBetaServicePrincipal -Filter "DisplayName eq 'Helpdesk Application'"
Get-EntraBetaOAuth2PermissionGrant | Where-Object {$_.ClientId -eq $servicePrincipal.Id -and $_.PrincipalId -eq $user.Id} | Format-List
```

```Output
ObjectId             : E3fH4iJ5kL6mN7oP8qR9sT0uV1wX2
ClientId             : 22223333-cccc-4444-dddd-5555eeee6666
ConsentType          : Principal
Id                   : E3fH4iJ5kL6mN7oP8qR9sT0uV1wX2
PrincipalId          : aaaaaaaa-bbbb-cccc-1111-222222222222
ResourceId           : c2c2c2c2-dddd-eeee-ffff-a3a3a3a3a3a3
Scope                :  User.Read.All openid profile offline_access Organization.Read.All User.ReadWrite.All Device.Read.All Device.ReadWrite.All Directory.Read.All User.Read RoleManagement.ReadWrite.Directory Group.ReadWrite.All
AdditionalProperties : {}
```

This example gets the OAuth2 permission grants for a user in a service principal.

### Example 4: Get top 2 OAuth2 permission grants record

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraBetaOAuth2PermissionGrant -Top 2
```

```output
Id                             ClientId                             ConsentType   ExpiryTime           PrincipalId  ResourceId                            Scope
--                             --------                             -----------   ----------           ------------ ----------                            -----
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u 00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals 1/3/2024 1:28:59 PM               a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  User.ReadBasic.All
C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w 00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals 1/3/2024 1:28:59 PM               b1b1b1b1-cccc-dddd-eeee-f2f2f2f2f2f2  User.Read
```

This command gets top 2 OAuth2 permission grants records.

## Parameters

### -All

List all pages.

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
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Property

Specifies properties to be returned

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related links

[Remove-EntraBetaOAuth2PermissionGrant](Remove-EntraBetaOAuth2PermissionGrant.md)
[New-EntraBetaOAuth2PermissionGrant](New-EntraBetaOauth2PermissionGrant.md)
