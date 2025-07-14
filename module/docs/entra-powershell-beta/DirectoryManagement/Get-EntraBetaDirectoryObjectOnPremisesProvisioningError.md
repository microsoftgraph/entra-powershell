---
author: msewaweru
description: This article provides details on the Get-EntraBetaDirectoryObjectOnPremisesProvisioningError command.
external help file: Microsoft.Entra.Beta.DirectoryManagement-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 01/26/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Get-EntraBetaDirectoryObjectOnPremisesProvisioningError
schema: 2.0.0
title: Get-EntraBetaDirectoryObjectOnPremisesProvisioningError
---

# Get-EntraBetaDirectoryObjectOnPremisesProvisioningError

## SYNOPSIS

Returns directory synchronization errors when synchronizing on-premises directories to Microsoft Entra ID.

## SYNTAX

```powershell
Get-EntraBetaDirectoryObjectOnPremisesProvisioningError
 [-TenantId <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaDirectoryObjectOnPremisesProvisioningError` returns directory synchronization errors for the `user`, `group`, or `organizational contact` entities when synchronizing on-premises directories to Microsoft Entra ID.

## EXAMPLES

### Example 1: Return whether Microsoft Entra ID has objects with DirSync provisioning error

```powershell
Connect-Entra -Scopes 'User.Read.All', 'Directory.Read.All', 'Group.Read.All', 'Contacts.Read'
Get-EntraBetaDirectoryObjectOnPremisesProvisioningError | Format-Table -AutoSize
```

```Output
Id                                   PropertyCausingError UserPrincipalName Category         Value                                      OccurredDateTime      DisplayName           OnPremisesSyncEnabled Mail                
--                                   -------------------- ----------------- --------         -----                                      ----------------      -----------           --------------------- ----                
cccccccc-2222-3333-4444-dddddddddddd ProxyAddresses                         PropertyConflict SMTP:ConflictMail@contoso.com           3/14/2022 11:46:44 PM ConflictMail1                          True                
eeeeeeee-4444-5555-6666-ffffffffffff UserPrincipalName                      PropertyConflict BlockSoftMatch1@contoso.com             7/4/2024 12:06:16 AM  BlockSoftMatch1                        True                
```

This command lists directory sync errors for `users`, `groups`, or `organizational contacts` during on-premises synchronization to Microsoft Entra ID.

### Example 2: Get directory synchronization errors with filtering

```powershell
Connect-Entra -Scopes 'User.Read.All', 'Directory.Read.All', 'Group.Read.All', 'Contacts.Read'
Get-EntraBetaDirectoryObjectOnPremisesProvisioningError | where-Object propertyCausingError -eq 'UserPrincipalName' | Format-Table -AutoSize
```

```Output
Id                                   PropertyCausingError UserPrincipalName Category         Value                                      OccurredDateTime      DisplayName           OnPremisesSyncEnabled Mail                
--                                   -------------------- ----------------- --------         -----                                      ----------------      -----------           --------------------- ----                
cccccccc-2222-3333-4444-dddddddddddd ProxyAddresses                         PropertyConflict SMTP:ConflictMail@contoso.com           3/14/2022 11:46:44 PM ConflictMail1                          True                
eeeeeeee-4444-5555-6666-ffffffffffff UserPrincipalName                      PropertyConflict BlockSoftMatch1@contoso.com             7/4/2024 12:06:16 AM  BlockSoftMatch1                        True                
```

This command lists directory sync errors for `users`, `groups`, or `organizational contacts` during on-premises synchronization to Microsoft Entra ID.

### Example 3: Get directory synchronization errors for a specific tenant

```powershell
Connect-Entra -Scopes 'User.Read.All', 'Directory.Read.All', 'Group.Read.All', 'Contacts.Read'
$tenant = Get-EntraBetaTenantDetail
Get-EntraBetaDirectoryObjectOnPremisesProvisioningError -TenantId $tenant.Id | Format-Table -AutoSize
```

```Output
Id                                   PropertyCausingError UserPrincipalName Category         Value                                      OccurredDateTime      DisplayName           OnPremisesSyncEnabled Mail                
--                                   -------------------- ----------------- --------         -----                                      ----------------      -----------           --------------------- ----                
cccccccc-2222-3333-4444-dddddddddddd ProxyAddresses                         PropertyConflict SMTP:ConflictMail@contoso.com           3/14/2022 11:46:44 PM ConflictMail1                          True                
eeeeeeee-4444-5555-6666-ffffffffffff UserPrincipalName                      PropertyConflict BlockSoftMatch1@contoso.com             7/4/2024 12:06:16 AM  BlockSoftMatch1                        True                
```

This command lists directory sync errors for `users`, `groups`, or `organizational contacts` during on-premises synchronization to Microsoft Entra ID.

- `-TenantId` Specifies the unique ID of the tenant.

## PARAMETERS

### -TenantId

The unique tenant ID for the operation. This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user's tenant ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Nullable`1[[System.Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]

## OUTPUTS

## NOTES

## RELATED LINKS
