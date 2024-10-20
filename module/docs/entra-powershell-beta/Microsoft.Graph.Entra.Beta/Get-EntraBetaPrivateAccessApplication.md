---
title: Get-EntraBetaPrivateAccessApplication
description: This article provides details on the Get-EntraBetaPrivateAccessApplication command.

ms.topic: reference
ms.date: 10/19/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: andres-canello
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaPrivateAccessApplication

## Synopsis

Retrieves a list of all Private Access applications, or if specified, details of a specific application.

## Description

The `Get-EntraBetaPrivateAccessApplication` cmdlet retrieves a list of all Private Access applications, or if specified, details of a specific application.

## Examples

### Example 1: Retrieve all Private Access applications

```powershell
Connect-Entra -Scopes 'NetworkAccessPolicy.ReadWrite.All', 'Application.ReadWrite.All', 'NetworkAccess.ReadWrite.All'
Get-EntraBetaPrivateAccessApplication
```

```Output
displayName     : testApp1
appId           : b8a10d3c-0000-4d0b-9b31-d24a097a1e02
id              : 8f139194-c876-0000-af51-8aeb7f1fb9d4
tags            : {IsAccessibleViaZTNAClient, HideApp, PrivateAccessNonWebApplication}
createdDateTime : 14/06/2024 12:38:50 AM

displayName     : QuickAccess
appId           : d2d253be-0000-4d93-a5e4-5c0aca66ef5e
id              : a3bdc7a8-e7af-0000-abe7-4f093d2141d8
tags            : {HideApp, NetworkAccessQuickAccessApplication}
createdDateTime : 4/07/2023 4:00:07 AM
```

This command retrieves all Private Access applications, including Quick Access.

### Example 2: Retrieve a specific Private Access application by object id

```powershell
Connect-Entra -Scopes 'NetworkAccessPolicy.ReadWrite.All', 'Application.ReadWrite.All', 'NetworkAccess.ReadWrite.All'

Get-EntraBetaPrivateAccessApplication -ObjectID a3bdc7a8-e7af-0000-abe7-4f093d2141d8
```

```Output
displayName     : QuickAccess
appId           : d2d253be-0000-4d93-a5e4-5c0aca66ef5e
id              : a3bdc7a8-e7af-0000-abe7-4f093d2141d8
tags            : {HideApp, NetworkAccessQuickAccessApplication}
createdDateTime : 4/07/2023 4:00:07 AM
```

This example demonstrates how to retrieve information for a specific Private Access application by object id.

### Example 3: Retrieve a specific Private Access application by name

```powershell
Connect-Entra -Scopes 'NetworkAccessPolicy.ReadWrite.All', 'Application.ReadWrite.All', 'NetworkAccess.ReadWrite.All'

Get-EntraBetaPrivateAccessApplication -ApplicationName testApp1
```

```Output
displayName     : testApp1
appId           : b8a10d3c-0000-4d0b-9b31-d24a097a1e02
id              : 8f139194-c876-0000-af51-8aeb7f1fb9d4
tags            : {IsAccessibleViaZTNAClient, HideApp, PrivateAccessNonWebApplication}
createdDateTime : 14/06/2024 12:38:50 AM
```

This example demonstrates how to retrieve information for a specific Private Access application by application name.

## Parameters

### -ObjectId

The Object ID of a Private Access application object.

```yaml
Type: System.String
Parameter Sets: SingleAppID
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationName

Specifies a specific application name to retrieve.

```yaml
Type: System.String
Parameter Sets: SingleAppName
Aliases:

Required: False
Position: 2, Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

System.Nullable\`1\[\[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

## RELATED LINKS

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)

[Get-EntraBetaPrivateAccessApplicationSegment](Get-EntraBetaPrivateAccessApplicationSegment.md)

[Remove-EntraBetaPrivateAccessApplicationSegment](Remove-EntraBetaPrivateAccessApplicationSegment.md)

[New-EntraBetaPrivateAccessApplicationSegment](New-EntraBetaPrivateAccessApplicationSegment.md)

