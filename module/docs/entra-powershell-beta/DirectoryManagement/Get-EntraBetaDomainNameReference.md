---
description: This article provides details on the Get-EntraBetaDomainNameReference command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/08/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaDomainNameReference
schema: 2.0.0
title: Get-EntraBetaDomainNameReference
---

# Get-EntraBetaDomainNameReference

## SYNOPSIS

Retrieves the objects that are referenced by a given domain name.

## SYNTAX

```powershell
Get-EntraBetaDomainNameReference
 -Name <String>
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaDomainNameReference` cmdlet retrieves the objects that are referenced with a given domain name. Specify `Name` parameter retrieve the objects.

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- Domain Name Administrator
- Global Reader

## EXAMPLES

### Example 1: Retrieve the domain name reference objects for a domain

```powershell
Connect-Entra -Scopes 'Domain.Read.All'
Get-EntraBetaDomainNameReference -Name contoso.com | Select-Object Id, DisplayName, '@odata.type'
```

```Output
Id                                   displayName              @odata.type               
--                                   -------------             ------------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Sawyer MIller            #microsoft.graph.user     
bbbbbbbb-1111-2222-3333-cccccccccccc Adele Vance              #microsoft.graph.user     
ffffffff-4444-5555-6666-gggggggggggg Contoso marketing        #microsoft.graph.group    
hhhhhhhh-5555-6666-7777-iiiiiiiiiiii Contoso App              #microsoft.graph.application
```

This example shows how to retrieve the domain name reference objects for a domain that is specified through the -Name parameter.

- `-Name` parameter specifies the name of the domain name for which the referenced objects are retrieved.

## PARAMETERS

### -Name

The name of the domain name for which the referenced objects are retrieved.

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

### System.String

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
