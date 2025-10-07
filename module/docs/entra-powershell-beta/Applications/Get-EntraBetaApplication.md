---
author: msewaweru
description: This article provides details on the Get-EntraBetaApplication command.
external help file: Microsoft.Entra.Beta.Applications-Help.xml
Locale: en-US
manager: mwongerapk
Module Name: Microsoft.Entra.Beta.Applications
ms.author: eunicewaweru
ms.date: 06/17/2024
ms.reviewer: stevemutungi
ms.topic: reference
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta.Applications/Get-EntraBetaApplication
schema: 2.0.0
title: Get-EntraBetaApplication
---

# Get-EntraBetaApplication

## SYNOPSIS

Gets an application.

## SYNTAX

### GetQuery (Default)

```powershell
Get-EntraBetaApplication
 [-Top <Int32>]
 [-All]
 [-Filter <String>]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetByValue

```powershell
Get-EntraBetaApplication
 [-SearchString <String>]
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraBetaApplication
 -ApplicationId <String>
 [-All]
 [-Property <String[]>]
 [<CommonParameters>]
```

## DESCRIPTION

The `Get-EntraBetaApplication` cmdlet gets a Microsoft Entra ID application.

## EXAMPLES

### Example 1: Get an application by ApplicationId

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplication -ApplicationId 'aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb'
```

```Output
DisplayName         Id                                   AppId                                SignInAudience PublisherDomain
-----------         --                                   -----                                -------------- ---------------
ToGraph_443democc3c aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADMyOrg   contoso.com
```

This example demonstrates how to retrieve specific application by providing ID.

### Example 2: Get all applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplication -All
```

```Output
DisplayName         Id                                   AppId                                SignInAudience                     PublisherDomain
-----------         --                                   -----                                --------------                     ---------------
test app            aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADandPersonalMicrosoftAccount contoso.com
ToGraph_443DEM      cccccccc-4444-5555-6666-dddddddddddd dddddddd-5555-6666-7777-eeeeeeeeeeee AzureADMyOrg                       contoso.com
test adms           eeeeeeee-6666-7777-8888-ffffffffffff ffffffff-7777-8888-9999-gggggggggggg AzureADandPersonalMicrosoftAccount contoso.com
test adms app azure gggggggg-8888-9999-aaaa-hhhhhhhhhhhh hhhhhhhh-9999-aaaa-bbbb-iiiiiiiiiiii AzureADandPersonalMicrosoftAccount contoso.com
test adms2          iiiiiiii-aaaa-bbbb-cccc-jjjjjjjjjjjj jjjjjjjj-bbbb-cccc-dddd-kkkkkkkkkkkk AzureADandPersonalMicrosoftAccount contoso.com
```

This example demonstrates how to get all applications from Microsoft Entra ID.

### Example 3: Get all applications without owners (ownerless applications)

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$apps = Get-EntraBetaApplication -All
$appsWithoutOwners = @()
foreach ($app in $apps) {
    try {
        $owners = Get-EntraBetaApplicationOwner -ApplicationId $app.Id
        if (-not $owners) {
            $appsWithoutOwners += $app
        }
    }
    catch {
        Write-Warning "Failed to check owners for app: $($app.DisplayName)"
    }

    # Optional: throttle to avoid rate limits (especially in large tenants)
    #Start-Sleep -Milliseconds 100
}
$appsWithoutOwners | Select-Object DisplayName, Id, AppId
```

```Output
DisplayName          Id                                   AppId
-----------          --                                   -----
Contoso HR App       aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc
Contoso Helpdesk App cccccccc-4444-5555-6666-dddddddddddd dddddddd-5555-6666-7777-eeeeeeeeeeee
Contoso Helpdesk App eeeeeeee-6666-7777-8888-ffffffffffff hhhhhhhh-9999-aaaa-bbbb-iiiiiiiiiiii
```

This example demonstrates how to get all applications without owners from Microsoft Entra ID.

### Example 4: Get applications with expiring secrets in 30 days

