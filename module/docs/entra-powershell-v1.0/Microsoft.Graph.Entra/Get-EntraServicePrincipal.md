---
title: Get-EntraServicePrincipal.
description: This article provides details on the Get-EntraServicePrincipal command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/20/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraServicePrincipal

## SYNOPSIS
Gets a service principal.

## SYNTAX

### GetQuery (Default)
```
Get-EntraServicePrincipal 
 [-Top <Int32>] 
 [-All <Boolean>] 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetByValue
```
Get-EntraServicePrincipal 
 [-SearchString <String>] 
 [-All <Boolean>] 
 [<CommonParameters>]
```

### GetById
```
Get-EntraServicePrincipal 
 -ObjectId <String> 
 [-All <Boolean>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraServicePrincipal cmdlet gets a service principal in Microsoft Entra ID.

## EXAMPLES

### Example 1: Retrieve all service principal from the directory
```powershell
PS C:\> Get-EntraServicePrincipal
```
```output
DisplayName                                           Id                                   AppId                                SignInAudience                     ServicePrincipalType
-----------                                           --                                   -----                                --------------                     --------------------
M365 License Manager                                  0008861a-d455-4671-bd24-ce9b3bfce288 aeb86249-8ea3-49e2-900b-54cc8e308f85 AzureADMultipleOrgs                Application
Microsoft Device Management Checkin                   000aa8f0-ccde-4b68-914b-d922971b6192 ca0a114d-6fbc-46b3-90fa-2ec954794ddb AzureADMultipleOrgs                Application
ProvisioningPowerBi                                   021510b7-e753-40aa-b668-29753295ca34 ea708463-7f80-4331-bb6d-bdd6d7128daf AzureADMultipleOrgs                Application
ToGraph_443democc3c                                   02939955-b5d0-436e-a8b1-35d37154f550 7bc6f57b-9014-45de-a73c-5a2b75454305 AzureADMyOrg                       Application
O365 Secure Score                                     02ed943d-6eca-4f99-83d6-e6fbf9dc63ae 8b3391f4-af01-4ee8-b4ea-9871b2499735 AzureADMultipleOrgs                Application
O365 LinkedIn Connection                              06ae8474-5290-46ec-9434-4e66b08a07cd f569b9c7-be15-4e87-86f7-87d30d02090b                                    SocialIdp
Azure AD Application Proxy                            06dc35f5-c3eb-4a19-8161-7dad6e728087 47ee738b-3f1a-4fc7-ab11-37e4822b007e AzureADMultipleOrgs                Application
CPIM Service                                          0a95b534-38d2-409f-943a-4d5092a181a0 bb2a2e3a-c5e7-4f0a-88e0-8e01fd3fc1f4 AzureADMultipleOrgs                Application
```
This example demonstrates how to retrieve all service principal from Microsoft Entra ID.    
This command retrieves all service principal from the Microsoft Entra ID.

### Example 2: Retrieve a service principal by ID
```powershell
PS C:\> $ServicePrincipalId = (Get-EntraServicePrincipal -Top 1).ObjectId
PS C:\> Get-EntraServicePrincipal $ServicePrincipalId
```
```output
DisplayName          Id                                   AppId                                SignInAudience      ServicePrincipalType
-----------          --                                   -----                                --------------      --------------------
M365 License Manager 0008861a-d455-4671-bd24-ce9b3bfce288 aeb86249-8ea3-49e2-900b-54cc8e308f85 AzureADMultipleOrgs Application
```

This example demonstrates how to retrieve service principal by ServicePrincipalId from Microsoft Entra ID.    
The first command gets the ID of a service principal by using the Get-EntraServicePrincipal (./Get-EntraServicePrincipal.md) cmdlet.
The command stores the ID in the $ServicePrincipalId variable.    
The second command gets the service principal identified by $ServicePrincipalId.

### Example 3: Retrieve top five service principal
```powershell
PS C:\> Get-EntraServicePrincipal -Top 5
```
```output
DisplayName                         Id                                   AppId                                SignInAudience      ServicePrincipalType
-----------                         --                                   -----                                --------------      --------------------
M365 License Manager                0008861a-d455-4671-bd24-ce9b3bfce288 aeb86249-8ea3-49e2-900b-54cc8e308f85 AzureADMultipleOrgs Application
Microsoft Device Management Checkin 000aa8f0-ccde-4b68-914b-d922971b6192 ca0a114d-6fbc-46b3-90fa-2ec954794ddb AzureADMultipleOrgs Application
ProvisioningPowerBi                 021510b7-e753-40aa-b668-29753295ca34 ea708463-7f80-4331-bb6d-bdd6d7128daf AzureADMultipleOrgs Application
ToGraph_443democc3c                 02939955-b5d0-436e-a8b1-35d37154f550 7bc6f57b-9014-45de-a73c-5a2b75454305 AzureADMyOrg        Application
O365 Secure Score                   02ed943d-6eca-4f99-83d6-e6fbf9dc63ae 8b3391f4-af01-4ee8-b4ea-9871b2499735 AzureADMultipleOrgs Application
```

This example demonstrates how to get top five service principal from Microsoft Entra ID.      
This command gets the five service principal from Microsoft Entra ID.

### Example 4: Search among retrieve service principal
```powershell
PS C:\> Get-EntraServicePrincipal -SearchString "M365 License Manager"
```
```output
DisplayName                         Id                                   AppId                                SignInAudience      ServicePrincipalType
-----------                         --                                   -----                                --------------      --------------------
M365 License Manager                0008861a-d455-4671-bd24-ce9b3bfce288 aeb86249-8ea3-49e2-900b-54cc8e308f85 AzureADMultipleOrgs Application
```

This example demonstrates how to retrieve service principal for a specific string from Microsoft Entra ID.  
This command gets the all service principal that matches the value of SearchString against the first characters in DisplayName.

### Example 5: Retrieve service principal by DisplayName
```powershell
PS C:\> Get-EntraServicePrincipal -Filter "DisplayName eq 'M365 License Manager'"
```
```output
DisplayName          Id                                   AppId                                SignInAudience      ServicePrincipalType
-----------          --                                   -----                                --------------      --------------------
M365 License Manager 0008861a-d455-4671-bd24-ce9b3bfce288 aeb86249-8ea3-49e2-900b-54cc8e308f85 AzureADMultipleOrgs Application
```

In this example, we retrieve service principal by DisplayName from Microsoft Entra ID.   
This command gets the specified service principal.

### Example 6: Retrieve service principal by DisplayName
```powershell
PS C:\> Get-EntraServicePrincipal -Filter "startswith(DisplayName,'test')"
```
```output
DisplayName            Id                                   AppId                                SignInAudience                     ServicePrincipalType
-----------            --                                   -----                                --------------                     --------------------
Test-App-1             d05979fa-359a-41d9-83e6-7b7a12536138 800ec7f3-5ee7-46c3-a6b6-4412cc7e9074 AzureADMyOrg                       Application
Test-App-2             4a795157-504b-4473-ae28-1c54592e7702 0e2f044c-def9-4f98-8c82-41606d311450 AzureADMyOrg                       Application
Test-App-3             ff145d83-7b35-4471-bcd8-b173ebf8f76f 1044046c-e341-40d2-b6ad-8cdd89e4c113 AzureADMyOrg                       Application
Test-App-5             7833515c-2895-4e63-b880-8792e58e73f2 a1bbc5e9-ab60-4ec4-8930-2db16eb49b28 AzureADMyOrg                       Application
test adms app azure    adad6b6f-be22-495e-a3ae-c199c45d380f 42f3bd6a-1784-40a0-b28e-99db13621e44 AzureADandPersonalMicrosoftAccount Application
test app               86c5339f-8f95-4e9e-995a-0fa348e2c3dc c24b4208-60de-4a95-9f69-82054defbfb8 AzureADandPersonalMicrosoftAccount Application
```

In this example, we retrieve all service principal whose display name starts with test.

## PARAMETERS

### -All
If true, return all service principal objects.
If false, return the number of objects specified by the Top parameter.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Filter
Specifies an oData v3.0 filter statement.
This parameter controls which objects are returned.

```yaml
Type: String
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ObjectId
Specifies the ID of a service principal in Microsoft Entra ID.

```yaml
Type: String
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
Type: String
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
Type: Int32
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[New-EntraServicePrincipal](New-EntraServicePrincipal.md)

[Remove-EntraServicePrincipal](Remove-EntraServicePrincipal.md)

[Set-EntraServicePrincipal](Set-EntraServicePrincipal.md)

