---
author: msewaweru
description: This article provides details on the Set-EntraBetaAppRoleToApplicationUser command.
external help file: Microsoft.Entra.Beta.Governance-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra.Beta
ms.author: eunicewaweru
ms.date: 04/10/2025
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/Set-EntraBetaAppRoleToApplicationUser
schema: 2.0.0
title: Set-EntraBetaAppRoleToApplicationUser
---

# Set-EntraBetaAppRoleToApplicationUser

## SYNOPSIS

Add existing application users to Microsoft Entra ID and assign them roles.

## SYNTAX

### Default

```powershell
Set-EntraBetaAppRoleToApplicationUser
 -DataSource <String>
 -FilePath <System.IO.FileInfo>
 -ApplicationName <String>
 [-SignInAudience <String>]
 [<CommonParameters>]
```

### ExportResults

```powershell
Set-EntraBetaAppRoleToApplicationUser
 -DataSource <String>
 -FilePath <System.IO.FileInfo>
 -ApplicationName <String>
 [-SignInAudience <String>]
 [-Export]
 [-ExportFilePath <System.IO.FileInfo>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Set-EntraBetaAppRoleToApplicationUser` command adds existing users (for example, from a Helpdesk or billing application) to Microsoft Entra ID and assigns them app roles like Admin, Audit, or Reports. This enables the application unlock Microsoft Entra ID Governance features like access reviews. 

