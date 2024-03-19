---
title: Get-EntraUserAppRoleAssignment.
description: This article provides details on the Get-EntraUserAppRoleAssignment command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraUserAppRoleAssignment

## SYNOPSIS
Get a user application role assignment.

## SYNTAX

```
Get-EntraUserAppRoleAssignment
-ObjectId <String>
[-All <Boolean>]
[-Top <Int32>]
[<CommonParameters>]
```

## DESCRIPTION
The Get-EntraUserAppRoleAssignment cmdlet gets a user application role assignment.

## EXAMPLES

### Example 1: Get a user application role assignment
```powershell
PS C:\> $UserId = (Get-EntraUser -Top 1).ObjectId
PS C:\> Get-EntraUserAppRoleAssignment -ObjectId $UserId
```
```output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName   PrincipalId                          PrincipalType ResourceDisplayName
--------------- --                                          ---------                            ---------------     --------------------   -----------                          ------------- -------------------
                0ekrQWAUYUCO7cyiA_yyFYFF7ENp2l9Alu5oP9S5INQ 00000000-0000-0000-0000-000000000000 31-07-2023 04:29:57 Adele Vance            412be9d1-1460-4061-8eed-cca203fcb215 User          ProvisioningPowerBi
                0ekrQWAUYUCO7cyiA_yyFYu1Ohj4gzpHldy7n1LzP0s 00000000-0000-0000-0000-000000000000 12-07-2023 10:09:17 Adele Vance            412be9d1-1460-4061-8eed-cca203fcb215 User          Microsoft Graph ...
                0ekrQWAUYUCO7cyiA_yyFcBL1QS_V4RIhml0g8rMT9c edaa71bf-f833-4989-8316-82d11fc811e5 13-09-2023 16:41:53 Adele Vance            412be9d1-1460-4061-8eed-cca203fcb215 User          Test-App-5
                0ekrQWAUYUCO7cyiA_yyFdUpCZMR_e5Cn01fWFA9OUE 7dfd756e-8c27-4472-b2b7-38c17fc5de5e 13-09-2023 17:28:17 Adele Vance            412be9d1-1460-4061-8eed-cca203fcb215 User          Ksh
```

This example demonstrates how to retrieve user application role assignment by providing ID.  
The first command gets the ID of a Microsoft Entra ID user by using the Get-EntraUser (./Get-EntraUser.md) cmdlet. 
The command stores the value in the $UserId variable.  
The second command gets a user application role assignment for the user in $UserId.

### Example 2: Get all application role assignments
```powershell
PS C:\>  Get-EntraUserAppRoleAssignment -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -All $true
```
```output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName   PrincipalId                          PrincipalType ResourceDisplayName
--------------- --                                          ---------                            ---------------     --------------------   -----------                          ------------- -------------------
                0ekrQWAUYUCO7cyiA_yyFYFF7ENp2l9Alu5oP9S5INQ 00000000-0000-0000-0000-000000000000 31-07-2023 04:29:57 Adele Vance            412be9d1-1460-4061-8eed-cca203fcb215 User          ProvisioningPowerBi
                0ekrQWAUYUCO7cyiA_yyFYu1Ohj4gzpHldy7n1LzP0s 00000000-0000-0000-0000-000000000000 12-07-2023 10:09:17 Adele Vance            412be9d1-1460-4061-8eed-cca203fcb215 User          Microsoft Graph ...
                0ekrQWAUYUCO7cyiA_yyFcBL1QS_V4RIhml0g8rMT9c edaa71bf-f833-4989-8316-82d11fc811e5 13-09-2023 16:41:53 Adele Vance            412be9d1-1460-4061-8eed-cca203fcb215 User          Test-App-5
                0ekrQWAUYUCO7cyiA_yyFdUpCZMR_e5Cn01fWFA9OUE 7dfd756e-8c27-4472-b2b7-38c17fc5de5e 13-09-2023 17:28:17 Adele Vance            412be9d1-1460-4061-8eed-cca203fcb215 User          Ksh
                --dP9CxGvUGdNo4754xNX8ixX6_HdZ9FnObn6kjsHk0 4c5b2e45-75e7-4e8c-9292-d30062373387 20-10-2023 16:58:52 Contoso                f44fe7fb-462c-41bd-9d36-8e3be78c4d5f Group         Entra-App-Testing
                f3-c3NaRZ0K4Z2kB0NSIVIiJjUvXRlxJgcXdUFZ_xno 01c2bb8e-0895-42c8-b950-3ec8abc7a012 07-07-2023 15:24:11 sg-Sales and Marketing dc9c7f7f-91d6-4267-b867-6901d0d48854 Group         LinkedIn
```

This example demonstrates how to retrieve all application role assignment for the specified user.   
This command gets user all application role assignment for the specified user.

### Example 3: Get top five application role assignments
```powershell
PS C:\> Get-EntraUserAppRoleAssignment -ObjectId "412be9d1-1460-4061-8eed-cca203fcb215" -Top 5
```
```output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName PrincipalId                          PrincipalType ResourceDisplayName
--------------- --                                          ---------                            ---------------     -------------------- -----------                          ------------- -------------------
                0ekrQWAUYUCO7cyiA_yyFYFF7ENp2l9Alu5oP9S5INQ 00000000-0000-0000-0000-000000000000 31-07-2023 04:29:57 Adele Vance          412be9d1-1460-4061-8eed-cca203fcb215 User          ProvisioningPowerBi
                0ekrQWAUYUCO7cyiA_yyFYu1Ohj4gzpHldy7n1LzP0s 00000000-0000-0000-0000-000000000000 12-07-2023 10:09:17 Adele Vance          412be9d1-1460-4061-8eed-cca203fcb215 User          Microsoft Graph Co...
                0ekrQWAUYUCO7cyiA_yyFcBL1QS_V4RIhml0g8rMT9c edaa71bf-f833-4989-8316-82d11fc811e5 13-09-2023 16:41:53 Adele Vance          412be9d1-1460-4061-8eed-cca203fcb215 User          Test-App-5
                0ekrQWAUYUCO7cyiA_yyFdUpCZMR_e5Cn01fWFA9OUE 7dfd756e-8c27-4472-b2b7-38c17fc5de5e 13-09-2023 17:28:17 Adele Vance          412be9d1-1460-4061-8eed-cca203fcb215 User          Ksh
                --dP9CxGvUGdNo4754xNX8ixX6_HdZ9FnObn6kjsHk0 4c5b2e45-75e7-4e8c-9292-d30062373387 20-10-2023 16:58:52 Contoso              f44fe7fb-462c-41bd-9d36-8e3be78c4d5f Group         Entra-App-Testing
```

This example demonstrates how to retrieve top five application role assignment for the specified user.   
This command gets five user application role assignment for the specified user.

## PARAMETERS

### -All
If true, return all user application role assignments for this user.
If false, return the number of objects specified by the Top parameter.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of a user (as a UserPrincipalName or ObjectId) in Microsoft Entra ID.

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

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
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

[Get-EntraUser](Get-EntraUser.md)

[New-EntraUserAppRoleAssignment](New-EntraUserAppRoleAssignment.md)

[Remove-EntraUserAppRoleAssignment](Remove-EntraUserAppRoleAssignment.md)

