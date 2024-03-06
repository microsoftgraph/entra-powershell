---
title: Get-EntraGroupMember.
description: This article provides details on the Get-EntraGroupMember command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/06/2023
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraGroupMember

## SYNOPSIS
Gets a member of a group.

## SYNTAX

```
Get-EntraGroupMember 
 -ObjectId <String> 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraGroupMember cmdlet gets a member of a group in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get a group member by ID
```
PS C:\>Get-EntraGroupMember -ObjectId "05b0552e-39cd-4df4-a8f5-00ade912e83d" 

ageGroup onPremisesLastSyncDateTime creationType imAddresses                            preferredLanguage mail                                 securityIdentifier                                  identities
-------- -------------------------- ------------ -----------                            ----------------- ----                                 ------------------                                  ----------
                                                 {meganb@m365x99297270.onmicrosoft.com}                   MeganB@M365x99297270.OnMicrosoft.com S-1-12-1-719509883-1118456798-2440872119-1998244260 {@{signInTyp...
```
This command gets a member of a specified Group.

### Example 2: Get two group member
```
PS C:\>Get-EntraGroupMember -ObjectId "0a58c57b-a9ae-49a2-824f-8e9cb86d4512" -Top 2 

ageGroup onPremisesLastSyncDateTime creationType imAddresses                              preferredLanguage mail                                   securityIdentifier                                  identities
-------- -------------------------- ------------ -----------                              ----------------- ----                                   ------------------                                  ----------
                                                 {admin@m365x99297270.onmicrosoft.com}    en                admin@M365x99297270.onmicrosoft.com    S-1-12-1-2574072234-1301806508-533216682-2892133300 {System....
                                                 {pradeepg@m365x99297270.onmicrosoft.com}                   PradeepG@M365x99297270.OnMicrosoft.com S-1-12-1-357891266-1147903342-476387998-329568156   {System....
```
This command gets the top two Group members.

### Example 3: Get all members within a group by group ID
```
PS C:\>Get-EntraGroupMember -ObjectId "0a58c57b-a9ae-49a2-824f-8e9cb86d4512" -All $true 

ageGroup onPremisesLastSyncDateTime creationType imAddresses                               preferredLanguage mail                                    securityIdentifier                                   identiti
                                                                                                                                                                                                          es
-------- -------------------------- ------------ -----------                               ----------------- ----                                    ------------------                                   --------
                                                 {admin@m365x99297270.onmicrosoft.com}     en                admin@M365x99297270.onmicrosoft.com     S-1-12-1-2574072234-1301806508-533216682-2892133300  {Syst...
                                                 {pradeepg@m365x99297270.onmicrosoft.com}                    PradeepG@M365x99297270.OnMicrosoft.com  S-1-12-1-357891266-1147903342-476387998-329568156    {Syst...
                                                 {jonis@m365x99297270.onmicrosoft.com}                       JoniS@M365x99297270.OnMicrosoft.com     S-1-12-1-3785119861-1177853799-1418655642-1701291850 {Syst...
                                                 {christiec@m365x99297270.onmicrosoft.com}                   ChristieC@M365x99297270.OnMicrosoft.com S-1-12-1-338427849-1319166220-3770554284-4251481260  {Syst...
                                                 {meganb@m365x99297270.onmicrosoft.com}                      MeganB@M365x99297270.OnMicrosoft.com    S-1-12-1-719509883-1118456798-2440872119-1998244260  {Syst...
                                                 {gradya@m365x99297270.onmicrosoft.com}                      GradyA@M365x99297270.OnMicrosoft.com    S-1-12-1-1243136890-1218291773-2919062691-886537280  {Syst...
```
This command gets all members within a Group.

## PARAMETERS

### -All
If true, return all group members.
If false, return the number of objects specified by the Top parameter

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

### -ObjectId
Specifies the ID of a group in Microsoft Entra ID.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Top
Specifies the maximum number of records to return.

```yaml
Type: Int32
Parameter Sets: (All)
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

[Add-EntraGroupMember]()

[Remove-EntraGroupMember]()

