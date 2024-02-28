---
title: Get-EntraServiceAppRoleAssignedTo.
description: This article provides details on the Get-EntraServiceAppRoleAssignedTo command.

ms.service: active-directory
ms.topic: reference
ms.date: 11/10/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraServiceAppRoleAssignedTo

## SYNOPSIS
Gets app role assignments for this app or service, granted to users, groups and other service principals.

## SYNTAX

```
Get-EntraServiceAppRoleAssignedTo 
 -ObjectId <String>
 [-All <Boolean>]
 [-Top <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraServiceAppRoleAssignedTo cmdlet gets app role assignments for this app or service, granted to users, groups and other service principals.

## EXAMPLES

### Example 1: Retrieve the app role assignments
```
PS C:\> $ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
PS C:\> Get-EntraServiceAppRoleAssignedTo -ObjectId $ServicePrincipalId
```

The first command gets the ID of a service principal and stores it in the $ServicePrincipalId variable.

The second command gets the app role assignments for the service principal granted to users, groups and other service principals.

### Example 2: Get all app role assignments
```
PS C:\> Get-EntraServiceAppRoleAssignedTo -ObjectId 4d8fcb23-adc7-4d47-9328-2420eb1075ef -All $true
```

This command gets the all app role assignments for the service principal granted to users, groups and other service principals.

### Example 3: Get five app role assignments
```
PS C:\> Get-EntraServiceAppRoleAssignedTo -ObjectId 4d8fcb23-adc7-4d47-9328-2420eb1075ef -Top 5

DeletedDateTime Id                                          AppRoleId                            CreatedDateTime     PrincipalDisplayName PrincipalId                          PrincipalType    ResourceDisplayNam
                                                                                                                                                                                                e
--------------- --                                          ---------                            ---------------     -------------------- -----------                          -------------    ------------------
                I8uPTcetR02TKCQg6xB170ZWgaqJluBEqPHHxTxJ9Hs bdd80a03-d9bc-451d-b7c4-ce7c63fe3c8f 20-10-2023 17:03:41 Entra-App-Testing    4d8fcb23-adc7-4d47-9328-2420eb1075ef ServicePrincipal Microsoft Graph
                I8uPTcetR02TKCQg6xB175qAouG5TkBJnqyyYfnVJ7A 660b7406-55f1-41ca-a0ed-0b035e182f3e 20-10-2023 17:03:38 Entra-App-Testing    4d8fcb23-adc7-4d47-9328-2420eb1075ef ServicePrincipal Microsoft Graph
                I8uPTcetR02TKCQg6xB178ILFS4OdQlAmENpzFgzWRI 7e847308-e030-4183-9899-5235d7270f58 20-10-2023 17:03:37 Entra-App-Testing    4d8fcb23-adc7-4d47-9328-2420eb1075ef ServicePrincipal Microsoft Graph
                I8uPTcetR02TKCQg6xB17zfLIsSkkbtLlvBmfKY1ljk ba1ba90b-2d8f-487e-9f16-80728d85bb5c 20-10-2023 17:03:39 Entra-App-Testing    4d8fcb23-adc7-4d47-9328-2420eb1075ef ServicePrincipal Microsoft Graph
                I8uPTcetR02TKCQg6xB173uzLecDD3JNtanhmTsz4PE 9ce09611-f4f7-4abd-a629-a05450422a97 20-10-2023 17:03:39 Entra-App-Testing    4d8fcb23-adc7-4d47-9328-2420eb1075ef ServicePrincipal Microsoft Graph
```

This command gets the five app role assignments for the service principal granted to users, groups and other service principals.

## PARAMETERS

### -All
If true, return all application role assignments.
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
Specifies the ID of a service principal in Microsoft Entra ID.

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

### System.String
System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
