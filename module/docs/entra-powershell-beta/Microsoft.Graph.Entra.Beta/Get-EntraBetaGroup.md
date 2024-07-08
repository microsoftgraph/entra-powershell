---
title: Get-EntraBetaGroup.
description: This article provides details on the Get-EntraBetaGroup command.

ms.service: active-directory
ms.topic: reference
ms.date: 06/26/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
online version:
schema: 2.0.0
---

# Get-EntraBetaGroup

## Synopsis
Gets a group.

## Syntax

### GetQuery (Default)
```powershell
Get-EntraBetaGroup 
 [-Filter <String>] 
 [-All] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

### GetByValue
```powershell
Get-EntraBetaGroup 
 [-SearchString <String>] 
 [-All] 
 [<CommonParameters>]
```

### GetById
```powershell
Get-EntraBetaGroup 
 -ObjectId <String> 
 [-All] 
 [<CommonParameters>]
```

## Description
The Get-EntraBetaGroup cmdlet gets a group in Microsoft Entra ID.

## Examples

### Example 1: Get all groups
```powershell
PS C:\>Get-EntraBetaGroup
```
```output
ObjectId                             DisplayName                          Description
--------                             -----------                          -----------
00628948-b509-4362-aa73-380c4dbd2a44 ADSyncBrowse
02d91535-6c02-42bc-8ede-c57189320cc0 NewGroup2
093fc0e2-1d6e-4a1b-9bf8-effa0196f1f7 All Users
0dc8d2b2-d907-42e8-8558-0add236a8408 ADSyncOperators
0e6cf869-82ca-4647-b330-420b9a6f8ef7 Temporary users team (Dynamic group)
10d81ac5-1993-434b-b74c-1dcc4fd534ea HappyThanksgiving
1e94a453-2727-47f6-b59e-d86df3494312 European teams
23af9bad-83c5-4f03-a4e4-363bd892fc56 South-West Sales team
269f90d5-93dc-4c0a-8f22-bf23da4e0c3a All FTE employees
2b559810-b5de-41a8-913f-c45a55adfc25 Exchange Trusted Subsystem           This group contains Exchange servers that run Exchange cmdlets on behalf of users via the management service.
Its members ...
31f1ff6c-d48c-4f8a-b2e1-abca7fd399df Intune Administrators                Intune Device Administrators
364e009b-fbe4-4aef-b230-2e9e8f2fe636 ADSyncPasswordSet
3d3f7196-3ec8-4076-a232-1ca30b655d1a WinRMRemoteWMIUsers__                Members of this group can access WMI resources over management protocols (such as WS-Management via the Windows Remote Man...
3df5d8b7-8af4-4536-90d6-cde4c878e252 ADSyncOperators
4370f0a6-78e9-44cb-b722-29cb5307fdba Exchange Servers                     This group contains all the Exchange servers. This group shouldn't be deleted.
47a1bff5-f449-4bfc-8772-b1515c57fec5 ExchangeLegacyInterop                This group is for interoperability with Exchange 2003 servers within the same forest.
This group should not be deleted.
```

This example demonstrates how to get all groups from Microsoft Entra ID.  

### Example 2: Get a specific group by using an ObjectId
```powershell
PS C:\>Get-EntraBetaGroup -ObjectId "fc446647-e8ff-47f1-a489-cf31694c0d35"
```
```output
DisplayName Id                                   MailNickname Description GroupTypes
----------- --                                   ------------ ----------- ----------
UPDISPLAY   fc446647-e8ff-47f1-a489-cf31694c0d35 Remoteliving Upd1        {Unified}
```

This example demonstrates how to retrieve specific group by providing ID.  
This command gets information for the group that has the specified ID.

### Example 3: Get top five groups 
```powershell
PS C:\>Get-EntraBetaGroup -Top 5
```
```output
DisplayName             Id                                   MailNickname          Description
-----------             --                                   ------------          -----------
Ask HR                  056b2531-005e-4f3e-be78-01a71ea30a04 askhr
Parents of Contoso      05b0552e-39cd-4df4-a8f5-00ade912e83d parentsofcontoso      Parents of Contoso
Contoso Team            0877c6c6-fc99-4d51-9871-8335be7cfc9d contosoteam           A collaboration area for the Cont...
HelpDesk admin group    0883fd77-0ee8-45de-a21e-f32af1623acc helpDeskAdminGroup    Group assignable to role
New Employee Onboarding 0a58c57b-a9ae-49a2-824f-8e9cb86d4512 newemployeeonboarding New Employee Onboarding
```

This example demonstrates how to get top five groups from Microsoft Entra ID.  
This command gets the five groups in Microsoft Entra ID.

### Example 4: Get a group by DisplayName
```powershell
PS C:\>Get-EntraBetaGroup -Filter "DisplayName eq 'Parents of Contoso'"
```
```output
DisplayName        Id                                   MailNickname     Description        GroupTypes
-----------        --                                   ------------     -----------        ----------
Parents of Contoso 05b0552e-39cd-4df4-a8f5-00ade912e83d parentsofcontoso Parents of Contoso {Unified}
```  
In this example, we retrieve group by display name from Microsoft Entra ID.    
This command gets the specified group.

### Example 5: Get groups that contain a search string
```powershell
PS C:\>Get-EntraBetaGroup -SearchString "New"
```
```output
DisplayName             Id                                   MailNickname          Description             GroupTypes
-----------             --                                   ------------          -----------             ----------
New Employee Onboarding 0a58c57b-a9ae-49a2-824f-8e9cb86d4512 newemployeeonboarding New Employee Onboarding {Unified}
new1                    27d134ad-466b-43dd-8856-ba9f0bc17d24 new1                  new1                    {DynamicM...
```

This example demonstrates how to retrieve groups that include the text new in their display names from Microsoft Entra ID.

## Parameters

### -All
List all pages.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
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
The unique identifier of a group in Microsoft Entra ID. (ObjectId)

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[New-EntraBetaGroup](New-EntraBetaGroup.md)

[Remove-EntraBetaGroup](Remove-EntraBetaGroup.md)

[Set-EntraBetaGroup](Set-EntraBetaGroup.md)