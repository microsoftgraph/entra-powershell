---
title: Get-EntraUserAppRoleAssignment
description: This article provides details on the Get-EntraUserAppRoleAssignment command.


ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: mwongerapk
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Graph.Entra/Get-EntraUserAppRoleAssignment

schema: 2.0.0
---

# Get-EntraUserAppRoleAssignment

## Synopsis

Get a user application role assignment.

## Syntax

```powershell
Get-EntraUserAppRoleAssignment
 -ObjectId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraUserAppRoleAssignment` cmdlet gets a user application role assignment.

## Examples

### Example 1: Get a user application role assignment

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All','Directory.Read.All'
$UserId = (Get-EntraUser -Top 1).ObjectId
Get-EntraUserAppRoleAssignment -ObjectId $UserId
```

```Output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName   PrincipalId                          PrincipalType ResourceDisplayName
--------------- --                                          ---------                            ---------------     --------------------   -----------                          ------------- -------------------
                0ekrQWAUYUCO7cyiA_A1bC2dE3fH4i             00001111-aaaa-2222-bbbb-3333cccc4444 31-07-2023 04:29:57 Avery Smith            aaaaaaaa-bbbb-cccc-1111-222222222222 User          Test-App-1
                0ekrQWAUYUCO7cyiA_C2dE3fH4iJ5k             11112222-bbbb-3333-cccc-4444dddd5555 12-07-2023 10:09:17 Avery Smith            aaaaaaaa-bbbb-cccc-1111-222222222222 User          Test-App-2
                0ekrQWAUYUCO7cyiA_H4iJ5kL6mN7o             22223333-cccc-4444-dddd-5555eeee6666 13-09-2023 16:41:53 Avery Smith            aaaaaaaa-bbbb-cccc-1111-222222222222 User          Test-App-5
                0ekrQWAUYUCO7cyiA_J5kL6mN7oP8q             33334444-dddd-5555-eeee-6666ffff7777 13-09-2023 17:28:17 Avery Smith            aaaaaaaa-bbbb-cccc-1111-222222222222 User          Test-App-7

```

This example retrieves a user application role assignment for the user in $UserId. You can use the command `Get-EntraUser` to get Service principal Object ID.

- `-ObjectId` parameter specifies the object ID of a user(as a UserPrincipalName or ObjectId).

### Example 2: Get all application role assignments

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All','Directory.Read.All'
Get-EntraUserAppRoleAssignment -ObjectId 'aaaaaaaa-bbbb-cccc-1111-222222222222' -All 
```

```Output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName   PrincipalId                          PrincipalType ResourceDisplayName
--------------- --                                          ---------                            ---------------     --------------------   -----------                          ------------- -------------------
                0ekrQWAUYUCO7cyiA_A1bC2dE3fH4i             00001111-aaaa-2222-bbbb-3333cccc4444 31-07-2023 04:29:57 Avery Smith            aaaaaaaa-bbbb-cccc-1111-222222222222 User          Test-App-1
                0ekrQWAUYUCO7cyiA_C2dE3fH4iJ5k             11112222-bbbb-3333-cccc-4444dddd5555 12-07-2023 10:09:17 Avery Smith            aaaaaaaa-bbbb-cccc-1111-222222222222 User          Test-App-2 
                0ekrQWAUYUCO7cyiA_H4iJ5kL6mN7o             22223333-cccc-4444-dddd-5555eeee6666 13-09-2023 16:41:53 Avery Smith            aaaaaaaa-bbbb-cccc-1111-222222222222 User          Test-App-5
                0ekrQWAUYUCO7cyiA_J5kL6mN7oP8q             33334444-dddd-5555-eeee-6666ffff7777 13-09-2023 17:28:17 Avery Smith            aaaaaaaa-bbbb-cccc-1111-222222222222 User          Test-App-7
```

This example demonstrates how to retrieve all application role assignment for the specified user.

- `-ObjectId` parameter specifies the object ID of a user(as a UserPrincipalName or ObjectId).

### Example 3: Get top two application role assignments

```powershell
Connect-Entra -Scopes 'AppRoleAssignment.ReadWrite.All','Directory.Read.All'
Get-EntraUserAppRoleAssignment -ObjectId 'aaaaaaaa-bbbb-cccc-1111-222222222222' -Top 2
```

```Output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName   PrincipalId                          PrincipalType ResourceDisplayName
--------------- --                                          ---------                            ---------------     --------------------   -----------                          ------------- -------------------
                0ekrQWAUYUCO7cyiA_A1bC2dE3fH4i             00001111-aaaa-2222-bbbb-3333cccc4444 31-07-2023 04:29:57 Avery Smith            aaaaaaaa-bbbb-cccc-1111-222222222222 User          Test-App-1
                0ekrQWAUYUCO7cyiA_C2dE3fH4iJ5k             11112222-bbbb-3333-cccc-4444dddd5555 12-07-2023 10:09:17 Avery Smith            aaaaaaaa-bbbb-cccc-1111-222222222222 User          Test-App-2 
```

This example demonstrates how to retrieve top two application role assignment for the specified user.

- `-ObjectId` parameter specifies the object ID of a user(as a UserPrincipalName or ObjectId).

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

### -ObjectId

Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

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
Aliases:

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

## Related Links

[Get-EntraUser](Get-EntraUser.md)

[New-EntraUserAppRoleAssignment](New-EntraUserAppRoleAssignment.md)

[Remove-EntraUserAppRoleAssignment](Remove-EntraUserAppRoleAssignment.md)
