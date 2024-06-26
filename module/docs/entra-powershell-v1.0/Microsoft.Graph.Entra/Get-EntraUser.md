---
Title: Get-EntraUser
Description: This article provides details on the Get-EntraUser command.

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

# Get-EntraUser

## Synopsis

Gets a user.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraUser 
 [-Filter <String>] 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraUser 
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraUser 
 -ObjectId <String> 
 [-All] 
 [<CommonParameters>]
```

## Description

The Get-EntraUser cmdlet gets a user from Microsoft Entra ID.

## Examples

### Example 1: Get top three users

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUser -Top 3
```

```output
DisplayName      Id                                   Mail                  UserPrincipalName
-----------      --                                   ----                  -----------------
Angel Brown      cccccccc-2222-3333-4444-dddddddddddd AngelB@contoso.com    AngelB@contoso.com
Avery Smith      dddddddd-3333-4444-5555-eeeeeeeeeeee AveryS@contoso.com    AveryS@contoso.com
Sawyer Miller    eeeeeeee-4444-5555-6666-ffffffffffff SawyerM@contoso.com   SawyerM@contoso.com
```

This example demonstrates how to get top three users from Microsoft Entra ID.

### Example 2: Get a user by ID

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUser -ObjectId 'cccccccc-2222-3333-4444-dddddddddddd'
```

```output
DisplayName      Id                                   Mail                  UserPrincipalName
-----------      --                                   ----                  -----------------
Angel Brown      cccccccc-2222-3333-4444-dddddddddddd AngelB@contoso.com    AngelB@contoso.com
```

This example demonstrates how to retrieve specific user by providing ID.

### Example 3: Search among retrieved users

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUser -SearchString 'New'
```

```output
ObjectId                             DisplayName UserPrincipalName                   UserType
--------                             ----------- -----------------                   --------
Aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb New user    NewUser@contoso.com     Member
Dddddddd-9999-0000-1111-eeeeeeeeeeee New Test user    NewTestUser@contoso.com Member
```

This cmdlet gets all users that match the value of SearchString against the first characters in DisplayName or UserPrincipalName.

### Example 4: Get a user by userPrincipalName

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUser -Filter "UserPrincipalName eq 'NewUser@contoso.com'"
```

```output
ObjectId                             DisplayName UserPrincipalName                   UserType
--------                             ----------- -----------------                   --------
Aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb New user    NewUser@contoso.com     Member
```

In this example, we retrieve user by `UserPrincipalName` from Microsoft Entra ID.

### Example 5: Get a user by MailNickname

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraUser -Filter "startswith(MailNickname,'Ada')"
```

```output
DisplayName     Id                                   Mail                                UserPrincipalName
-----------     --                                   ----                                -----------------
Mark Adams bbbbbbbb-1111-2222-3333-cccccccccccc Adams@contoso.com Adams@contoso.com
```

In this example, we retrieve all users whose MailNickname starts with Ada.

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
Details on querying with oData can be found here.
<https://www.odata.org/documentation/odata-version-3-0/odata-version-3-0-core-protocol/#queryingcollections>

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

Specifies the ID (as a UserPrincipalName or ObjectId) of a user in Microsoft Entra ID.

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

[New-EntraUser](New-EntraUser.md)

[Remove-EntraUser](Remove-EntraUser.md)

[Set-EntraUser](Set-EntraUser.md)
