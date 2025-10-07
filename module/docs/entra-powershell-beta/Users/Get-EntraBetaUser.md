---
author: msewaweru
description: This article provides details on the Get-EntraBetaUser command.
external help file: Microsoft.Entra.Beta.Users-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Users
ms.author: eunicewaweru
ms.date: 02/09/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Users/Get-EntraBetaUser
schema: 2.0.0
title: Get-EntraBetaUser
---

# Get-EntraBetaUser

## SYNOPSIS

Gets a user.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaUser
 [-Filter <String>]
 [-All]
 [-Top <Int32>]
 [-PageSize <Int32>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraBetaUser
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaUser
 -UserId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaUser` cmdlet gets a user from Microsoft Entra ID.

## EXAMPLES

### Example 1: Get top three users

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUser -Top 3
```

```Output
DisplayName      Id                                   Mail                  UserPrincipalName
-----------      --                                   ----                  -----------------
Angel Brown      cccccccc-2222-3333-4444-dddddddddddd AngelB@contoso.com    AngelB@contoso.com
Avery Smith      dddddddd-3333-4444-5555-eeeeeeeeeeee AveryS@contoso.com    AveryS@contoso.com
Sawyer Miller    eeeeeeee-4444-5555-6666-ffffffffffff SawyerM@contoso.com   SawyerM@contoso.com
```

This example demonstrates how to get top three users from Microsoft Entra ID. You can use `-Limit` as an alias for `-Top`.

### Example 2: Get a user by ID

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUser -UserId 'SawyerM@contoso.com'
```

```Output
DisplayName Id                                   Mail                                 UserPrincipalName
----------- --                                   ----                                 -----------------
Sawyer Miller bbbbbbbb-1111-2222-3333-cccccccccccc sawyerm@tenant.com sawyerm@tenant.com
```

This command gets the specified user.

- `-UserId` Specifies the ID as a user principal name (UPN) or UserId.

### Example 3: Search among retrieved users

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUser -SearchString 'New'
```

```Output
DisplayName        Id                                   Mail UserPrincipalName
-----------        --                                   ---- -----------------
New User88         bbbbbbbb-1111-2222-3333-cccccccccccc      demo99@tenant.com
New User           cccccccc-2222-3333-4444-dddddddddddd      NewUser@tenant.com
```

This cmdlet gets all users that match the value of SearchString against the first characters in DisplayName or UserPrincipalName.

### Example 4: Retrieve user's password policy

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUser -UserId 'SawyerM@contoso.com' `
              -Property UserPrincipalName, PasswordPolicies | 
    Select-Object UserPrincipalName, 
                  @{
                      Name = "PasswordNeverExpires"
                      Expression = { $_.PasswordPolicies -contains "DisablePasswordExpiration" }
                  }
```

```Output
userPrincipalName            PasswordNeverExpires
-----------------            --------------------
SawyerM@contoso.com                 True
```

This example shows how to get a user's password policy. To update it, run `Get-EntraBetaUser -UserId SawyerM@contoso.com | Set-EntraBetaUser -PasswordPolicies DisablePasswordExpiration`.

### Example 5: Per-user MFA report

```powershell
Connect-Entra -scope 'User.Read.All', 'UserAuthenticationMethod.Read.All'
$users = Get-EntraBetaUser -All -Select Id, UserPrincipalName, DisplayName 
Write-Output "Amount of requests within `"fetchAll`": $($users.Count)" 
$usersReport = [System.Collections.ArrayList]::new()
$users | ForEach-Object { 

    $userProperties = @{
        Id                = $_.Id
        DisplayName       = $_.DisplayName
        UserPrincipalName = $_.UserPrincipalName
        PerUserMFAState   = (Get-EntraBetaUserAuthenticationRequirement -UserId $_.Id).PerUserMFAState
    }
    
    [void]$usersReport.Add([PSCustomObject]$userProperties)
} 

$usersReport | Format-Table -AutoSize
```

```Output
UserPrincipalName       DisplayName       PerUserMFAState Id                                    
-----------------       -----------       --------------- --                                    
AngelB@contoso.com      Angel Brown       enforced        cccccccc-2222-3333-4444-dddddddddddd  
AveryS@contoso.com      Avery Smith       disabled        dddddddd-3333-4444-5555-eeeeeeeeeeee  
SawyerM@contoso.com     Sawyer Miller     enforced        eeeeeeee-4444-5555-6666-ffffffffffff  
ChristieC@contoso.com   Christie Cline    enabled         bbbbbbbb-1111-2222-3333-cccccccccccc  
PattiF@contoso.com      Patti Fernandez   disabled        aaaaaaaa-bbbb-cccc-1111-222222222222  
```

This example shows a report of per-user MFA state.

**Note**: Microsoft recommends using Conditional Access policies and security defaults to manage multi-factor authentication (MFA) instead of relying on legacy per-user MFA.

### Example 6: Get a user by userPrincipalName

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUser -Filter "userPrincipalName eq 'SawyerM@contoso.com'"
```

```Output
DisplayName Id                                   Mail UserPrincipalName
----------- --                                   ---- -----------------
Sawyer Miller    cccccccc-2222-3333-4444-dddddddddddd      SawyerM@contoso.com
```

This command gets the specified user.

### Example 7: Get a user by MailNickname

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUser -Filter "startsWith(MailNickname,'Ada')"
```

```Output
DisplayName     Id                                   Mail                                UserPrincipalName
-----------     --                                   ----                                -----------------
Mark Adams bbbbbbbb-1111-2222-3333-cccccccccccc Adams@contoso.com Adams@contoso.com
```

In this example, we retrieve all users whose MailNickname starts with Ada.

### Example 8: Get SignInActivity of a User

```powershell
Connect-Entra -Scopes 'User.Read.All','AuditLog.Read.All'
Get-EntraBetaUser -UserId 'SawyerM@contoso.com' -Property 'SignInActivity' | Select-Object -Property Id, DisplayName, UserPrincipalName -ExpandProperty 'SignInActivity'
```

```Output
lastNonInteractiveSignInRequestId : bbbbbbbb-1111-2222-3333-aaaaaaaaaaaa
lastSignInRequestId               : cccccccc-2222-3333-4444-dddddddddddd
lastSuccessfulSignInDateTime      : 9/9/2024 1:12:13 PM
lastNonInteractiveSignInDateTime  : 9/9/2024 1:12:13 PM
lastSuccessfulSignInRequestId     : bbbbbbbb-1111-2222-3333-aaaaaaaaaaaa
lastSignInDateTime                : 9/7/2024 9:15:41 AM
id                                : aaaaaaaa-bbbb-cccc-1111-222222222222
displayName                       : Sawyer Miller
userPrincipalName                 : SawyerM@contoso.com
```

This example demonstrates how to retrieve the SignInActivity of a specific user by selecting a property.

### Example 9: List users with disabled accounts

```powershell
Connect-Entra -Scopes 'User.Read.All'
Get-EntraBetaUser -Filter "accountEnabled eq false" | Select-Object DisplayName, Id, Mail, UserPrincipalName
```

```Output
DisplayName        Id                                   Mail UserPrincipalName
-----------        --                                   ---- -----------------
New User           cccccccc-2222-3333-4444-dddddddddddd      NewUser@tenant.com
```

This example demonstrates how to retrieve all users with disabled accounts.

### Example 10: List users based in a specific country

```powershell
Connect-Entra -Scopes 'User.Read.All'
$usersInCanada = Get-EntraBetaUser -Filter "Country eq 'Canada'"
$usersInCanada | Select-Object Id, DisplayName, UserPrincipalName, OfficeLocation, Country | Format-Table -AutoSize
```

```Output
Id                                   DisplayName   UserPrincipalName         OfficeLocation   Country
--                                   -----------   -----------------         --------------   -------
cccccccc-2222-3333-4444-dddddddddddd  New User     NewUser@tenant.com        23/2102          Canada
```

This example demonstrates how to retrieve all users based in Canada.

### Example 11: List user count per department

```powershell
Connect-Entra -Scopes 'User.Read.All'
$departmentCounts = Get-EntraBetaUser -All | Group-Object -Property Department | Select-Object Name, @{Name="MemberCount"; Expression={$_.Count}}
$departmentCounts | Format-Table Name, MemberCount -AutoSize
```

```Output
Name                 MemberCount
----                 -----------
                               7
Engineering                    2
Executive Management           1
Finance                        1
HR                             1
```

This example demonstrates how to retrieve user count in each department.

### Example 12: List disabled users with active licenses

```powershell
Connect-Entra -Scopes 'User.Read.All'
$disabledUsersWithLicenses = Get-EntraBetaUser -Filter "accountEnabled eq false" -All | Where-Object {
    $_.AssignedLicenses -ne $null -and $_.AssignedLicenses.Count -gt 0
}
$disabledUsersWithLicenses | Select-Object Id, DisplayName, UserPrincipalName, AccountEnabled | Format-Table -AutoSize
```

```Output
Id                                   DisplayName  UserPrincipalName           AccountEnabled
--                                   -----------  -----------------           --------------
cccccccc-2222-3333-4444-dddddddddddd  New User     NewUser@tenant.com          False
```

This example demonstrates how to retrieve disabled users with active licenses.

### Example 13: Retrieve guest users with active licenses

```powershell
Connect-Entra -Scopes 'User.Read.All'
$guestUsers = Get-EntraBetaUser -Filter "userType eq 'Guest'" -All
$guestUsersWithLicenses = foreach ($guest in $guestUsers) {
    if ($guest.AssignedLicenses.Count -gt 0) {
        [PSCustomObject]@{
            Id                = $guest.Id
            DisplayName       = $guest.DisplayName
            UserPrincipalName = $guest.UserPrincipalName
            AssignedLicenses  = ($guest.AssignedLicenses | ForEach-Object { $_.SkuId }) -join ", "
        }
    }
}
$guestUsersWithLicenses | Format-Table Id, DisplayName, UserPrincipalName, AssignedLicenses -AutoSize
```

```Output
Id                                   DisplayName  UserPrincipalName                                  AssignedLicenses
--                                   -----------  -----------------                                  ----------------
cccccccc-2222-3333-4444-dddddddddddd Sawyer Miller sawyerm_gmail.com#EXT#@contoso.com c42b9cae-ea4f-4ab7-9717-81576235ccac
```

This example demonstrates how to retrieve guest users with active licenses.

### Example 14: List users with a specific license

```powershell
Connect-Entra -Scopes 'User.Read.All'
$skuId = (Get-EntraBetaSubscribedSku | Where-Object { $_.SkuPartNumber -eq 'POWERAPPS_DEV' }).SkuId
Get-EntraBetaUser -Filter "assignedLicenses/any(l:l/skuId eq $skuId)" -Select id, displayName, userPrincipalName, userType, accountEnabled, assignedLicenses |
Select-Object id, displayName, userPrincipalName, userType, accountEnabled | Format-Table -AutoSize
```

```Output
id                                   displayName     userPrincipalName        userType accountEnabled
--                                   -----------     -----------------        -------- --------------
cccccccc-2222-3333-4444-dddddddddddd Angel Brown     AngelB@contoso.com       Member   True
dddddddd-3333-4444-5555-eeeeeeeeeeee Avery Smith     AveryS@contoso.com       Member   True
```

This example demonstrates how to retrieve users with a specific license.

### Example 15: Retrieve users without managers

```powershell
Connect-Entra -Scopes 'User.Read.All'
$allUsers = Get-EntraBetaUser -All
$usersWithoutManagers = foreach ($user in $allUsers) {
    $manager = Get-EntraBetaUserManager -ObjectId $user.Id -ErrorAction SilentlyContinue
    if (-not $manager) {
        [PSCustomObject]@{
            Id                = $user.Id
            DisplayName       = $user.DisplayName
            UserPrincipalName = $user.UserPrincipalName
        }
    }
}
$usersWithoutManagers | Format-Table Id, DisplayName, UserPrincipalName -AutoSize
```

```Output
Id                                   DisplayName     UserPrincipalName
--                                   -----------     -----------------
cccccccc-2222-3333-4444-dddddddddddd  New User       NewUser@tenant.com
bbbbbbbb-1111-2222-3333-cccccccccccc  Sawyer Miller  SawyerM@contoso.com
```

This example demonstrates how to retrieve users without managers.

### Example 16: List all guest users

```powershell
Connect-Entra -Scopes 'User.Read.All'
$guestUsers = Get-EntraBetaUser -Filter "userType eq 'Guest'" -All
$guestUsers | Select-Object DisplayName, UserPrincipalName, Id, createdDateTime, creationType, accountEnabled, UserState | Format-Table -AutoSize
```

```Output
DisplayName     UserPrincipalName                                 Id                                   CreatedDateTime       CreationType   AccountEnabled  UserState
-----------     -----------------                                 --                                   ---------------       ------------   --------------  ---------
Sawyer Miller   sawyerm_gmail.com#EXT#@contoso.com                bbbbbbbb-1111-2222-3333-cccccccccccc 9/13/2024 6:37:33 PM  Invitation     True            Accepted
```

This example demonstrates how to retrieve list all guest users.

### Example 17: List five recently created users

```powershell
Get-EntraBetaUser -All | Sort-Object -Property createdDateTime -Descending | Select-Object -First 5
```

```Output
DisplayName       Id                                   Mail                  UserPrincipalName     
-----------       --                                   ----                  -----------------     
Angel Brown       cccccccc-2222-3333-4444-dddddddddddd  AngelB@contoso.com    AngelB@contoso.com     
Avery Smith       dddddddd-3333-4444-5555-eeeeeeeeeeee  AveryS@contoso.com    AveryS@contoso.com     
Sawyer Miller     eeeeeeee-4444-5555-6666-ffffffffffff  SawyerM@contoso.com   SawyerM@contoso.com    
Christie Cline    bbbbbbbb-1111-2222-3333-cccccccccccc  ChristieC@contoso.com ChristieC@contoso.com  
Patti Fernandez   aaaaaaaa-bbbb-cccc-1111-222222222222  PattiF@contoso.com    PattiF@contoso.com     
```

This example shows how to retrieve the recently created users.

### Example 18: List of users with Global Administrator role

```powershell
Connect-Entra -Scopes 'User.Read.All', 'RoleManagement.Read.Directory'
$roleId = Get-EntraBetaDirectoryRoleTemplate | Where-Object { $_.DisplayName -eq 'Global Administrator' } | Select-Object -ExpandProperty Id
$globalAdmins = Get-EntraBetaDirectoryRoleAssignment -Filter "roleDefinitionId eq '$roleId'" | ForEach-Object {
    Get-EntraBetaUser -UserId $_.PrincipalId
}
$globalAdmins | Select-Object Id, DisplayName, UserPrincipalName, CreatedDateTime, AccountEnabled | Format-Table -AutoSize
```

```Output
id                                   displayName   userPrincipalName        createdDateTime          accountEnabled
--                                   -----------   -----------------        ---------------          --------------
cccccccc-2222-3333-4444-dddddddddddd Angel Brown   AngelB@contoso.com       3/7/2024 12:34:59 AM     True
dddddddd-3333-4444-5555-eeeeeeeeeeee Avery Smith   AveryS@contoso.com       10/1/2024 9:47:06 AM     True
```

This example shows how to list all users with a specific role, such as `Global Administrator`. Microsoft recommends assigning the Global Administrator role to fewer than five people for best practice. See [best practices](https://learn.microsoft.com/entra/identity/role-based-access-control/best-practices).

### Example 19: List all Users with revoked sessions in the last 30 Days

```powershell
Connect-Entra -Scopes 'User.Read.All'
$pastDate = (Get-Date).AddDays(-30).ToUniversalTime()
Get-EntraBetaUser | Where-Object { $_.signInSessionsValidFromDateTime -ge $pastDate } |
Select-Object DisplayName, UserPrincipalName, signInSessionsValidFromDateTime
```

```Output
displayName     userPrincipalName      signInSessionsValidFromDateTime
-----------     -----------------      -------------------------------
Angel Brown     AngelB@contoso.com     03/03/2025 16:13:47
Avery Smith     AveryS@contoso.com     03/03/2025 16:05:02
```

This example shows how to list all users with revoked sessions in the last 30 Days.

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
Details on querying with OData can be [found here](https://learn.microsoft.com/graph/aad-advanced-queries?tabs=powershell).

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

Specifies the ID (as a User Principal Name (UPN) or UserId) of a user in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: ObjectId, UPN, Identity, UserPrincipalName

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
Parameter Sets: GetValue
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

### -PageSize

When -PageSize is specified, the command may make multiple network calls to retrieve data in chunks (pages), continuing until it reaches the limit defined by either -Top or -All, depending on which is used.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

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

[New-EntraBetaUser](New-EntraBetaUser.md)

[Remove-EntraBetaUser](Remove-EntraBetaUser.md)

[Set-EntraBetaUser](Set-EntraBetaUser.md)

[Manage users](https://learn.microsoft.com/powershell/entra-powershell/manage-user)
