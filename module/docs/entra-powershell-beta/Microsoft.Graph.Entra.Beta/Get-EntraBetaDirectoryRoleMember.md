---
Title: Get-EntraBetaDirectoryRoleMember
Description: This article provides details on the Get-EntraBetaDirectoryRoleMember command.

Ms.service: active-directory
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG

External help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
Online version:
Schema: 2.0.0
---

# Get-EntraBetaDirectoryRoleMember

## Synopsis
Gets members of a directory role.

## Syntax

```powershell
Get-EntraBetaDirectoryRoleMember 
    -ObjectId <String> 
 [<CommonParameters>]
```

## Description
The **Get-EntraBetaDirectoryRoleMember** cmdlet gets the members of a directory role in Microsoft Entra ID.

## Examples

### Example 1: Get members by role ID
```powershell
PS C:\>Get-EntraBetaDirectoryRoleMember -ObjectId "019ea7a2-1613-47c9-81cb-20ba35b1ae48"
```

```output
ObjectId                             ObjectType
--------                             ----------
Ba6752c4-6a2e-4be5-a23d-67d8d5980796 User
Df19e8e6-2ad7-453e-87f5-037f6529ae16 User
C13dd34a-492b-4561-b171-40fcce2916c5 User
0558a23b-438a-48aa-8e30-5042e0746f69 User
1fbae2b2-bb4b-48f9-bb38-83e9e1ad4bff User
```

This command gets the members of the specified role.

## Parameters

### -ObjectId
Specifies the ID of a directory role in Microsoft Entra ID.

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

[Add-EntraBetaDirectoryRoleMember](Add-EntraBetaDirectoryRoleMember.md)

[Remove-EntraBetaDirectoryRoleMember](Remove-EntraBetaDirectoryRoleMember.md)

