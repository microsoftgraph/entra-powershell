---
description: This article provides details on the Get-EntraBetaContactMembership command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 08/14/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaContactMembership
schema: 2.0.0
title: Get-EntraBetaContactMembership
---

# Get-EntraBetaContactMembership

## SYNOPSIS

Get a contact membership.

## SYNTAX

```powershell
Get-EntraBetaContactMembership
 -OrgContactId <String>
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaContactMembership` cmdlet gets a contact membership in Microsoft Entra ID.

This command is useful to administrators who need to understand which groups, roles, or administrative units a particular contact belongs to. This can be important for troubleshooting access issues, auditing memberships, and ensuring that contact memberships are correctly configured.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the necessary permissions. The following least privileged roles can be used:

- Directory Readers
- Global Reader
- Directory Writers
- Intune Administrator
- User Administrator

## EXAMPLES

### Example 1: Get the memberships of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$contact = Get-EntraBetaContact -Filter "displayName eq 'Contoso Contact'"
Get-EntrabetaContactMembership -OrgContactId $contact.Id |
Select-Object Id, DisplayName, '@odata.type', SecurityEnabled | Format-Table -AutoSize
```

```Output
Id                                   displayName   @odata.type            securityEnabled
--                                   -----------   -----------            ---------------
ffffffff-5555-6666-7777-aaaaaaaaaaaa All Employees #microsoft.graph.group           False
```

This command gets all the memberships for specified contact.

### Example 2: Get all memberships of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$contact = Get-EntraBetaContact -Filter "displayName eq 'Contoso Contact'"
Get-EntraBetaContactMembership -OrgContactId $contact.Id -All |
Select-Object Id, DisplayName, '@odata.type', SecurityEnabled | Format-Table -AutoSize
```

```Output
Id                                   displayName   @odata.type            securityEnabled
--                                   -----------   -----------            ---------------
ffffffff-5555-6666-7777-aaaaaaaaaaaa All Employees #microsoft.graph.group           False
```

This command gets all the memberships for specified contact.

### Example 3: Get top two memberships of a contact

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$contact = Get-EntraBetaContact -Filter "displayName eq 'Contoso Contact'"
Get-EntraBetaContactMembership -OrgContactId $contact.Id -Top 2 |
Select-Object Id, DisplayName, '@odata.type', SecurityEnabled | Format-Table -AutoSize
```

```Output
Id                                   displayName   @odata.type            securityEnabled
--                                   -----------   -----------            ---------------
ffffffff-5555-6666-7777-aaaaaaaaaaaa All Employees #microsoft.graph.group           False
```

This command gets top two memberships for specified contact. You can use `-Limit` as an alias for `-Top`.

## PARAMETERS

### -All

List all pages.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -OrgContactId

Specifies the ID of a contact in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: ObjectId

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top

Specifies the maximum number of records to return.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: Limit

Required: False
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

## OUTPUTS

## NOTES

## RELATED LINKS

[Get-EntraBetaContact](Get-EntraBetaContact.md)
