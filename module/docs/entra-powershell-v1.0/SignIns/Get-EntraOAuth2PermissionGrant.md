---
author: msewaweru
description: This article provides details on the Get-EntraOAuth2PermissionGrant Command.
external help file: Microsoft.Entra.SignIns-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 10/16/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraOAuth2PermissionGrant
schema: 2.0.0
title: Get-EntraOAuth2PermissionGrant
---

# Get-EntraOAuth2PermissionGrant

## Synopsis

Gets OAuth2PermissionGrant entities.

## Syntax

```powershell
Get-EntraOAuth2PermissionGrant
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraOAuth2PermissionGrant` cmdlet gets OAuth2PermissionGrant entities in Microsoft Entra ID.

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
Get-EntraOAuth2PermissionGrant
```

```Output
Id                                       ClientId                             ConsentType       PrincipalId                             ResourceId                            Scope
--                                       --------                             -----------       -----------                             ----------                            -----
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u           00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                             a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  User.ReadBasic.All
C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w           00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                             b1b1b1b1-cccc-dddd-eeee-f2f2f2f2f2f2  User.Read
E3fH4iJ5kL6mN7oP8qR9sT0uV1wX2y           22223333-cccc-4444-dddd-5555eeee6666 Principal         aaaaaaaa-bbbb-cccc-1111-222222222222    c2c2c2c2-dddd-eeee-ffff-a3a3a3a3a3a3  User.Read
H4iJ5kL6mN7oP8qR9sT0uV1wX2yZ3a           22223333-cccc-4444-dddd-5555eeee6666 Principal         aaaaaaaa-bbbb-cccc-1111-222222222222    d3d3d3d3-eeee-ffff-aaaa-b4b4b4b4b4b4  ActivityFeed.Read ServiceHealth.Read
```

This command gets the OAuth2 permission grants.

### Example 2: Get all the OAuth2 permission grants

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
Get-EntraOAuth2PermissionGrant -All
```

```Output
Id                                       ClientId                             ConsentType       PrincipalId                           ResourceId                            Scope
--                                       --------                             -----------       -----------                           ----------                            -----
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u           00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                           a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  User.ReadBasic.All
C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w           00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                           b1b1b1b1-cccc-dddd-eeee-f2f2f2f2f2f2  User.Read
E3fH4iJ5kL6mN7oP8qR9sT0uV1wX2y           22223333-cccc-4444-dddd-5555eeee6666 Principal        aaaaaaaa-bbbb-cccc-1111-222222222222   c2c2c2c2-dddd-eeee-ffff-a3a3a3a3a3a3  User.Read
H4iJ5kL6mN7oP8qR9sT0uV1wX2yZ3a           22223333-cccc-4444-dddd-5555eeee6666 Principal        aaaaaaaa-bbbb-cccc-1111-222222222222   d3d3d3d3-eeee-ffff-aaaa-b4b4b4b4b4b4  ActivityFeed.Read ServiceHealth.Read
```

This command gets all the OAuth2 permission grants.

### Example 3: Get OAuth2 permission grants for a user in a service principal

```powershell
Connect-Entra -Scopes 'Directory.Read.All'
$user = Get-EntraUser -UserId 'SawyerM@contoso.com'
$servicePrincipal = Get-EntraServicePrincipal -Filter "DisplayName eq 'Helpdesk Application'"
Get-EntraOAuth2PermissionGrant | Where-Object {$_.ClientId -eq $servicePrincipal.Id -and $_.PrincipalId -eq $user.Id} | Format-List
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
Get-EntraOAuth2PermissionGrant -Top 2
```

```output
Id                                       ClientId                             ConsentType   PrincipalId                           ResourceId                            Scope
--                                       --------                             -----------   -----------                           ----------                            -----
A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u           00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                       a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1  User.ReadBasic.All
C2dE3fH4iJ5kL6mN7oP8qR9sT0uV1w           00001111-aaaa-2222-bbbb-3333cccc4444 AllPrincipals                                       b1b1b1b1-cccc-dddd-eeee-f2f2f2f2f2f2  User.Read
```

This command retrieves the top 2 OAuth2 permission grant records. You can use `-Limit` as an alias for `-Top`.

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
Aliases: Limit

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
Aliases: Select

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

[Remove-EntraOAuth2PermissionGrant](Remove-EntraOAuth2PermissionGrant.md)

[New-EntraOAuth2PermissionGrant](New-EntraOauth2PermissionGrant.md)

[Update-EntraOAuth2PermissionGrant](Update-EntraOauth2PermissionGrant.md)
