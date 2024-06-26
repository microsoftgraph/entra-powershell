---
Title: Add-EntraApplicationOwner
Description: This article provides details on the Add-EntraApplicationOwner command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG

External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Add-EntraApplicationOwner

## Synopsis

Adds an owner to an application.

## Syntax

```powershell
Add-EntraApplicationOwner 
 -ObjectId <String> 
 -RefObjectId <String>
 [<CommonParameters>]
```

## Description

The `Add-EntraApplicationOwner` cmdlet Adds an owner to a Microsoft Entra ID application.

## Examples

### Example 1: Add a user as an owner to an application

```powershell
Connect-Entra -Scopes 'Application.ReadWrite.All'
$ApplicationId = (Get-EntraApplication -Top 1).ObjectId
$UserObjectId = (Get-EntraUser -Top 1).ObjectId
Add-EntraApplicationOwner -ObjectId $ApplicationId -RefObjectId $UserObjectId
```

- The first command gets an application using [Get-EntraApplication](./Get-EntraApplication.md) cmdlet, and stores the ObjectId property value in $ApplicationId variable.  

- The second command gets a user using [Get-EntraUser](./Get-EntraUser.md) cmdlet, and stores the ObjectId property value in $UserObjectId variable.  

- This final command Adds an owner in $UserObjectId to an application in $ApplicationId.

This command Adds an owner to an application.

## Parameters

### -ObjectId

Specifies the ID of an application in Microsoft Entra ID.

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

### -RefObjectId

Specifies the ID of the Active Directory object to assign as owner/manager/member.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraApplicationOwner](Get-EntraApplicationOwner.md)

[Remove-EntraApplicationOwner](Remove-EntraApplicationOwner.md)
