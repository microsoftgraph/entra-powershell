---
description: This article provides details on the Get-EntraServicePrincipal command.
external help file: Microsoft.Entra.Applications-Help.xml
Locale: en-US
manager: CelesteDG
Module Name: Microsoft.Entra
ms.author: eunicewaweru
ms.date: 06/26/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/Get-EntraServicePrincipal
schema: 2.0.0
title: Get-EntraServicePrincipal
---

# Get-EntraServicePrincipal

## Synopsis

Gets a service principal.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraServicePrincipal
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetVague

```powershell
Get-EntraServicePrincipal
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraServicePrincipal
 -ServicePrincipalId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## Description

The `Get-EntraServicePrincipal` cmdlet gets a service principal in Microsoft Entra ID.

## Examples

### Example 1: Retrieve all service principal from the directory

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal
```

```Output
ObjectId                             AppId                                DisplayName
--------                             -----                                -----------
bbbbbbbb-1111-2222-3333-cccccccccccc 00001111-aaaa-2222-bbbb-3333cccc4444 Demo App
aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 22223333-cccc-4444-dddd-5555eeee6666 Demo Two App
dddddddd-3333-4444-5555-eeeeeeeeeeee 33334444-dddd-5555-eeee-6666ffff7777 ProjectWorkManagement
```

This example retrieves all service principals from the directory.

### Example 2: Retrieve a service principal by ServicePrincipalId

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
Get-EntraServicePrincipal -ServicePrincipalId $servicePrincipal.Id
```

```Output
DisplayName                         Id                                   AppId                                SignInAudience      ServicePrincipalType
-----------                         --                                   -----                                --------------      --------------------
Helpdesk Application                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMultipleOrgs Application
```

This command retrieves specific service principal.

- `-ServicePrincipalId` Parameter specifies the ID of a service principal.

### Example 3: Retrieve all service principals from the directory

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal -All
```

```Output
DisplayName                         Id                                   AppId                                SignInAudience      ServicePrincipalType
-----------                         --                                   -----                                --------------      --------------------
Helpdesk Application                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMultipleOrgs Application
Microsoft Device Management Checkin bbbbbbbb-1111-2222-3333-cccccccccccc 11112222-bbbb-3333-cccc-4444dddd5555 AzureADMultipleOrgs Application
ProvisioningPowerBi                 cccccccc-2222-3333-4444-dddddddddddd 22223333-cccc-4444-dddd-5555eeee6666                     Application
```

This example retrieves all service principals from the directory.

### Example 4: Retrieve top two service principal from the directory

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal -Top 2
```

```Output
DisplayName                         Id                                   AppId                                SignInAudience      ServicePrincipalType
-----------                         --                                   -----                                --------------      --------------------
Helpdesk Application                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMultipleOrgs Application
Microsoft Device Management Checkin bbbbbbbb-1111-2222-3333-cccccccccccc 11112222-bbbb-3333-cccc-4444dddd5555 AzureADMultipleOrgs Application
```

This command retrieves top two service principals from the directory. You can use `-Limit` as an alias for `-Top`.

### Example 5: Get a service principal by display name

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal -Filter "displayName eq 'Helpdesk Application'"
```

```Output
DisplayName                         Id                                   AppId                                SignInAudience      ServicePrincipalType
-----------                         --                                   -----                                --------------      --------------------
Helpdesk Application                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMultipleOrgs Application
```

This example gets a service principal by its display name.

### Example 6: Retrieve a list of all service principal, which has a display name that contains "Helpdesk Application"

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal -SearchString 'Helpdesk Application'
```

```Output
DisplayName                         Id                                   AppId                                SignInAudience      ServicePrincipalType
-----------                         --                                   -----                                --------------      --------------------
Helpdesk Application                aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 AzureADMultipleOrgs Application
```

This example gets a list of service principal, which has the specified display name.

### Example 7: Retrieve all Enterprise apps

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal -Filter "tags/Any(x: x eq 'WindowsAzureActiveDirectoryIntegratedApp')"
```

```Output
DisplayName         Id                                   AppId                                SignInAudience         ServicePrincipalType
-----------         --                                   -----                                --------------         --------------------
Enterprise App1     00001111-aaaa-2222-bbbb-3333cccc4444 33334444-dddd-5555-eeee-6666ffff7777                         Application
Enterprise App2     11112222-bbbb-3333-cccc-4444dddd5555 22223333-cccc-4444-dddd-5555eeee6666 AzureADMultipleOrgs    Application
```

This example demonstrates how to retrieve all enterprise apps.

### Example 8: Retrieve all App proxy apps

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal -Filter "tags/Any(x: x eq 'WindowsAzureActiveDirectoryOnPremApp')"
```

```Output
DisplayName         Id                                   AppId                                SignInAudience         ServicePrincipalType
-----------         --                                   -----                                --------------         --------------------
App proxy 1     00001111-aaaa-2222-bbbb-3333cccc4444 33334444-dddd-5555-eeee-6666ffff7777                         Application
App proxy 2     11112222-bbbb-3333-cccc-4444dddd5555 22223333-cccc-4444-dddd-5555eeee6666 AzureADMultipleOrgs    Application
```

This example demonstrates how to retrieve all app proxy apps.

### Example 9: Retrieve all disabled apps

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal -Filter "accountEnabled eq false"
```

