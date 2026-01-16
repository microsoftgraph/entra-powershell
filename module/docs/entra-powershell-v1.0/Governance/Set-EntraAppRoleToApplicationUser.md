---
title: Set-EntraAppRoleToApplicationUser
description: This article provides details on the Set-EntraAppRoleToApplicationUser command.

ms.topic: reference
ms.date: 02/28/2025
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru

external help file: Microsoft.Entra.Governance-Help.xml
Module Name: Microsoft.Entra
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Set-EntraAppRoleToApplicationUser

schema: 2.0.0
---

# Set-EntraAppRoleToApplicationUser

## Synopsis

Add existing application users to Microsoft Entra ID and assign them roles.

## Syntax

### Default

```powershell
Set-EntraAppRoleToApplicationUser
 -DataSource <String>
 -FileName <System.IO.FileInfo>
 -ApplicationName <String>
 [<CommonParameters>]
```

### ExportResults

```powershell
Set-EntraAppRoleToApplicationUser
 -DataSource <String>
 -FileName <System.IO.FileInfo>
 -ApplicationName <String>
 -Export
 -ExportFileName <System.IO.FileInfo>
 [<CommonParameters>]
```

## Description

The `Set-EntraAppRoleToApplicationUser` command adds existing users (for example, from a Helpdesk or billing application) to Microsoft Entra ID and assigns them app roles like Admin, Audit, or Reports. This enables the application unlock Microsoft Entra ID Governance features like access reviews. 

