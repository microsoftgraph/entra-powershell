---
title: Get-EntraOAuth2PermissionGrant.
description: This article provides details on the Get-EntraOAuth2PermissionGrant Command.

ms.service: active-directory
ms.topic: reference
ms.date: 03/22/2024
ms.author: eunicewaweru
ms.reviewer: stevemutungi
manager: CelesteDG
author: msewaweru
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Get-EntraOAuth2PermissionGrant

## SYNOPSIS
Gets OAuth2PermissionGrant entities.

## SYNTAX

```powershell
Get-EntraOAuth2PermissionGrant 
 [-All <Boolean>] 
 [-Top <Int32>] 
 [<CommonParameters>]
```

## DESCRIPTION
The Get-EntraOAuth2PermissionGrant cmdlet gets OAuth2PermissionGrant entities in Microsoft Entra ID.

## EXAMPLES

### Example 1: Get the OAuth2 permission grants
```powershell
PS C:\> Get-EntraOAuth2PermissionGrant
```
```output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId
--                                                               --------                             -----------   -----------                          ----------
p9u1ll7Iq0-Gh9M3EERXhffW8XpadQNIoHik9aQxrVE                      96b5dba7-c85e-4fab-8687-d33710445785 AllPrincipals                                      7af1d6f7-755a-4...
85EWleXZQ0-OSJsWJPYf48h9YfkUIuVJtj20MxKD_F4                      951691f3-d9e5-4f43-8e48-9b1624f61fe3 AllPrincipals                                      f9617dc8-2214-4...
85EWleXZQ0-OSJsWJPYf4_fW8XpadQNIoHik9aQxrVE                      951691f3-d9e5-4f43-8e48-9b1624f61fe3 AllPrincipals                                      7af1d6f7-755a-4...
85EWleXZQ0-OSJsWJPYf4wRcLIEmmNBKqrY2qSflLnU                      951691f3-d9e5-4f43-8e48-9b1624f61fe3 AllPrincipals                                      812c5c04-9826-4...
85EWleXZQ0-OSJsWJPYf4zQov6XUsHVJkQd5wk-LuuM                      951691f3-d9e5-4f43-8e48-9b1624f61fe3 AllPrincipals                                      a5bf2834-b0d4-4...
```
This command gets the OAuth2 permission grants.

### Example 2: Get All the OAuth2 permission grants 
```powershell
PS C:\>Get-EntraOAuth2PermissionGrant -All $true
```
```output
Id                                                               ClientId                             ConsentType   PrincipalId                          ResourceId
--                                                               --------                             -----------   -----------                          ----------
p9u1ll7Iq0-Gh9M3EERXhffW8XpadQNIoHik9aQxrVE                      96b5dba7-c85e-4fab-8687-d33710445785 AllPrincipals                                      7af1d6f7-755a-4...
85EWleXZQ0-OSJsWJPYf48h9YfkUIuVJtj20MxKD_F4                      951691f3-d9e5-4f43-8e48-9b1624f61fe3 AllPrincipals                                      f9617dc8-2214-4...
85EWleXZQ0-OSJsWJPYf4_fW8XpadQNIoHik9aQxrVE                      951691f3-d9e5-4f43-8e48-9b1624f61fe3 AllPrincipals                                      7af1d6f7-755a-4...
85EWleXZQ0-OSJsWJPYf4wRcLIEmmNBKqrY2qSflLnU                      951691f3-d9e5-4f43-8e48-9b1624f61fe3 AllPrincipals                                      812c5c04-9826-4...
85EWleXZQ0-OSJsWJPYf4zQov6XUsHVJkQd5wk-LuuM                      951691f3-d9e5-4f43-8e48-9b1624f61fe3 AllPrincipals                                      a5bf2834-b0d4-4...
```
This command gets all the OAuth2 permission grants.

### Example 3: Get top 2 OAuth2 permission grants record.
```powershell
PS C:\> Get-EntraOAuth2PermissionGrant -Top 1
```
```output
Id                                          ClientId                             ConsentType   PrincipalId ResourceId                           Scope
--                                          --------                             -----------   ----------- ----------                           -----
p9u1ll7Iq0-Gh9M3EERXhffW8XpadQNIoHik9aQxrVE 96b5dba7-c85e-4fab-8687-d33710445785 AllPrincipals             7af1d6f7-755a-4803-a078-a4f5a431ad51 Policy.Read.All Policy.R...
85EWleXZQ0-OSJsWJPYf48h9YfkUIuVJtj20MxKD_F4 951691f3-d9e5-4f43-8e48-9b1624f61fe3 AllPrincipals             f9617dc8-2214-49e5-b63d-b4331283fc5e User.Read Group.ReadWrit...
```
This command gets top 2 OAuth2 permission grants records.

## PARAMETERS

### -All
If true, return all Oath 2 permission grants.
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Remove-EntraOAuth2PermissionGrant](Remove-EntraOAuth2PermissionGrant.md)

