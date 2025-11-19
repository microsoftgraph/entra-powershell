---
author: msewaweru
description: This article provides details on the Get-EntraBetaContact command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.DirectoryManagement
ms.author: eunicewaweru
ms.date: 07/29/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.DirectoryManagement/Get-EntraBetaContact
schema: 2.0.0
title: Get-EntraBetaContact
---

# Get-EntraBetaContact

## SYNOPSIS

Gets a contact from Microsoft Entra ID.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaContact
 [-Filter <String>]
 [-All]
 [-Top <Int32>]
 [-Property <String[]>]
 [-HasErrorsOnly]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaContact
 -OrgContactId <String>
 [-All]
 [-Property <String[]>]
 [-HasErrorsOnly]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaContact` cmdlet gets a contact from Microsoft Entra ID.

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
Get-EntraBetaContact
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
$contact = Get-EntraBetaContact -Filter "displayName eq 'Contoso Contact'"
Get-EntraBetaContact -OrgContactId $contact.Id
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
Get-EntraBetaContact -All
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
Get-EntraBetaContact -Top 2
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
Get-EntraBetaContact -Filter "displayName eq 'Contoso Contact'"
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

### Example 6: Retrieve contacts with service provisioning errors

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
Get-EntraBetaContact -HasErrorsOnly
```

```Output
DisplayName          Id                                   Mail                         ServiceProvisioningErrors
-----------          --                                   ----                         -------------------------
Failed Contact       eeeeeeee-4444-5555-6666-ffffffffffff contact-error@contoso.com    {@{ErrorDetail=...}}
```

This example retrieves only contacts that have service provisioning errors.

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

### -HasErrorsOnly

Returns only contacts that have service provisioning errors.

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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Remove-EntraBetaContact](Remove-EntraBetaContact.md)