This feature requires a Microsoft Entra ID Governance or Microsoft Entra Suite license, see [Microsoft Entra ID Governance licensing fundamentals](https://learn.microsoft.com/entra/id-governance/licensing-fundamentals).

In delegated scenarios, the signed-in user must have either a supported Microsoft Entra role or a custom role with the necessary permissions. The minimum roles required for this operation are:

- User Administrator (create users)
- Application Administrator
- Identity Governance Administrator (manage application role assignments)

## EXAMPLES

### Example 1: Assign application users to app role assignments

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All', 'Application.ReadWrite.All', 'AppRoleAssignment.ReadWrite.All', 'EntitlementManagement.ReadWrite.All'
Set-EntraBetaAppRoleToApplicationUser -DataSource "Generic" -FilePath "C:\temp\users.csv" -ApplicationName "TestApp"
```

This example assigns users to app roles. It creates missing users and app roles. If a role assignment doesn't exist, it's created; otherwise, it's skipped.

- `-DataSource` parameter specifies the source of the data, for example, SAP Identity, database, or directory. The value determines the attribute matching. For example, For SAP Cloud Identity Services, the default mapping is `userName` (SAP SCIM) to `userPrincipalName` (Microsoft Entra ID). For databases or directories, the `Email` column value might match the `userPrincipalName` in Microsoft Entra ID.
- `-FilePath` parameter specifies the path to the input file containing users, for example, `C:\temp\users.csv`.
- `-ApplicationName` parameter specifies the application name in Microsoft Entra ID.

### Example 2: Assign application users to app role assignments with verbose mode

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All', 'Application.ReadWrite.All', 'AppRoleAssignment.ReadWrite.All', 'EntitlementManagement.ReadWrite.All'
Set-EntraBetaAppRoleToApplicationUser -DataSource "SAPCloudIdentity" -FilePath "C:\temp\users-exported-from-sap.csv" -ApplicationName "TestApp" -Verbose
```

This example assigns users to app roles. It creates missing users and app roles. If a role assignment doesn't exist, it's created; otherwise, it's skipped.

- `-DataSource` parameter specifies the source of the data, for example, SAP Identity, database, or directory. The value determines the attribute matching. For example, For SAP Cloud Identity Services, the default mapping is `userName` (SAP SCIM) to `userPrincipalName` (Microsoft Entra ID). For databases or directories, the `Email` column value might match the `userPrincipalName` in Microsoft Entra ID.
- `-FilePath` parameter specifies the path to the input file containing users, for example, `C:\temp\users.csv`.
- `-ApplicationName` parameter specifies the application name in Microsoft Entra ID.
- `-Verbose` common parameter outputs the execution steps during processing.

### Example 3: Assign application users to app roles and export to a default location

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All', 'Application.ReadWrite.All', 'AppRoleAssignment.ReadWrite.All', 'EntitlementManagement.ReadWrite.All'
Set-EntraBetaAppRoleToApplicationUser -DataSource "Generic" -FilePath "C:\temp\users.csv" -ApplicationName "TestApp" -Export -Verbose
```

This example assigns users to app roles. It creates missing users and app roles. If a role assignment doesn't exist, it's created; otherwise, it's skipped.

- `-DataSource` parameter specifies the source of the data, for example, SAP Identity, database, or directory. The value determines the attribute matching. For example, For SAP Cloud Identity Services, the default mapping is `userName` (SAP SCIM) to `userPrincipalName` (Microsoft Entra ID). For databases or directories, the `Email` column value might match the `userPrincipalName` in Microsoft Entra ID.
- `-FilePath` parameter specifies the path to the input file containing users, for example, `C:\temp\users.csv`.
- `-ApplicationName` parameter specifies the application name in Microsoft Entra ID.
- `-Export` switch parameter enables export of results into a CSV file. If `ExportFilePath` parameter isn't provided, results are exported in the current location.
- `-Verbose` common parameter outputs the execution steps during processing.

### Example 4: Assign application users to app roles and export to a specified location

```powershell
Connect-Entra -Scopes 'User.ReadWrite.All', 'Application.ReadWrite.All', 'AppRoleAssignment.ReadWrite.All', 'EntitlementManagement.ReadWrite.All'
Set-EntraBetaAppRoleToApplicationUser -DataSource "Generic" -FilePath "C:\temp\users.csv" -ApplicationName "TestApp" -Export -ExportFilePath "C:\temp\EntraAppRoleAssignments_yyyyMMdd.csv" -Verbose
```

This example assigns users to app roles. It creates missing users and app roles. If a role assignment doesn't exist, it's created; otherwise, it's skipped.

- `-DataSource` parameter specifies the source of the data, for example, SAP Identity, database, or directory. The value determines the attribute matching. For example, For SAP Cloud Identity Services, the default mapping is `userName` (SAP SCIM) to `userPrincipalName` (Microsoft Entra ID). For databases or directories, the `Email` column value might match the `userPrincipalName` in Microsoft Entra ID.
- `-FilePath` parameter specifies the path to the input file containing users, for example, `C:\temp\users.csv`.
- `-ApplicationName` parameter specifies the application name in Microsoft Entra ID.
- `-Export` switch parameter enables export of results into a CSV file. If `ExportFilePath` parameter isn't provided, results are exported in the current location.
- `-ExportFilePath` parameter specifies a specific filename and location to export results.
- `-Verbose` common parameter outputs the execution steps during processing.

## PARAMETERS

### -DataSource

Specifies the source of the data, for example, SAP Identity, database, or directory. The value determines the attribute matching. For example, For SAP Cloud Identity Services, the default mapping is `userName` (SAP SCIM) to `userPrincipalName` (Microsoft Entra ID). For databases or directories, the `Email` column value might match the `userPrincipalName` in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath

Specifies the path to the input file containing users, for example, `C:\temp\users.csv`.

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

### -SignInAudience

Specifies what Microsoft accounts are supported for the application. Options are "AzureADMyOrg", "AzureADMultipleOrgs", "AzureADandPersonalMicrosoftAccount" and "PersonalMicrosoftAccount".

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: AzureADMyOrg
Accept pipeline input: False
Accept wildcard characters: False
```

### -Export

Enables export of results into a CSV file. If `ExportFilePath` parameter isn't provided, results are exported in the current location.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: ExportResults
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExportFilePath

Specifies a specific filename and location to export results.

```yaml
Type: System.IO.FileInfo
Parameter Sets: ExportResults
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

### System.String

## OUTPUTS

### System.Object

## NOTES

How to [Govern an application's existing users](https://learn.microsoft.com/entra/id-governance/identity-governance-applications-existing-users)

## RELATED LINKS

[Get-EntraBetaServicePrincipalAppRoleAssignedTo](../Applications/Get-EntraBetaServicePrincipalAppRoleAssignedTo.md)

[New-EntraBetaServicePrincipalAppRoleAssignment](../Applications/New-EntraBetaServicePrincipalAppRoleAssignment.md)
