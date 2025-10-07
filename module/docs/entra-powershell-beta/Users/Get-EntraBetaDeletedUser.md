---
description: This article provides details on the Get-EntraBetaDeletedUser command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Users
ms.author: eunicewaweru
ms.date: 02/12/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Users/Get-EntraBetaDeletedUser
schema: 2.0.0
title: Get-EntraBetaDeletedUser
---

# Get-EntraBetaDeletedUser

## SYNOPSIS

Retrieves soft-deleted (recently deleted) users in Microsoft Entra ID.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaDeletedUser
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraBetaDeletedUser
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaDeletedUser
 -UserId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaDeletedUser` cmdlet retrieves soft-deleted (recently deleted) users from the directory. Deleted users can be recovered within 30 days, after which they're permanently deleted.

## EXAMPLES

### Example 1: Get deleted users in the directory

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaDeletedUser | Select-Object Id, UserPrincipalName, DisplayName, AccountEnabled, DeletedDateTime, DeletionAgeInDays, UserType | Format-Table -AutoSize
```

```Output
Id                                   UserPrincipalName                                              DisplayName   AccountEnabled DeletedDateTime       DeletionAgeInDays UserType
--                                   -----------------                                              -----------   -------------- ---------------       ----------------- --------
dddddddd-3333-4444-5555-eeeeeeeeeeee dddddddd-3333-4444-5555-eeeeeeeeeeeeAveryS@contoso.com        Avery Smith   False          2/12/2025 1:15:34 PM  3                 Member
```

This example shows how to retrieve all recoverable deleted users in the Microsoft Entra ID.

### Example 2: Get deleted users in the directory using All parameter

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaDeletedUser -All | Select-Object Id, UserPrincipalName, DisplayName, AccountEnabled, DeletedDateTime, DeletionAgeInDays, UserType | Format-Table -AutoSize
```

```Output
Id                                   UserPrincipalName                                              DisplayName   AccountEnabled DeletedDateTime       DeletionAgeInDays UserType
--                                   -----------------                                              -----------   -------------- ---------------       ----------------- --------
dddddddd-3333-4444-5555-eeeeeeeeeeee dddddddd-3333-4444-5555-eeeeeeeeeeeeAveryS@contoso.com        Avery Smith   False          2/12/2025 1:15:34 PM  3                 Member
```

This example shows how to retrieve all recoverable deleted users, using All parameter.

### Example 3: Get top two deleted users

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaDeletedUser -Top 2 | Select-Object Id, UserPrincipalName, DisplayName, AccountEnabled, DeletedDateTime, DeletionAgeInDays, UserType | Format-Table -AutoSize
```

```Output
Id                                   UserPrincipalName                                              DisplayName   AccountEnabled DeletedDateTime       DeletionAgeInDays UserType
--                                   -----------------                                              -----------   -------------- ---------------       ----------------- --------
dddddddd-3333-4444-5555-eeeeeeeeeeee dddddddd-3333-4444-5555-eeeeeeeeeeeeAveryS@contoso.com        Avery Smith   False          2/12/2025 1:15:34 PM  3                 Member
```

This example shows how to retrieve the top two recoverable deleted users in the directory. You can use `-Limit` as an alias for `-Top`.

### Example 4: Get deleted users containing string 'Avery Smith'

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaDeletedUser -SearchString 'Avery Smith' | Select-Object Id, UserPrincipalName, DisplayName, AccountEnabled, DeletedDateTime, DeletionAgeInDays, UserType | Format-Table -AutoSize
```

```Output
Id                                   UserPrincipalName                                              DisplayName   AccountEnabled DeletedDateTime       DeletionAgeInDays UserType
--                                   -----------------                                              -----------   -------------- ---------------       ----------------- --------
dddddddd-3333-4444-5555-eeeeeeeeeeee dddddddd-3333-4444-5555-eeeeeeeeeeeeAveryS@contoso.com        Avery Smith   False          2/12/2025 1:15:34 PM  3                 Member
```

This example shows how to retrieve deleted users in the directory, containing the specified string.

### Example 5: Get deleted users filter by display name

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaDeletedUser -Filter "displayName eq 'Avery Smith'" | Select-Object Id, UserPrincipalName, DisplayName, AccountEnabled, DeletedDateTime, DeletionAgeInDays, UserType | Format-Table -AutoSize
```

```Output
Id                                   UserPrincipalName                                              DisplayName   AccountEnabled DeletedDateTime       DeletionAgeInDays UserType
--                                   -----------------                                              -----------   -------------- ---------------       ----------------- --------
dddddddd-3333-4444-5555-eeeeeeeeeeee dddddddd-3333-4444-5555-eeeeeeeeeeeeAveryS@contoso.com        Avery Smith   False          2/12/2025 1:15:34 PM  3                 Member
```

This example shows how to retrieve deleted users in the directory, having the specified display name.

### Example 6: Get deleted user by UserId

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaDeletedUser -UserId 'dddddddd-3333-4444-5555-eeeeeeeeeeee' | Select-Object Id, UserPrincipalName, DisplayName, AccountEnabled, DeletedDateTime, DeletionAgeInDays, UserType | Format-Table -AutoSize
```

```Output
Id                                   UserPrincipalName                                              DisplayName   AccountEnabled DeletedDateTime       DeletionAgeInDays UserType
--                                   -----------------                                              -----------   -------------- ---------------       ----------------- --------
dddddddd-3333-4444-5555-eeeeeeeeeeee dddddddd-3333-4444-5555-eeeeeeeeeeeeAveryS@contoso.com        Avery Smith   False          2/12/2025 1:15:34 PM  3                 Member
```

This example shows how to retrieve the deleted user specified by UserId.

- `-UserId` parameter specifies the deleted user UserId.

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

### -UserId

The ObjectId or User Principal Name of the deleted user to be retrieved.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: ObjectId, UPN, Identity, UserPrincipalName, Id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -SearchString

Specifies a search string.

```yaml
Type: System.String
Parameter Sets: GetVague
Aliases:

Required: False
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

Specifies properties to be returned

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

### System.String

System.Nullable\`1\[\[System.Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
