---
Title: Get-CrossCloudVerificationCode
Description: This article provides details on the Get-CrossCloudVerificationCode command.

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

# Get-CrossCloudVerificationCode

## Synopsis
Gets the verification code used to validate the ownership of the domain in another connected cloud.
Important: Only applies to a verified domain.

## Syntax

```powershell
Get-CrossCloudVerificationCode 
 -Name <String> 
 [<CommonParameters>]
```

## Description

## Examples

### Example 1: Get the cross cloud verification code
```powershell
PS C:\>Get-CrossCloudVerificationCode -Name Contoso.com
```

This command returns a string that can be used to enable cross cloud federation scenarios.

## Parameters

### -Name
Specifies the name of a domain.

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

### Microsoft.Online.Administration.GetCrossCloudVerificationCodeResponse
## Notes

## Related Links