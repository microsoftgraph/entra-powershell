---
Title: Remove-EntraApplicationPassword.
Description: This article provides details on the Remove-EntraApplicationPassword command.

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

# Remove-EntraApplicationPassword

## Synopsis
Remove a password from an application.

## Syntax

```powershell
Remove-EntraApplicationPassword 
 -ObjectId <String> 
 [-KeyId <String>] 
 [<CommonParameters>]
```

## Description
Remove a password from an application.

## Examples

### Example 1: Removes a password from an application
```powershell
PS C:\>Remove-EntraApplicationPassword -ObjectId 1f88e99f-37a3-468f-80ae-e07b62ed0287 -KeyId 80e561ed-44ed-48dc-8c09-9d4803e26e4c
```

This command remove the specified password from the specified application.  
ObjectId: The ObjectId of the specified application.
KeyID: The unique identifier of the PasswordCredential.  

## Parameters

### -ObjectId
The unique identifier of the object specific Microsoft Entra ID object

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

### -KeyId
The unique identifier for the key.

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

## Inputs

### string
## Outputs

## Notes

## Related Links

[New-EntraApplicationPassword](New-EntraApplicationPassword.md)

