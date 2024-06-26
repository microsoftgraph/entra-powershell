---
Title: Remove-EntraConditionalAccessPolicy.
Description: This article provides details on the Remove-EntraConditionalAccessPolicy command.

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

# Remove-EntraConditionalAccessPolicy

## Synopsis
Deletes a conditional access policy in Microsoft Entra ID by ID.

## Syntax

```powershell
Remove-EntraConditionalAccessPolicy 
 -PolicyId <String> 
 [<CommonParameters>]
```

## Description
This cmdlet allows an admin to delete a conditional access policy in Microsoft Entra ID by ID.
Conditional access policies are custom rules that define an access scenario.

## Examples

### Example 1: Deletes a conditional access policy in Microsoft Entra ID by PolicyId.
```Powershell
PS C:\> Remove-EntraConditionalAccessPolicy -PolicyId 6b5e999b-0ba8-4186-a106-e0296c1c4358
```

This command deletes a conditional access policy in Microsoft Entra ID.

## Parameters

### -PolicyId
Specifies the policy ID of a conditional access policy in Microsoft Entra ID.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Get-EntraConditionalAccessPolicy](Get-EntraConditionalAccessPolicy.md)

[New-EntraConditionalAccessPolicy](New-EntraConditionalAccessPolicy.md)

[Set-EntraConditionalAccessPolicy](Set-EntraConditionalAccessPolicy.md)