```Output
DisplayName         Id                                   AppId                                SignInAudience         ServicePrincipalType
-----------         --                                   -----                                --------------         --------------------
Disabled App1     00001111-aaaa-2222-bbbb-3333cccc4444 33334444-dddd-5555-eeee-6666ffff7777                         Application
```

This example demonstrates how to retrieve all disabled apps.

### Example 10: Retrieve all Global Secure Access apps

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal -Filter "tags/Any(x: x eq 'PrivateAccessNonWebApplication') or tags/Any(x: x eq 'NetworkAccessManagedApplication')"
```

```Output
DisplayName         Id                                   AppId                                SignInAudience         ServicePrincipalType
-----------         --                                   -----                                --------------         --------------------
Global secure access app     00001111-aaaa-2222-bbbb-3333cccc4444 33334444-dddd-5555-eeee-6666ffff7777                         Application
```

This example demonstrates how to retrieve all Global secure access apps.

### Example 11: List all applications without user assignment

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraServicePrincipal -All | Where-Object {$_.appRoleAssignmentRequired -ne 'true'}
```

```Output
DisplayName                     Id                                   AppId                                SignInAudience         ServicePrincipalType
-----------                     --                                   -----                                --------------         --------------------
App without user assignment     00001111-aaaa-2222-bbbb-3333cccc4444 33334444-dddd-5555-eeee-6666ffff7777                         Application
```

This example demonstrates how to retrieve all applications without user assignment.

### Example 12: List all SAML application details

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -Filter "PreferredSingleSignOnMode eq 'saml'"
$servicePrincipal | Select-Object Id, DisplayName, AccountEnabled, AppId, PreferredSingleSignOnMode, AppRoleAssignmentRequired, SignInAudience, NotificationEmailAddresses, PreferredTokenSigningKeyEndDateTime, PreferredTokenSigningKeyValid, ReplyUrls,LoginUrl, LogoutUrl | Format-Table -AutoSize
```

```Output
Id                                   DisplayName                           AccountEnabled AppId                                PreferredSingleSignOnMode AppRoleAssignmentRequired SignInAudience NotificationEmailAddresses
--                                   -----------                           -------------- -----                                ------------------------- ------------------------- -------------- --------------
00001111-aaaa-2222-bbbb-3333cccc4444 SAML App                             True            33334444-dddd-5555-eeee-6666ffff7777 saml                              True                    AzureADMyOrg   {admin@Contoso}
```

This example demonstrates how to retrieve all SAML application details.

### Example 13: List service principal app roles

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$servicePrincipal = Get-EntraServicePrincipal -SearchString 'Contoso Helpdesk Application'
$servicePrincipal.AppRoles | Format-Table -AutoSize
```

```Output
AllowedMemberTypes    Description        DisplayName       Id                                   IsEnabled  Origin       Value        
------------------    -----------        -----------       --                                   ---------  ------       -----        
{User, Application}   General All        General All       gggggggg-6666-7777-8888-hhhhhhhhhhhh  True       Application  Survey.Read  
{Application}         General App Only   General Apponly   hhhhhhhh-7777-8888-9999-iiiiiiiiiiii  True       Application  Task.Write   
{User}                General role       General           bbbbbbbb-1111-2222-3333-cccccccccccc  True       Application  General 
```

This example shows how you can retrieve app roles for a service principal.

### Example 14: List applications (service principals) outside my tenant

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$tenantId = Get-EntraContext | Select-Object -ExpandProperty TenantId
$servicePrincipals = Get-EntraServicePrincipal -All -Property AppOwnerOrganizationId, Id, DisplayName, AppId
$externalServicePrincipals = $servicePrincipals | Where-Object { $_.AppOwnerOrganizationId -ne $tenantId }
$externalServicePrincipals | Select-Object DisplayName, Id, AppId, AppOwnerOrganizationId | Format-Table -AutoSize
```

```Output
DisplayName                                             Id                                   AppId                                AppOwnerOrganizationId
-----------                                             --                                   -----                                ----------------------
Azure MFA StrongAuthenticationService                   aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb 00001111-aaaa-2222-bbbb-3333cccc4444 f8cdef31-a31e-4b4a-93e4-5f571e91255a
M365 Label Analytics                                    bbbbbbbb-1111-2222-3333-cccccccccccc 11112222-bbbb-3333-cccc-4444dddd5555 f8cdef31-a31e-4b4a-93e4-5f571e91255a
PowerApps-Advisor                                       cccccccc-2222-3333-4444-dddddddddddd 22223333-cccc-4444-dddd-5555eeee6666 f8cdef31-a31e-4b4a-93e4-5f571e91255a 
```

This example shows how you can retrieve applications (service principals) outside my tenant.

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

### -ServicePrincipalId

Specifies the ID of a service principal in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetById
Aliases: ObjectId

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

## Inputs

## Outputs

## Notes

## Related links

[Get-EntraServicePrincipal](Get-EntraServicePrincipal.md)

[Remove-EntraServicePrincipal](Remove-EntraServicePrincipal.md)

[Set-EntraServicePrincipal](Set-EntraServicePrincipal.md)