```powershell
$expirationThreshold = (Get-Date).AddDays(30)
$appsWithExpiringPasswords = Get-EntraBetaApplication -All | Where-Object { $_.PasswordCredentials } |
ForEach-Object {
    $app = $_
    $app.PasswordCredentials | Where-Object { $_.EndDate -le $expirationThreshold } |
    ForEach-Object {
        [PSCustomObject]@{
            DisplayName       = $app.DisplayName
            AppId             = $app.AppId
            SecretDisplayName = $_.DisplayName
            KeyId             = $_.KeyId
            ExpiringSecret    = $_.EndDate
        }
    }
}
$appsWithExpiringPasswords | Format-Table DisplayName, AppId, SecretDisplayName, KeyId, ExpiringSecret -AutoSize
```

```Output
DisplayName             AppId                                SecretDisplayName    KeyId                                ExpiringSecret
-----------             -----                                -----------------    -----                                --------------
Helpdesk Application    dddddddd-5555-6666-7777-eeeeeeeeeeee Helpdesk Password    aaaaaaaa-0b0b-1c1c-2d2d-333333333333 11/18/2024
```

This example retrieves applications with expiring secrets within 30 days.

### Example 5: Get applications with expiring certificates in 30 days

```powershell
$expirationThreshold = (Get-Date).AddDays(30)
$appsWithExpiringKeys = Get-EntraBetaApplication -All | Where-Object { $_.KeyCredentials } |
ForEach-Object {
    $app = $_
    $app.KeyCredentials | Where-Object { $_.EndDate -le $expirationThreshold } |
    ForEach-Object {
        [PSCustomObject]@{
            DisplayName            = $app.DisplayName
            AppId                  = $app.AppId
            CertificateDisplayName = $_.DisplayName
            KeyId                  = $_.KeyId
            ExpiringKeys           = $_.EndDate
        }
    }
}
$appsWithExpiringKeys | Format-Table DisplayName, AppId, CertificateDisplayName, KeyId, ExpiringKeys -AutoSize
```

```Output
DisplayName             AppId                                CertificateDisplayName KeyId                                ExpiringKeys
-----------             -----                                ---------------------- -----                                ------------
Helpdesk Application dddddddd-5555-6666-7777-eeeeeeeeeeee My cert                aaaaaaaa-0b0b-1c1c-2d2d-333333333333 6/27/2024 11:49:17 AM
```

This example retrieves applications with expiring certificates within 30 days.

### Example 6: Get an application by display name

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplication -Filter "DisplayName eq 'ToGraph_443DEMO'"
```

```Output
DisplayName     Id                                   AppId                                SignInAudience PublisherDomain
-----------     --                                   -----                                -------------- ---------------
ToGraph_443DEMO cccccccc-4444-5555-6666-dddddddddddd dddddddd-5555-6666-7777-eeeeeeeeeeee AzureADMyOrg   contoso.com
```

In this example, we retrieve application by its display name from Microsoft Entra ID.

### Example 7: Search among retrieved applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplication -SearchString 'My new application 2'
```

```Output
DisplayName          Id                                   AppId                                SignInAudience                     PublisherDomain
-----------          --                                   -----                                --------------                     ---------------
My new application 2 kkkkkkkk-cccc-dddd-eeee-llllllllllll llllllll-dddd-eeee-ffff-mmmmmmmmmmmm AzureADandPersonalMicrosoftAccount contoso.com
```

This example demonstrates how to retrieve applications for specific string from Microsoft Entra ID.

### Example 8: Retrieve an application by identifierUris

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplication -Filter "identifierUris/any(uri:uri eq 'https://wingtips.wingtiptoysonline.com')"
```

This example demonstrates how to retrieve applications by its identifierUris from Microsoft Entra ID.

### Example 9: List top 2 applications

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplication -Top 2
```