This feature requires a Microsoft Entra ID Governance or Microsoft Entra Suite license, see [Microsoft Entra ID Governance licensing fundamentals](https://learn.microsoft.com/entra/id-governance/licensing-fundamentals).

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- User Administrator (create users)
- Application Administrator
- Identity Governance Administrator (manage application role assignments)

## Examples

### Example 1: Assign application users to app role assignments

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All', 'Application.ReadWrite.All', 'AppRoleAssignment.ReadWrite.All', 'EntitlementManagement.ReadWrite.All'
Set-EntraAppRoleToApplicationUser -DataSource "Generic" -FileName "C:\temp\users.csv" -ApplicationName "TestApp"
```

This example assigns users to app roles. It creates missing users and app roles. If a role assignment doesn't exist, it's created; otherwise, it's skipped.

- `-DataSource` parameter specifies the source of the data, for example, SAP Identity, database, or directory. The value determines the attribute matching. For example, For SAP Cloud Identity Services, the default mapping is `userName` (SAP SCIM) to `userPrincipalName` (Microsoft Entra ID). For databases or directories, the `Email` column value might match the `userPrincipalName` in Microsoft Entra ID.
- `-FileName` parameter specifies the path to the input file containing users, for example, C:\temp\users.csv.
- `-ApplicationName` parameter specifies the application name in Microsoft Entra ID.

### Example 2: Assign application users to app role assignments with verbose mode

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All', 'Application.ReadWrite.All', 'AppRoleAssignment.ReadWrite.All', 'EntitlementManagement.ReadWrite.All'
Set-EntraAppRoleToApplicationUser -DataSource "SAPCloudIdentity" -FileName "C:\temp\users-exported-from-sap.csv" -ApplicationName "TestApp" -Verbose
```

This example assigns users to app roles. It creates missing users and app roles. If a role assignment doesn't exist, it's created; otherwise, it's skipped.

- `-DataSource` parameter specifies the source of the data, for example, SAP Identity, database, or directory. The value determines the attribute matching. For example, For SAP Cloud Identity Services, the default mapping is `userName` (SAP SCIM) to `userPrincipalName` (Microsoft Entra ID). For databases or directories, the `Email` column value might match the `userPrincipalName` in Microsoft Entra ID.
- `-FileName` parameter specifies the path to the input file containing users, for example, C:\temp\users.csv.
- `-ApplicationName` parameter specifies the application name in Microsoft Entra ID.
- `-Verbose` common parameter outputs the execution steps during processing.

### Example 3: Assign application users to app roles and export to a default location

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All', 'Application.ReadWrite.All', 'AppRoleAssignment.ReadWrite.All', 'EntitlementManagement.ReadWrite.All'
Set-EntraAppRoleToApplicationUser -DataSource "Generic" -FileName "C:\temp\users.csv" -ApplicationName "TestApp" -Export -Verbose
```

This example assigns users to app roles. It creates missing users and app roles. If a role assignment doesn't exist, it's created; otherwise, it's skipped.

- `-DataSource` parameter specifies the source of the data, for example, SAP Identity, database, or directory. The value determines the attribute matching. For example, For SAP Cloud Identity Services, the default mapping is `userName` (SAP SCIM) to `userPrincipalName` (Microsoft Entra ID). For databases or directories, the `Email` column value might match the `userPrincipalName` in Microsoft Entra ID.
- `-FileName` parameter specifies the path to the input file containing users, for example, C:\temp\users.csv.
- `-ApplicationName` parameter specifies the application name in Microsoft Entra ID.
- `-Export` switch parameter enables export of results into a CSV file. If `ExportFileName` parameter isn't provided, results are exported in the current location.
- `-Verbose` common parameter outputs the execution steps during processing.

### Example 4: Assign application users to app roles and export to a specified location

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All', 'Application.ReadWrite.All', 'AppRoleAssignment.ReadWrite.All', 'EntitlementManagement.ReadWrite.All'
Set-EntraAppRoleToApplicationUser -DataSource "Generic" -FileName "C:\temp\users.csv" -ApplicationName "TestApp" -Export -ExportFileName "C:\temp\EntraAppRoleAssignments_yyyyMMdd.csv" -Verbose
```

This example assigns users to app roles. It creates missing users and app roles. If a role assignment doesn't exist, it's created; otherwise, it's skipped.

- `-DataSource` parameter specifies the source of the data, for example, SAP Identity, database, or directory. The value determines the attribute matching. For example, For SAP Cloud Identity Services, the default mapping is `userName` (SAP SCIM) to `userPrincipalName` (Microsoft Entra ID). For databases or directories, the `Email` column value might match the `userPrincipalName` in Microsoft Entra ID.
- `-FileName` parameter specifies the path to the input file containing users, for example, C:\temp\users.csv.
- `-ApplicationName` parameter specifies the application name in Microsoft Entra ID.
- `-Export` switch parameter enables export of results into a CSV file. If `ExportFileName` parameter isn't provided, results are exported in the current location.
- `-ExportFileName` parameter specifies a specific filename and location to export results.
- `-Verbose` common parameter outputs the execution steps during processing.

## Parameters

### -DataSource

Specifies the source of the data, for example, SAP Identity, database, or directory. The value determines the attribute matching. For example, For SAP Cloud Identity Services, the default mapping is `userName` (SAP SCIM) to `userPrincipalName` (Microsoft Entra ID). For databases or directories, the `Email` column value might match the `userPrincipalName` in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: 
Accept wildcard characters: False
```

### -FileName

Specifies the path to the input file containing users, for example, C:\temp\users.csv.

```yaml
Type: System.IO.FileInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ApplicationName

Specifies the application name in Microsoft Entra ID.

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

### -Export

Enables export of results into a CSV file. If `ExportFileName` parameter isn't provided, results are exported in the current location.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (ExportResults)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExportFileName

Specifies a specific filename and location to export results.

```yaml
Type: System.IO.FileInfo
Parameter Sets: (ExportResults)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

## Outputs

### System.Object

## Notes

[Govern an application's existing users](https://learn.microsoft.com/entra/id-governance/identity-governance-applications-existing-users)

## Related Links

[Get-EntraServicePrincipalAppRoleAssignedTo](../Applications/Get-EntraServicePrincipalAppRoleAssignedTo.md)

[New-EntraServicePrincipalAppRoleAssignment](../Applications/New-EntraServicePrincipalAppRoleAssignment.md)
