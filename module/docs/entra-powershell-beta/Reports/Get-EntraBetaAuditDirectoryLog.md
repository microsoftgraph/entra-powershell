---
author: msewaweru
description: This article provides details on the Get-EntraBetaAuditDirectoryLog command.
external help file: Microsoft.Entra.Beta.Reports-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Reports
ms.author: eunicewaweru
ms.date: 02/08/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Reports/Get-EntraBetaAuditDirectoryLog
schema: 2.0.0
title: Get-EntraBetaAuditDirectoryLog
---

# Get-EntraBetaAuditDirectoryLog

## SYNOPSIS

Get directory audit logs.

## SYNTAX

```powershell
Get-EntraBetaAuditDirectoryLog
 [-All]
 [-Top <Int32>]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaAuditDirectoryLog` cmdlet gets a Microsoft Entra ID audit log.
Retrieve audit logs from Microsoft Entra ID, covering logs from various services such as user, app, device, and group management, privileged identity management (PIM), access reviews, terms of use, identity protection, password management (SSPR and admin resets), and self-service group management.

In delegated scenarios with work or school accounts, the signed-in user must have a supported Microsoft Entra role or custom role with the necessary permissions. The following least privileged roles support this operation:

- Reports Reader
- Security Administrator
- Security Reader

## EXAMPLES

### Example 1: Get all logs

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
Get-EntraBetaAuditDirectoryLog -All
```

```Output
Id                                                             ActivityDateTime    ActivityDisplayName                     Category              CorrelationId
--                                                             ----------------    -------------------                     --------              -------------
Directory_aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 17/07/2024 08:55:34 Add service principal                   ApplicationManagement aaaa0000-bb11-2222-33cc-444444dddddd
Directory_bbbbbbbb-1111-2222-3333-cccccccccccc  17/07/2024 07:31:54 Update user                             UserManagement       bbbb1111-cc22-3333-44dd-555555eeeeee
SSGM_cccccccc-2222-3333-4444-dddddddddddd      17/07/2024 07:13:08 GroupsODataV4_GetgroupLifecyclePolicies GroupManagement       cccc2222-dd33-4444-55ee-666666ffffff

```

This command gets all audit logs.

### Example 2: List audit logs of group creation

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
$groupId = (Get-EntraBetaGroup -SearchString 'Woodgrove DevOps').Id
Get-EntraBetaAuditDirectoryLog -Filter "
    activityDisplayName eq 'Add group' 
    and targetResources/any(r:r/id eq '$groupId')"
```

```Output
Id                                      ActivityDateTime      ActivityDisplayName Category        CorrelationId                          LoggedByService  OperationType Result  ResultReason
--                                      ----------------      ------------------- --------        -------------                          ---------------  ------------- ------  ------------
Directory_aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 03/06/2025 22:22:17 Add group        GroupManagement aaaa0000-bb11-2222-33cc-444444dddddd Core Directory  Add           success
```

This command gets all audit logs of group creation.

### Example 3: Retrieve recent group creation audit logs

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
Get-EntraBetaAuditDirectoryLog -Filter "activityDisplayName eq 'Add group'" -Limit 5 |
Select-Object id, activityDateTime, 
              @{Name="InitiatedByUPN"; Expression={ $_.initiatedBy.user.userPrincipalName }},
              result, 
              @{Name="GroupDisplayName"; Expression={ $_.targetResources[0].displayName }} |
Format-Table -AutoSize
```

```Output
Id                                      ActivityDateTime      InitiatedByUPN                Result  GroupDisplayName
--                                      ----------------      --------------                ------  ----------------
Directory_11111111-2222-3333-4444-555555555555  03/07/2025 18:30:45 admin@contoso.com        success Woodgrove Developers
Directory_aaaa0000-bb11-2222-33cc-444444dddddd  03/06/2025 22:22:17 user1@contoso.com       success Woodgrove DevOps
Directory_99999999-8888-7777-6666-555555555555  03/05/2025 15:10:12 admin2@contoso.com      success Security Team
```

This command retrieves recent group creation audit logs.

### Example 4: Show user's updated authentication method details

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
$userId = (Get-EntraBetaUser -UserId 'sawyerM@contoso.com').Id
Get-EntraBetaAuditDirectoryLog -Filter "category eq 'UserManagement' and LoggedByService eq 'Authentication Methods' and targetResources/any(r:r/id eq '$userId')"
```

