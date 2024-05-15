---
title: New-EntraBetaServicePrincipalPasswordCredential
description: This article provides details on the New-EntraBetaServicePrincipalPasswordCredential command.
ms.service: entra
ms.subservice: powershell
ms.topic: reference
ms.date: 04/17/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0

---

# New-EntraBetaServicePrincipalPasswordCredential

## SYNOPSIS
Creates a password credential for a service principal.

## SYNTAX

```powershell
New-EntraBetaServicePrincipalPasswordCredential 
 -ObjectId <String>
 [-EndDate <DateTime>] 
 [-StartDate <DateTime>] 
 [<CommonParameters>]
```

## DESCRIPTION
The New-EntraBetaServicePrincipalPasswordCredential cmdlet creates a password credential for a service principal in Microsoft Entra ID.

## EXAMPLES


### Example 1: Create a password credential with StartDate
```powershell
PS C:\> New-EntraBetaServicePrincipalPasswordCredential -ObjectID "000aa8f0-ccde-4b68-914b-d922971b6192" -StartDate 2024-04-21T14:14:14Z
```
```output
endDateTime         : 17/04/2026 07:39:07
customKeyIdentifier :
@odata.type         : #microsoft.graph.servicePrincipal
displayName         :
keyId               : dfc1703c-c3b6-4036-99b8-4b41627a15a7          : 
@odata.context      : https://graph.microsoft.com/beta/$metadata#servicePrincipals('000aa8f0-ccde-4b68-914b-d922971b6192')/addPassword
hint                : i.W
startDateTime       : 21/04/2024 14:14:14
StartDate           : 21/04/2024 14:14:14
EndDate             : 17/04/2026 07:39:07
```

This example demonstrates how to create a password credential with StartDate for a service principal in Microsoft Entra ID.  


### Example 2: Create a password credential with EndtDate
```powershell
PS C:\> New-EntraBetaServicePrincipalPasswordCredential -ObjectID "021510b7-e753-40aa-b668-29753295ca34" -EndDate 2030-03-21T14:14:14Z
```
```output
endDateTime         : 21/03/2030 14:14:14
customKeyIdentifier :
@odata.type         : #microsoft.graph.servicePrincipal
displayName         :
keyId               : 810633b8-dbca-4af7-a4ea-8d3aa1d45588          : 
@odata.context      : https://graph.microsoft.com/beta/$metadata#servicePrincipals('000aa8f0-ccde-4b68-914b-d922971b6192')/addPassword
hint                : T1Q
startDateTime       : 17/04/2024 07:41:01
StartDate           : 17/04/2024 07:41:01
EndDate             : 21/03/2030 14:14:14
```
This example demonstrates how to create a password credential with EndDate for a service principal in Microsoft Entra ID.       

## PARAMETERS

### -EndDate
The date and time at which the password expires represented using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2024 is 2024-01-01T00:00:00Z.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of the service principal.

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

### -StartDate
The date and time at which the password becomes valid. The Timestamp type represents date and time information using ISO 8601 format and is always in UTC time. For example, midnight UTC on Jan 1, 2024 is 2024-01-01T00:00:00Z.

```yaml
Type: DateTime
Parameter Sets: (All)
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