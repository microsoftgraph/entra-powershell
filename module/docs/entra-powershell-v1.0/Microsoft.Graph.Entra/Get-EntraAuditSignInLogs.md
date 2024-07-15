---
title: Get-EntraAuditSignInLogs.
description: This article provides details on the Get-EntraAuditSignInLogs command.
ms.topic: reference
ms.date: 07/15/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraAuditSignInLogs

## Synopsis

Get audit logs of sign-ins.

## Syntax

```powershell
Get-EntraAuditSignInLogs 
 [-All]
 [-Top <Int32>] 
 [-Filter <String>] 
 [<CommonParameters>]
```

## Description

The `Get-EntraAuditSignInLogs` cmdlet gets the Microsoft Entra ID sign-in log.

## Examples

### Example 1: Get all logs

```powershell
 Get-EntraAuditSignInLogs -All  
```

```Output
appliedConditionalAccessPolicies : {@{id=aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb; enforcedSessionControls=System.Object[]; displayName=Multifactor authentication for
                                   Microsoft partners and vendors; enforcedGrantControls=System.Object[]; result=success}, @{id=aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb;
                                   enforcedSessionControls=System.Object[]; displayName=Office 365 App Control; enforcedGrantControls=System.Object[]; result=notEnabled},
                                   @{id=aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb; enforcedSessionControls=System.Object[]; displayName=testpolicy;
                                   enforcedGrantControls=System.Object[]; result=notEnabled}, @{id=aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb;
                                   enforcedSessionControls=System.Object[]; displayName=test; enforcedGrantControls=System.Object[]; result=notEnabled}...}
isInteractive                    : True
location                         : @{state=Maharashtra; geoCoordinates=; city=Nashik; countryOrRegion=IN}
conditionalAccessStatus          : success
resourceDisplayName              : Windows Azure Service Management API
userPrincipalName                : Test.mail.onmicrosoft.com
riskLevelAggregated              : none
appId                            : 00000000-0000-0000-0000-000000000000
deviceDetail                     : @{browser=Edge 126.0.0; operatingSystem=Windows10; displayName=; isManaged=False; trustType=; isCompliant=False; deviceId=}
riskDetail                       : none
riskState                        : none
status                           : @{errorCode=50055; additionalDetails=The user's password is expired, and therefore their login or session was ended. They will be
                                   offered the opportunity to reset it, or may ask an admin to reset it via
                                   https://learn.microsoft.com/entra/fundamentals/users-reset-password-azure-portal; failureReason=The password is expired.}
ipAddress                        : 223.233.80.208
userId                           : 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
id                               : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
resourceId                       : a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1
appDisplayName                   : Azure Portal
clientAppUsed                    : Browser
correlationId                    : aaaa0000-bb11-2222-33cc-444444dddddd
riskEventTypes_v2                : {}
riskEventTypes                   : {}
createdDateTime                  : 02/07/2024 04:18:26
riskLevelDuringSignIn            : none
userDisplayName                  : Test User
```

This command gets all sign-in logs.

### Example 2: Get the first n logs

```powershell
 Get-EntraAuditSignInLogs -Top 1
```

```Output
appliedConditionalAccessPolicies : {@{id=aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb; enforcedSessionControls=System.Object[]; displayName=Multifactor authentication for
                                   Microsoft partners and vendors; enforcedGrantControls=System.Object[]; result=success}, @{id=aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb;
                                   enforcedSessionControls=System.Object[]; displayName=Office 365 App Control; enforcedGrantControls=System.Object[]; result=notEnabled},
                                   @{id=aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb; enforcedSessionControls=System.Object[]; displayName=testpolicy;
                                   enforcedGrantControls=System.Object[]; result=notEnabled}, @{id=aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb;
                                   enforcedSessionControls=System.Object[]; displayName=test; enforcedGrantControls=System.Object[]; result=notEnabled}...}
isInteractive                    : True
location                         : @{state=Maharashtra; geoCoordinates=; city=Nashik; countryOrRegion=IN}
conditionalAccessStatus          : success
resourceDisplayName              : Windows Azure Service Management API
userPrincipalName                : Test.mail.onmicrosoft.com
riskLevelAggregated              : none
appId                            : 00000000-0000-0000-0000-000000000000
deviceDetail                     : @{browser=Edge 126.0.0; operatingSystem=Windows10; displayName=; isManaged=False; trustType=; isCompliant=False; deviceId=}
riskDetail                       : none
riskState                        : none
status                           : @{errorCode=50055; additionalDetails=The user's password is expired, and therefore their login or session was ended. They will be
                                   offered the opportunity to reset it, or may ask an admin to reset it via
                                   https://learn.microsoft.com/entra/fundamentals/users-reset-password-azure-portal; failureReason=The password is expired.}
ipAddress                        : 223.233.80.208
userId                           : 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
id                               : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
resourceId                       : a0a0a0a0-bbbb-cccc-dddd-e1e1e1e1e1e1
appDisplayName                   : Azure Portal
clientAppUsed                    : Browser
correlationId                    : aaaa0000-bb11-2222-33cc-444444dddddd
riskEventTypes_v2                : {}
riskEventTypes                   : {}
createdDateTime                  : 02/07/2024 04:18:26
riskLevelDuringSignIn            : none
userDisplayName                  : Test User
```

This example returns the first n logs.

### Example 3: Get audit logs containing a given ActivityDisplayName

```powershell
 Get-EntraAuditSignInLogs -Filter "ActivityDisplayName eq 'Add owner to application'"
 Get-EntraAuditSignInLogs -Filter "ActivityDisplayName eq 'Add owner to application'" -Top 1
```

These commands show how to get sign-in logs by ActivityDisplayName.

### Example 4: Get all sign-in logs with a given result

```powershell
 Get-EntraAuditSignInLogs -Filter "result eq 'success'"
 Get-EntraAuditSignInLogs -Filter "result eq 'failure'" -Top 1
```

These commands show how to get sign-in logs by the result.

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
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter

The oData v3.0 filter statement.
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

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Related Links
