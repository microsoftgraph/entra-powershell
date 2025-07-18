---
author: msewaweru
description: This article provides details on the Get-EntraBetaUserAppRoleAssignment command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/25/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaUserAppRoleAssignment
schema: 2.0.0
title: Get-EntraBetaUserAppRoleAssignment
---

# Get-EntraBetaUserAppRoleAssignment

## SYNOPSIS

Get a user application role assignment.

## SYNTAX

```powershell
Get-EntraBetaUserAppRoleAssignment
 -UserId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaUserAppRoleAssignment` cmdlet gets a user application role assignment.

To perform this operation in delegated scenarios using work or school accounts, the signed-in user must have one of the following least privileged roles, or a custom role with the necessary permissions:

- Guest Inviter - Read app role assignments for users only
- Directory Readers
- Directory Synchronization Accounts - for Microsoft Entra Connect and Microsoft Entra Cloud Sync services
- Directory Writer
- Hybrid Identity Administrator
- Identity Governance Administrator
- Privileged Role Administrator
- User Administrator
- Application Administrator
- Cloud Application Administrator

## EXAMPLES

### Example 1: Get a user application role assignment

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All', 'Directory.Read.All'
Get-EntraBetaUserAppRoleAssignment -UserId 'SawyerM@contoso.com'
```

```Output
DeletedDateTime   Id                                        AppRoleId                              CreatedDateTime       PrincipalDisplayName  PrincipalId                          PrincipalType  ResourceDisplayName
---------------   --                                        ---------                              ---------------       --------------------  -----------                          -------------  -------------------
                  0ekrQWAUYUCO7cyiA_A1bC2dE3fH4i            00001111-aaaa-2222-bbbb-3333cccc4444  31-07-2023 04:29:57  Sawyer Miller         aaaaaaaa-bbbb-cccc-1111-222222222222 User           Test-App-1
                  0ekrQWAUYUCO7cyiA_C2dE3fH4iJ5k            11112222-bbbb-3333-cccc-4444dddd5555  12-07-2023 10:09:17  Sawyer Miller         aaaaaaaa-bbbb-cccc-1111-222222222222 User           Test-App-2
                  0ekrQWAUYUCO7cyiA_H4iJ5kL6mN7o            22223333-cccc-4444-dddd-5555eeee6666  13-09-2023 16:41:53  Sawyer Miller         aaaaaaaa-bbbb-cccc-1111-222222222222 User           Test-App-5
                  0ekrQWAUYUCO7cyiA_J5kL6mN7oP8q            33334444-dddd-5555-eeee-6666ffff7777  13-09-2023 17:28:17  Sawyer Miller         aaaaaaaa-bbbb-cccc-1111-222222222222 User           Test-App-7
```

This example retrieves a user application role assignment for the user in $UserId. You can use the comand `Get-EntraBetaUser` to get Service principal Object ID.

- `-UserId` parameter specifies the object Id of a user(as a UserPrincipalName or ObjectId).

### Example 2: Get all application role assignments

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All', 'Directory.Read.All'
Get-EntraBetaUserAppRoleAssignment -UserId 'SawyerM@contoso.com' -All
```

```Output
DeletedDateTime   Id                                        AppRoleId                              CreatedDateTime       PrincipalDisplayName  PrincipalId                          PrincipalType  ResourceDisplayName
---------------   --                                        ---------                              ---------------       --------------------  -----------                          -------------  -------------------
                  0ekrQWAUYUCO7cyiA_A1bC2dE3fH4i            00001111-aaaa-2222-bbbb-3333cccc4444  31-07-2023 04:29:57  Sawyer Miller         aaaaaaaa-bbbb-cccc-1111-222222222222 User           Test-App-1
                  0ekrQWAUYUCO7cyiA_C2dE3fH4iJ5k            11112222-bbbb-3333-cccc-4444dddd5555  12-07-2023 10:09:17  Sawyer Miller         aaaaaaaa-bbbb-cccc-1111-222222222222 User           Test-App-2
                  0ekrQWAUYUCO7cyiA_H4iJ5kL6mN7o            22223333-cccc-4444-dddd-5555eeee6666  13-09-2023 16:41:53  Sawyer Miller         aaaaaaaa-bbbb-cccc-1111-222222222222 User           Test-App-5
                  0ekrQWAUYUCO7cyiA_J5kL6mN7oP8q            33334444-dddd-5555-eeee-6666ffff7777  13-09-2023 17:28:17  Sawyer Miller         aaaaaaaa-bbbb-cccc-1111-222222222222 User           Test-App-7
```

This example demonstrates how to retrieve all application role assignment for the specified user.

- `-UserId` parameter specifies the object Id of a user(as a UserPrincipalName or ObjectId).

### Example 3: Get top two application role assignments

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All', 'Directory.Read.All'
Get-EntraBetaUserAppRoleAssignment -UserId 'SawyerM@contoso.com' -Top 2
```

```Output
DeletedDateTime   Id                                        AppRoleId                              CreatedDateTime       PrincipalDisplayName  PrincipalId                          PrincipalType  ResourceDisplayName
---------------   --                                        ---------                              ---------------       --------------------  -----------                          -------------  -------------------
                  0ekrQWAUYUCO7cyiA_A1bC2dE3fH4i            00001111-aaaa-2222-bbbb-3333cccc4444  31-07-2023 04:29:57  Sawyer Miller         aaaaaaaa-bbbb-cccc-1111-222222222222 User           Test-App-1
                  0ekrQWAUYUCO7cyiA_C2dE3fH4iJ5k            11112222-bbbb-3333-cccc-4444dddd5555  12-07-2023 10:09:17  Sawyer Miller         aaaaaaaa-bbbb-cccc-1111-222222222222 User           Test-App-2
```

This example demonstrates how to retrieve top two application role assignment for the specified user. You can use `-Limit` as an alias for `-Top`.

- `-UserId` parameter specifies the object Id of a user(as a UserPrincipalName or ObjectId).

### Example 4: Get application role assignments with selected properties

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All', 'Directory.Read.All'
Get-EntraBetaUserAppRoleAssignment -UserId 'SawyerM@contoso.com' -Property Id, 
    CreatedDateTime, PrincipalDisplayName, PrincipalType | 
    Select-Object Id, CreatedDateTime, PrincipalDisplayName, PrincipalType
```

```Output
Id                                          CreatedDateTime        PrincipalDisplayName  PrincipalType
--                                          ----------------        -------------------- --------------
0ekrQWAUYUCO7cyiA_A1bC2dE3fH4i              7/30/2024 5:59:16 PM    Sawyer Miller         User
0ekrQWAUYUCO7cyiA_C2dE3fH4iJ5k              9/19/2024 7:13:24 AM    Contoso IT Support    Group
```

This example demonstrates how to retrieve application role assignments for the specified user with selected properties.

- `-UserId` parameter specifies the object ID of a user(as a UserPrincipalName or ObjectId).

## PARAMETERS

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

### -UserId

Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId, UPN, Identity, UserPrincipalName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

Specifies properties to be returned.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaUser](Get-EntraBetaUser.md)

[New-EntraBetaUserAppRoleAssignment](New-EntraBetaUserAppRoleAssignment.md)

[Remove-EntraBetaUserAppRoleAssignment](Remove-EntraBetaUserAppRoleAssignment.md)
