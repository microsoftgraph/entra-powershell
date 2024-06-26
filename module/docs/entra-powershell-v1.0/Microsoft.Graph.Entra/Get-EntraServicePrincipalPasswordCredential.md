---
Title:  Get-EntraServicePrincipalPasswordCredential.
Description: This article provides details on the  Get-EntraServicePrincipalPasswordCredential Command.

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

# Get-EntraServicePrincipalPasswordCredential

## Synopsis

Get credentials for a service principal.

## Syntax

```powershell
Get-EntraServicePrincipalPasswordCredential 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description

The Get-EntraServicePrincipalPasswordCredential cmdlet gets the password credentials for a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve the password credential of a service principal

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
Get-EntraServicePrincipalPasswordCredential -ObjectId $ServicePrincipalId
```

```output
CustomKeyIdentifier DisplayName EndDateTime         Hint KeyId                                SecretText StartDateTime
------------------- ----------- -----------         ---- -----                                ---------- -------------
                                21/03/2025 08:12:08 333  aaaaaaaa-0b0b-1c1c-2d2d-333333333333            21/03/2024 08:12:08
                                12/12/2024 08:39:07 444  bbbbbbbb-1c1c-2d2d-3e3e-444444444444            12/12/2023 08:39:10
```

The first command gets the ID of a service principal by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md) cmdlet. 
The command stores the ID in the $ServicePrincipalId variable.

The second command gets the password credential of a service principal identified by $ServicePrincipalId.

## Parameters

### -ObjectId

Specifies the ID of the service principal for which to get password credentials.

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

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[New-EntraServicePrincipalPasswordCredential](New-EntraServicePrincipalPasswordCredential.md)

[Remove-EntraServicePrincipalPasswordCredential](Remove-EntraServicePrincipalPasswordCredential.md)
