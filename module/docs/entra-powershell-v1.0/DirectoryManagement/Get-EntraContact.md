---
description: This article provides details on the Get-EntraContact command.
external help file: Microsoft.Entra.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraContact
schema: 2.0.0
title: Get-EntraContact
---

# Get-EntraContact

## SYNOPSIS

Gets a contact from Microsoft Entra ID.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraContact
 [-Filter <String>]
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraContact
 -OrgContactId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraContact` cmdlet gets a contact from Microsoft Entra ID.

For delegated scenarios involving work or school accounts, the signed-in user must have a supported Microsoft Entra role or a custom role with the required permissions. The following least privileged roles support this operation:

- Directory Readers: Read basic properties
- Global Reader
- Directory Writers
- Intune Administrator
- User Administrator

## EXAMPLES

### Example 1: Retrieve all contact objects in the directory

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
Get-EntraContact
```

```Output
DisplayName          Id                                   Mail                         MailNickname
-----------          --                                   ----                         ------------
Contoso Contact     aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb contact@contoso.com         Contoso Contact
Contoso Contact1    bbbbbbbb-1111-2222-3333-cccccccccccc contact1@contoso.com        Contoso Contact 1
Contoso Contact2    cccccccc-2222-3333-4444-dddddddddddd contact2@contoso.com        Contoso Contact 2
Contoso Contact3    dddddddd-3333-4444-5555-eeeeeeeeeeee contact3@contoso.com        Contoso Contact 3
```

This example retrieves all contact objects in the directory.

### Example 2: Retrieve specific contact object in the directory

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
$contact = Get-EntraContact -Filter "displayName eq 'Contoso Contact'"
Get-EntraContact -OrgContactId $contact.Id
```

```Output
DisplayName          Id                                   Mail                         MailNickname
-----------          --                                   ----                         ------------
Contoso Contact     aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb contact@contoso.com         Contoso Contact
```

This example retrieves specified contact in the directory.

- `-OrgContactId` parameter specifies the contact Id.

### Example 3: Retrieve all contacts objects in the directory

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
Get-EntraContact -All
```

```Output
DisplayName          Id                                   Mail                         MailNickname
-----------          --                                   ----                         ------------
Contoso Contact     aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb contact@contoso.com         Contoso Contact
Contoso Contact1    bbbbbbbb-1111-2222-3333-cccccccccccc contact1@contoso.com        Contoso Contact 1
Contoso Contact2    cccccccc-2222-3333-4444-dddddddddddd contact2@contoso.com        Contoso Contact 2
Contoso Contact3    dddddddd-3333-4444-5555-eeeeeeeeeeee contact3@contoso.com        Contoso Contact 3
```

This example retrieves all the contacts in the directory.

### Example 4: Retrieve top two contacts objects in the directory

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
Get-EntraContact -Top 2
```

```Output
DisplayName          Id                                   Mail                         MailNickname
-----------          --                                   ----                         ------------
Contoso Contact     aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb contact@contoso.com         Contoso Contact
Contoso Contact1    bbbbbbbb-1111-2222-3333-cccccccccccc contact1@contoso.com        Contoso Contact 1
```

This example retrieves top two contacts in the directory. You can use `-Limit` as an alias for `-Top`.

### Example 5: Retrieve all contacts objects in the directory filter by DisplayName

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
Get-EntraContact -Filter "displayName eq 'Contoso Contact'"
```

```Output
DisplayName          Id                                   Mail                         MailNickname
-----------          --                                   ----                         ------------
Contoso Contact     aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb contact@contoso.com         Contoso Contact
Contoso Contact1    bbbbbbbb-1111-2222-3333-cccccccccccc contact1@contoso.com        Contoso Contact 1
Contoso Contact2    cccccccc-2222-3333-4444-dddddddddddd contact2@contoso.com        Contoso Contact 2
Contoso Contact3    dddddddd-3333-4444-5555-eeeeeeeeeeee contact3@contoso.com        Contoso Contact 3
```

This example retrieves contacts having the specified display name.

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

### -Filter

Specifies an OData v4.0 filter statement.
This parameter controls which objects are returned.

```yaml
Type: System.String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -OrgContactId

Specifies the ID of a contact in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetById
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
Parameter Sets: GetQuery
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

[Remove-EntraContact](Remove-EntraContact.md)
