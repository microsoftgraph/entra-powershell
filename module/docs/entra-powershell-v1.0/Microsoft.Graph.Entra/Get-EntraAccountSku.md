---
title: Get-EntraAccountSku
description: This article provides details on the Get-EntraAccountSku command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/28/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraAccountSku

## SYNOPSIS
Retrieves all the SKUs for a company.

## SYNTAX

### GetQuery (Default)
```powershell
Get-EntraAccountSku 
    [<CommonParameters>]
```

### GetById
```powershell
Get-EntraAccountSku 
    [-TenantId <Guid>] 
    [<CommonParameters>]
```

## DESCRIPTION
The **Get-EntraAccountSku** returns all the SKUs that the company owns.

## EXAMPLES

### EXAMPLE 1: Gets a list of SKUs
```powershell
PS C:\> Get-EntraAccountSku
```

```output
Id                                            AccountId                            AccountName   AppliesTo
--                                            ---------                            -----------   -------
95d4390e_b05e124f-c7cc-45a0-a6aa-8cf78c946968 d5aec55f-2d12-4442-8d2f-ccca95d4390e M365x99297270 User
95d4390e_c7df2760-2c81-4ef7-b578-5b5392b571df d5aec55f-2d12-4442-8d2f-ccca95d4390e M365x99297270 User
95d4390e_6fd2c87f-b296-42f0-b197-1e91e994b900 d5aec55f-2d12-4442-8d2f-ccca95d4390e M365x99297270 User
```

This command returns a list of SKUs.

### EXAMPLE 2: Gets a list of SKUs by TenantId
```powershell
PS C:\> Get-EntraAccountSku -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
```

```output
Id                                            AccountId                            AccountName   AppliesTo
--                                            ---------                            -----------   -------
95d4390e_b05e124f-c7cc-45a0-a6aa-8cf78c946968 d5aec55f-2d12-4442-8d2f-ccca95d4390e M365x99297270 User
95d4390e_c7df2760-2c81-4ef7-b578-5b5392b571df d5aec55f-2d12-4442-8d2f-ccca95d4390e M365x99297270 User
95d4390e_6fd2c87f-b296-42f0-b197-1e91e994b900 d5aec55f-2d12-4442-8d2f-ccca95d4390e M365x99297270 User
```

This command returns a list of SKUs by TenantId.

## PARAMETERS

### -TenantId
The unique ID of the tenant to perform the operation on.
If this isn't provided then the value defaults to
the tenant of the current user.
This parameter is only applicable to partner users.

```yaml
Type: Guid
Parameter Sets: GetById
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
