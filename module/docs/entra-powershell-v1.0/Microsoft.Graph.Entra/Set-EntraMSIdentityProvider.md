---
title: Set-EntraMSIdentityProvider
description: This article provides details on the Set-EntraMSIdentityProvider command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/25/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraMSIdentityProvider

## SYNOPSIS
This cmdlet is used to update the properties of an existing identity provider configured in the directory.

## SYNTAX

```powershell
Set-EntraMSIdentityProvider 
    -Id <String> 
    [-Type <String>] 
    [-ClientSecret <String>] 
    [-ClientId <String>]
    [-Name <String>] 
    [<CommonParameters>]
```

## DESCRIPTION
This cmdlet can be used to update the properties of an existing identity provider.
The type of the identity provider can't be modified.

## EXAMPLES

### Example 1: Update client id of an identity provider
```powershell
PS C:\> Set-EntraMSIdentityProvider -Id LinkedIn-OAUTH -ClientId NewClientId
```

This example updates the client ID for the specified identity provider.

### Example 2: Update client secret of an identity provider
```powershell
PS C:\> Set-EntraMSIdentityProvider -Id LinkedIn-OAUTH -ClientSecret NewClientSecret
```

This example updates the client secret for the specified identity provider.

### Example 3: Update display name of an identity provider
```powershell
PS C:\> Set-EntraMSIdentityProvider -Id LinkedIn-OAUTH -Name NewName
```

This example updates the display name for the specified identity provider.

## PARAMETERS

### -ClientId
The client ID for the application.
This is the client ID obtained when registering the application with the identity provider.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientSecret
The client secret for the application.
This is the client secret obtained when registering the application with the identity provider.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The unique identifier for an identity provider.

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

### -Name
The display name of the identity provider.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
The identity provider type. It must be one of the following values: Microsoft, Google, Facebook, Amazon, or LinkedIn.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
