---
title: New-EntraUserAppRoleAssignment.
description: This article provides details on the New-EntraUserAppRoleAssignment command.

ms.service: entra
ms.topic: reference
ms.date: 03/16/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# New-EntraUserAppRoleAssignment

## SYNOPSIS

Assigns a user to an application role.

## SYNTAX

```powershell
New-EntraUserAppRoleAssignment 
 -ObjectId <String> 
 -PrincipalId <String> 
 -Id <String> 
 -ResourceId <String>
 [<CommonParameters>]
```

## DESCRIPTION

The New-EntraUserAppRoleAssignment cmdlet assigns a user to an application role in Microsoft Entra ID.

## EXAMPLES

### Example 1: Assign a user to an application without roles

```powershell
$appId = (Get-EntraApplication -SearchString "uzair_test").AppId
$user = Get-EntraUser -searchstring "snehaltest3"
$servicePrincipal = Get-EntraServicePrincipal -Filter "appId eq '$appId'"
New-EntraUserAppRoleAssignment -ObjectId $user.ObjectId -PrincipalId $user.ObjectId -ResourceId $servicePrincipal.ObjectId -Id ([Guid]::Empty)
```

```output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName PrincipalId                          PrincipalType ResourceDisplayName
--------------- --                                          ---------                            ---------------     -------------------- -----------                          ------------- ------------------- -
                fpynUVNFy0SENMUEI-5uXkS_zNSoJCZGuBbuAQtnVUE 00000000-0000-0000-0000-000000000000 18-06-2024 11:22:40 snehaltest3          aaaaaaaa-bbbb-cccc-1111-222222222222 User          uzair_test 
```

This example demonstrates how to assign a user to an application role in Microsoft Entra ID.  

### Example 2: Assign a user to a specific role within an application

```powershell
$username = "Test4@M365x99297270.onmicrosoft.com"
$appname = "Box"
$spo = Get-EntraServicePrincipal -Filter "Displayname eq '$appname'"
$user = Get-EntraUser -Filter "userPrincipalName eq '$username'"
New-EntraUserAppRoleAssignment -ObjectId $user.ObjectId -PrincipalId $user.ObjectId -ResourceId $spo.ObjectId -Id $spo.Approles[1].id
```

```output
DeletedDateTime Id                                          AppRoleId                            CreatedDateTime       PrincipalDisplayName PrincipalId
--------------- --                                          ---------                            ---------------       -------------------- -----------
                Idn1u1K7S0OWoJWIjkT69SVIUTZVOARFnAExHJFzgRs e18f0405-fdec-4ae8-a8a0-d8edb98b061f 3/12/2024 10:09:07 AM Test One Updated     aaaaaaaa-bbbb-cccc-1111-222222222222
```

This example demonstrates how to assign a user to an application role in Microsoft Entra ID.  
This cmdlet assigns to the specified user the application role of which the Id is specified with $spo.Approles\[1\].id.  
For more information on how to retrieve application roles for an application, see description of the Id parameter.

## PARAMETERS

### -Id

The ID of the app role to assign.
If application doesn't have any roles while creating new app role assignment then provide an empty guid, or the Id of the role to assign to the user.

You can retrieve the application's roles by examining the application object's AppRoles property:

Get-EntraApplication -SearchString "Your Application display name" | select Approles | Fl

This cmdlet returns the list of roles that are defined in an application:

AppRoles: {class AppRole {              AllowedMemberTypes: System.Collections.Generic.List1\[System.String\]              Description: \<description for this role\>              DisplayName: \<display name for this role\>              Id: 97e244a2-6ccd-4312-9de6-ecb21884c9f7              IsEnabled: True              Value: \<Value that is transmitted as a claim in a token for this role\>            }            }

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

### -ObjectId

Specifies the ID of the user (as a User Principal Name or ObjectId) in Microsoft Entra ID to which the new app role is to be assigned.

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

### -PrincipalId

The object ID of the principal to which the new app role is assigned.
When assigning a new role to a user, provide the object ID of the user.

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

### -ResourceId

The object ID of the Service Principal for the application to which the user role is assigned.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraUserAppRoleAssignment](Get-EntraUserAppRoleAssignment.md)

[Remove-EntraUserAppRoleAssignment](Remove-EntraUserAppRoleAssignment.md)
