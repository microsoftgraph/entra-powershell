---
Title: Remove-EntraServicePrincipalDelegatedPermissionClassification.
Description: This article provides details on the Remove-EntraServicePrincipalDelegatedPermissionClassification command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG
Author: msewaweru
External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Remove-EntraServicePrincipalDelegatedPermissionClassification

## Synopsis

Remove delegated permission classification.

## Syntax

```powershell
Remove-EntraServicePrincipalDelegatedPermissionClassification 
 -ServicePrincipalId <String>
 -Id <String>
 [<CommonParameters>]
```

## Description

The Remove-EntraServicePrincipalDelegatedPermissionClassification cmdlet deletes the given delegated permission classification by ID from service principal.

## Examples

### Example 1: Remove a delegated permission classification

```powershell
Connect-Entra -Scopes 'Policy.ReadWrite.PermissionGrant'
Remove-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId '11112222-bbbb-3333-cccc-4444dddd5555' -Id '3cccccc3-4dd4-5ee5-6ff6-7aaaaaaaaaa7'
```

This command deletes the delegated permission classification by ID from the service principal.

## Parameters

### -ServicePrincipalId

The unique identifier of a service principal object in Microsoft Entra ID.

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

### -Id

The unique identifier of a delegated permission classification object ID.

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

[Get-EntraServicePrincipalDelegatedPermissionClassification](Get-EntraServicePrincipalDelegatedPermissionClassification.md)

[Add-EntraServicePrincipalDelegatedPermissionClassification](Add-EntraServicePrincipalDelegatedPermissionClassification.md)
