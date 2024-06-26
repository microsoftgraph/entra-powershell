---
Title: Get-EntraDirectoryRoleMember.
Description: This article provides details on the Get-EntraDirectoryRoleMember command.

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

# Get-EntraDirectoryRoleMember

## Synopsis

Gets members of a directory role.

## Syntax

```powershell
Get-EntraDirectoryRoleMember 
 -ObjectId <String> 
 [<CommonParameters>]
```

## Description

The `Get-EntraDirectoryRoleMember` cmdlet gets the members of a directory role in Microsoft Entra ID.

## Examples

### Example 1: Get members by role ID

```powershell
Connect-Entra -Scopes 'RoleManagement.Read.Directory'
Get-EntraDirectoryRoleMember -ObjectId '1d73e796-aac5-4b3a-b7e7-74a3d1926a85'
```

```Output
AgeGroup                        :
OnPremisesLastSyncDateTime      :
CreationType                    :
ImAddresses                     : {admin@contoso.onmicrosoft.com}
PreferredLanguage               : en
Mail                            : admin@contoso.onmicrosoft.com
SecurityIdentifier              : A-1-22-3-4444444444-5555555555-6666666-7777777777
Identities                      : {@{signInType=userPrincipalName; issuer=contoso.onmicrosoft.com; issuerAssignedId=admin@contoso.onmicrosoft.com}}
```

This command demonstrates how to get the members of the specified role.

## Parameters

### -ObjectId

Specifies the ID of a directory role in Microsoft Entra ID.

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

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[Add-EntraDirectoryRoleMember](Add-EntraDirectoryRoleMember.md)

[Remove-EntraDirectoryRoleMember](Remove-EntraDirectoryRoleMember.md)
