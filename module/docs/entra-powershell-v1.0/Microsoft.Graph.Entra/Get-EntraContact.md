---
Title: Get-EntraContact
Description: This article provides details on the Get-EntraContact command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG

External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Get-EntraContact

## Synopsis

Gets a contact from Microsoft Entra ID.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraContact 
 [-Filter <String>] 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraContact 
 -ObjectId <String> 
 [-All] 
 [<CommonParameters>]
```

## Description

The `Get-EntraContact` cmdlet gets a contact from Microsoft Entra ID.

## Examples

### Example 1: Retrieve all contact objects in the directory

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
Get-EntraContact
```

```output
ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
Aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb contact@contoso.com  Contoso Contact
Bbbbbbbb-1111-2222-3333-cccccccccccc contact1@contoso.com Contoso Contact1
Cccccccc-2222-3333-4444-dddddddddddd contact2@contoso.com Contoso Contact2
```

This command retrieves all contact objects in the directory.  

### Example 2: Retrieve specific contact object in the directory

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
Get-EntraContact -ObjectId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```output
ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
Aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb contact@contoso.com  Contoso Contact
```

This command retrieves specified contact in the directory.  

### Example 3: Retrieve all contacts objects in the directory

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
Get-EntraContact -All 
```

```output
ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
Aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb contact@contoso.com  Contoso Contact
Bbbbbbbb-1111-2222-3333-cccccccccccc contact1@contoso.com Contoso Contact1
Cccccccc-2222-3333-4444-dddddddddddd contact2@contoso.com Contoso Contact2
```

This command retrieves all the contacts in the directory.

### Example 4: Retrieve top two contacts objects in the directory

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
Get-EntraContact -Top 2
```

```output
ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
Aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb contact@contoso.com  Contoso Contact
Bbbbbbbb-1111-2222-3333-cccccccccccc contact1@contoso.com Contoso Contact1
```

This command retrieves top two contacts in the directory.

### Example 5: Retrieve all contacts objects in the directory filter by DisplayName

```powershell
Connect-Entra -Scopes 'OrgContact.Read.All'
Get-EntraContact -Filter "DisplayName eq 'Contoso Contact'"
```

```output
ObjectId                             Mail                 DisplayName
--------                             ----                 -----------
Aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb contact@contoso.com  Contoso Contact
Bbbbbbbb-1111-2222-3333-cccccccccccc contact1@contoso.com Contoso Contact1
```

This command retrieves contacts having the specified display name.

## Parameters

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

Specifies an oData v3.0 filter statement.
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

### -ObjectId

Specifies the ID of a contact in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases:

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
Aliases:

Required: False
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

[Remove-EntraContact](Remove-EntraContact.md)