```Output
Id                                       ActivityDateTime      ActivityDisplayName             Category        CorrelationId                          LoggedByService                  OperationType  Result   ResultReason
--                                       ----------------      -------------------             --------        -------------                          ---------------                  -------------  ------   ------------
Authentication Methods_{GUID}  02/17/2025 13:20:08  User registered security info   UserManagement  aaaa0000-bb11-2222-33cc-444444dddddd  Authentication Methods ServiceApi   success  User registered Fido2 Authentication Method
Authentication Methods_{GUID}  02/17/2025 13:19:57  Get passkey creation options    UserManagement  bbbb1111-cc22-3333-44dd-555555eeeeee  Authentication Methods ServiceApi   success  Successfully retrieved passkey creation options.
Authentication Methods_{GUID}  02/15/2025 17:38:02  User registered security info   UserManagement  cccc2222-dd33-4444-55ee-666666ffffff  Authentication Methods ServiceApi   success  User registered temporary access pass method
```

This command retrieves user's updated authentication method details.

### Example 5: List quarantined provisioning jobs

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
Get-EntraBetaAuditDirectoryLog -Filter "activityDisplayName eq 'Quarantine'" -Limit 1 |
Select-Object Id, ActivityDateTime, ActivityDisplayName, Category, LoggedByService, Result, 
              ResultReason, 
              @{Name="InitiatedByDisplayName"; Expression={ $_.targetResources[0].displayName }}
```

```Output
id                     : Sync_{GUID}
activityDateTime       : 02/14/2025 04:23:38
activityDisplayName    : Quarantine
category               : ProvisioningManagement
loggedByService        : Account Provisioning
result                 : failure
resultReason           : This run profile is being quarantined because of: EncounteredQuarantineException; Error: Your ServiceNow credentials are invalid. Please obtain valid ServiceNow credentials, navigate to your ServiceNow enterprise application in the Azure Portal, and ente
                         r those details in the admin credentials section of the provisioning configuration page. For directions on how to input credentials into your application, review the tutorial specific to ServiceNow found here: https://docs.microsoft.com/en-us/azure/activ
                         e-directory/saas-apps/servicenow-provisioning-tutorial
InitiatedByDisplayName : ServiceNow
```

This command retrieves quarantined provisioning jobs.

### Example 6: Get first n logs

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
Get-EntraBetaAuditDirectoryLog -Top 1
```

```Output
Id                                                             ActivityDateTime    ActivityDisplayName   Category              CorrelationId                        LoggedB
                                                                                                                                                                    yServic
                                                                                                                                                                    e
--                                                             ----------------    -------------------   --------              -------------                        -------
Directory_aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb_8IAPT_617717139 17/07/2024 08:55:34 Add service principal ApplicationManagement aaaa0000-bb11-2222-33cc-444444dddddd Core...

```

This example returns the first N logs. You can use `-Limit` as an alias for `-Top`.

### Example 7: Get audit logs containing a given ActivityDisplayName

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
Get-EntraBetaAuditDirectoryLog -Filter "ActivityDisplayName eq 'Update rollout policy of feature'" -Top 1
```

```Output
Id                                                                   ActivityDateTime    ActivityDisplayName              Category       CorrelationId
--                                                                   ----------------    -------------------              --------       -------------
Application Proxy_aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 16/07/2024 05:13:49 Update rollout policy of feature Authentication aaaa0000-bb11-2222-33cc-444444dddddd
```

This command shows how to get audit logs by ActivityDisplayName. You can use `-Limit` as an alias for `-Top`.

### Example 8: Get all audit logs with a given result

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
Get-EntraBetaAuditDirectoryLog -Filter "result eq 'failure'" -All
```

This command shows how to get audit logs by the result.

### Example 9: Show when users were added to a group

```powershell
Connect-Entra -Scopes 'AuditLog.Read.All, Directory.Read.All'
$groupId = (Get-EntraBetaGroup -SearchString 'Contoso Group').Id
Get-EntraBetaAuditDirectoryLog -Filter "
    activityDisplayName eq 'Add member to group' 
    and targetResources/any(r:r/type eq 'User') 
    and targetResources/any(r:r/id eq '$groupId' and r/type eq 'Group')"
```

```Output
Id                                      ActivityDateTime      ActivityDisplayName   Category        CorrelationId                          LoggedByService   OperationType Result  ResultReason
--                                      ----------------      -------------------   --------        -------------                          ---------------   ------------- ------  ------------
Directory_{GUID}  03/07/2025 23:16:31   Add member to group   GroupManagement       aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb  Core Directory   Assign        success
```

This command shows when users were added to a group.

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

## INPUTS

## OUTPUTS

## NOTES

`Get-EntraBetaAuditDirectoryLogs` is an alias for `Get-EntraBetaAuditDirectoryLog`.

## RELATED LINKS