```Output
DisplayName         Id                                   AppId                                SignInAudience                     PublisherDomain
-----------         --                                   -----                                --------------                     ---------------
test app            aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb bbbbbbbb-1111-2222-3333-cccccccccccc AzureADandPersonalMicrosoftAccount contoso.com
ToGraph_443DEM      cccccccc-4444-5555-6666-dddddddddddd dddddddd-5555-6666-7777-eeeeeeeeeeee AzureADMyOrg                       contoso.com
```

This example shows how you can retrieve two applications. You can use `-Limit` as an alias for `-Top`.

### Example 10: List application app roles

```powershell
Connect-Entra -Scopes 'Application.Read.All'
$application = Get-EntraBetaApplication -SearchString 'Contoso Helpdesk Application'
$application.AppRoles | Format-Table -AutoSize
```

```Output
AllowedMemberTypes    Description        DisplayName       Id                                   IsEnabled  Origin       Value        
------------------    -----------        -----------       --                                   ---------  ------       -----        
{User, Application}   General All        General All       gggggggg-6666-7777-8888-hhhhhhhhhhhh  True       Application  Survey.Read  
{Application}         General App Only   General Apponly   hhhhhhhh-7777-8888-9999-iiiiiiiiiiii  True       Application  Task.Write   
{User}                General role       General           bbbbbbbb-1111-2222-3333-cccccccccccc  True       Application  General 
```

This example shows how you can retrieve app roles for an application.

### Example 11: List application oauth2PermissionScopes (delegated permissions exposed by the app)

```powershell
Connect-Entra -Scopes 'Application.Read.All'
(Get-EntraBetaApplication -Filter "displayName eq 'Contoso Helpdesk Application'").Api.Oauth2PermissionScopes
```

```Output
AdminConsentDescription : Allows the app to read HR data on behalf of users.
AdminConsentDisplayName : Read HR Data
Id                      : bbbbbbbb-1111-2222-3333-cccccccccccc
IsEnabled               : True
Origin                  :
Type                    : User
UserConsentDescription  : Allows the app to read your HR data.
UserConsentDisplayName  : Read your HR data
Value                   : HR.Read.All
```

This example shows how you can retrieve `oauth2PermissionScopes` (i.e., delegated permissions exposed by the app) to a service principal. These scopes are part of the application object.

### Example 12: List applications and their secret details

```powershell
Connect-Entra -Scopes 'Application.Read.All'
Get-EntraBetaApplication -All -Property displayName, appId, passwordCredentials |
    Where-Object { $_.PasswordCredentials } |
    ForEach-Object {
        $app = $_
        foreach ($cred in $app.PasswordCredentials) {
            [PSCustomObject]@{
                DisplayName                    = $app.DisplayName
                AppId                          = $app.AppId
                PasswordCredentialsDisplayName = $cred.DisplayName
                PasswordCredentialStartDate    = $cred.StartDate
                PasswordCredentialEndDate      = $cred.EndDate
            }
        }
    } |
    Format-Table -AutoSize
```

```Output
DisplayName              AppId                                PasswordCredentialsDisplayName   PasswordCredentialStartDate PasswordCredentialEndDate
-----------              -----                                ------------------------------   --------------------------- -------------------------
Helpdesk Application     gggggggg-6666-7777-8888-hhhhhhhhhhhh Helpdesk Application Password    8/20/2024 7:54:25 AM        11/18/2024 7:54:25 AM
Helpdesk Application     gggggggg-6666-7777-8888-hhhhhhhhhhhh Helpdesk Application Backend     8/7/2024 4:36:49 PM         2/3/2025 4:36:49 PM
Contoso Automation App   bbbbbbbb-1111-2222-3333-cccccccccccc AI automation Cred               5/3/2025 7:03:11 PM         5/3/2026 7:03:11 PM
```

This example shows how you can retrieve applications that have secrets.

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

### -ApplicationId

Specifies the ID of an application in Microsoft Entra ID.

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

## RELATED LINKS

[New-EntraBetaApplication](New-EntraBetaApplication.md)

[Remove-EntraBetaApplication](Remove-EntraBetaApplication.md)

[Set-EntraBetaApplication](Set-EntraBetaApplication.md)
