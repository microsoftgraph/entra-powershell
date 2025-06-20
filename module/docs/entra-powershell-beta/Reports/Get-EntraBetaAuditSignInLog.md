---
author: msewaweru
description: This article provides details on the Get-EntraBetaAuditSignInLog command.
external help file: Microsoft.Entra.Beta.Reports-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 07/15/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaAuditSignInLog
schema: 2.0.0
title: Get-EntraBetaAuditSignInLog
---

# Get-EntraBetaAuditSignInLog

## Synopsis

Get audit logs of sign-ins.

## Syntax

```powershell
Get-EntraBetaAuditSignInLog
 [-All]
 [-Top <Int32>]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraBetaAuditSignInLog` cmdlet gets the Microsoft Entra ID sign-in log.

In addition to delegated permissions, the signed-in user must belong to at least one of the following Microsoft Entra roles to read sign-in reports:

- Global Reader
- Reports Reader
- Security Administrator
- Security Operator
- Security Reader

## Examples

### Example 1: Get all logs

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
Get-EntraBetaAuditSignInLog -All
```

```Output
Id                                   AppDisplayName                     AppId                                AppTokenProtectionStatus AuthenticationMethodsUsed AuthenticationProtocol
--                                   --------------                     -----                                ------------------------ ------------------------- ----------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Azure Active Directory PowerShell  00001111-aaaa-2222-bbbb-3333cccc4444                              {}                     none
bbbbbbbb-1111-2222-3333-cccccccccccc Azure Portal                       11112222-bbbb-3333-cccc-4444dddd5555                              {}                     none
cccccccc-2222-3333-4444-dddddddddddd Azure Active Directory PowerShell  22223333-cccc-4444-dddd-5555eeee6666                              {}                     none
dddddddd-3333-4444-5555-eeeeeeeeeeee Azure Active Directory PowerShell  33334444-dddd-5555-eeee-6666ffff7777                              {}                     none
```

This example returns all audit logs of sign-ins.

### Example 2: List sign-ins failing Conditional Access policies

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
Get-EntraBetaAuditSignInLog -Filter "conditionalAccessStatus eq 'failure'" -Limit 10 | Select-Object id, userDisplayName, createdDateTime, appDisplayName, status
```

```Output
id              : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
userDisplayName : Saywer Miller
createdDateTime : 03/08/2025 04:03:14
appDisplayName  : Microsoft Edge
status          : @{errorCode=50158; failureReason=External security challenge not satisfied. User will be redirected to another page or authentication provider to satisfy additional authentication challenges.; additionalDetails=The user is required to satisfy additional require
                  ments before finishing authentication, and was redirected to another page (such as terms of use or a third party MFA provider). This code alone does not indicate a failure on your users part to sign in. The sign in logs may indicate that this challenge was succ
                  esfully passed or failed.}
```

This example returns all audit logs of sign-ins failing Conditional Access policies.

### Example 3: List sign-ins from non-compliant devices

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
Get-EntraBetaAuditSignInLog -Filter "deviceDetail/isCompliant eq false" -Top 1 | Select-Object id, userDisplayName, appDisplayName, clientAppUsed, conditionalAccessStatus, deviceDetail, status
```

```Output
id                      : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
userDisplayName         : Sawyer Miller
appDisplayName          : Security Copilot
clientAppUsed           : Browser
conditionalAccessStatus : success
deviceDetail            : @{operatingSystem=Windows10; trustType=Azure AD registered; 22223333-cccc-4444-dddd-5555eeee6666; isCompliant=False; isManaged=False; browser=Edge 133.0.0; displayName=devbox}
status                  : @{errorCode=50011; failureReason=The {redirectTerm} '{replyAddress}' specified in the request does not match the {redirectTerm}s configured for the application '{identifier}'. Make sure the {redirectTerm} sent in the request matches one added to your ap
                          plication in the Azure portal. Navigate to {akamsLink} to learn more about how to fix this. {detail}; additionalDetails=Developer error - the app is attempting to sign in without the necessary or correct authentication parameters.}
```

This example returns all audit logs of sign-ins from non-compliant devices.

### Example 4: List sign-in failures due to a specific Conditional Access policy

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
$policyId = "dcf66a39-965f-4958-871f-f62613b6cabd"
Get-EntraBetaAuditSignInLog -Filter "
    conditionalAccessStatus eq 'failure' 
    and appliedConditionalAccessPolicies/any(c:c/id eq '$policyId' and c/result eq 'failure')" -Limit 1 | 
Select-Object id, userDisplayName, appDisplayName, clientAppUsed, 
              conditionalAccessStatus, status, appliedConditionalAccessPolicies
```

```Output
id                               : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
userDisplayName                  : ASawyer Miller
appDisplayName                   : Azure Portal
clientAppUsed                    : Browser
conditionalAccessStatus          : failure
status                           : @{errorCode=50158; failureReason=External security challenge not satisfied. User will be redirected to another page or authentication provider to satisfy additional authentication challenges.; additionalDetails=The user is required to satisfy a
                                   dditional requirements before finishing authentication, and was redirected to another page (such as terms of use or a third party MFA provider). This code alone does not indicate a failure on your users part to sign in. The sign in logs may ind
                                   icate that this challenge was succesfully passed or failed.}
appliedConditionalAccessPolicies : {@{id=22223333-cccc-4444-dddd-5555eeee6666; enforcedSessionControls=System.Object[]; displayName=CAX - All Contoso (and Guest) Users; result=failure; enforcedGrantControls=System.Object[]}, @{id=00001111-aaaa-2222-bbbb-3333cccc4444; enf
                                   orcedSessionControls=System.Object[]; displayName=CA01 - MFA - All Apps - All Users; result=success; enforcedGrantControls=System.Object[]}, @{id=22223333-cccc-4444-dddd-5555eeee6666; enforcedSessionControl
                                   s=System.Object[]; displayName=CA001 - Require Passwordless Auth and TAP - All Users; result=success; enforcedGrantControls=System.Object[]}, @{id=33334444-dddd-5555-eeee-6666ffff7777; enforcedSessionControls=System.Object[]; displayName=CA14 -
                                    Require MFA for VPN Access; result=notApplied; enforcedGrantControls=System.Object[]}…}
```

This example returns all audit logs of sign-ins failures due to a specific Conditional Access policy.

### Example 5: List risky sign-ins

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
Get-EntraBetaAuditSignInLog -Filter "
    (riskLevelDuringSignIn ne 'none' or 
    riskEventTypes_v2/any(r:r ne 'none'))
" -Limit 1 | 
Select-Object id, userDisplayName, appDisplayName, clientAppUsed, 
              riskLevelDuringSignIn, riskEventTypes_v2
```

```Output
id                    : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
userDisplayName       : Sawyer Miller
appDisplayName        : Security Copilot
clientAppUsed         : Browser
riskLevelDuringSignIn : low
riskEventTypes_v2     : {unfamiliarFeatures}
```

This example returns all audit logs of risky sign-ins.

### Example 6: Get sign-ins without MFA

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
Get-EntraBetaAuditSignInLog -Filter "authenticationRequirement ne 'multiFactorAuthentication' and isInteractive eq true"
```

```Output
Id                                   AppDisplayName                     AppId                                AppTokenProtectionStatus AuthenticationMethodsUsed AuthenticationProtocol
--                                   --------------                     -----                                ------------------------ ------------------------- ----------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Azure Active Directory PowerShell  00001111-aaaa-2222-bbbb-3333cccc4444                              {}                     none
bbbbbbbb-1111-2222-3333-cccccccccccc Azure Portal                       11112222-bbbb-3333-cccc-4444dddd5555                              {}                     none
cccccccc-2222-3333-4444-dddddddddddd Azure Active Directory PowerShell  22223333-cccc-4444-dddd-5555eeee6666                              {}                     none
dddddddd-3333-4444-5555-eeeeeeeeeeee Azure Active Directory PowerShell  33334444-dddd-5555-eeee-6666ffff7777                              {}                     none
```

This example returns all audit logs of sign-ins without MFA.

### Example 7: Get the first two logs

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
Get-EntraBetaAuditSignInLog -Top 2
```

```Output
Id                                   AppDisplayName                     AppId                                AppTokenProtectionStatus AuthenticationMethodsUsed AuthenticationProtocol
--                                   --------------                     -----                                ------------------------ ------------------------- ----------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Azure Active Directory PowerShell  00001111-aaaa-2222-bbbb-3333cccc4444                               {}                     none
bbbbbbbb-1111-2222-3333-cccccccccccc Azure Portal                       11112222-bbbb-3333-cccc-4444dddd5555                               {}                     none
```

This example returns the first two audit logs of sign-ins. You can use `-Limit` as an alias for `-Top`.

### Example 8: Get audit logs containing a given AppDisplayName

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
Get-EntraBetaAuditSignInLog -Filter "AppDisplayName eq 'Graph Explorer'" -Top 1
```

```Output
Id                                   AppDisplayName                                                 AppId                                AppTokenProtectionStatus AuthenticationMethodsUsed AuthenticationProtocol
--                                   --------------                                                 -----                                ------------------------ ------------------------- ----------------------
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb Graph Explorer PowerShell  00001111-aaaa-2222-bbbb-3333cccc4444
```

This example demonstrates how to retrieve sign-in logs by AppDisplayName. You can use `-Limit` as an alias for `-Top`.

### Example 9: Get all sign-in logs between dates

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
Get-EntraBetaAuditSignInLog -Filter "createdDateTime ge 2024-07-01T00:00:00Z and createdDateTime le 2024-07-14T23:59:59Z"
```

This example shows how to retrieve sign-in logs between dates.

### Example 10: List failed sign-ins for a user

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All','Directory.Read.All'
$failedSignIns = Get-EntraBetaAuditSignInLog -Filter "userPrincipalName eq 'SawyerM@contoso.com' and status/errorCode ne 0"
$failedSignIns | Select-Object UserPrincipalName, CreatedDateTime, Status, IpAddress, ClientAppUsed | Format-Table -AutoSize
```

This example demonstrates how to retrieve failed sign-ins for a user.

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

### -Top

The maximum number of records to return.

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

### -Filter

The OData v4.0 filter statement.
Controls which objects are returned.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

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

## Inputs

## Outputs

## Notes

`Get-EntraBetaAuditSignInLogs` is an alias for `Get-EntraBetaAuditSignInLog`.

## Related links
