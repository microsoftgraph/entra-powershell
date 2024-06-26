---
Title: Get-EntraDirSyncConfiguration
Description: This article provides details on the Get-EntraDirSyncConfiguration command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG
Author: msewaweru

External help file: Microsoft.Graph.Entra-help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Get-EntraDirSyncConfiguration

## Synopsis
Gets the directory synchronization settings.

## Syntax

```powershell
Get-EntraDirSyncConfiguration 
 [-TenantId <Guid>] 
 [<CommonParameters>]
```

## Description
The Get-EntraDirSyncConfiguration cmdlet gets the directory synchronization settings.

## Examples

### Example 1: Get directory synchronization settings
```powershell
PS C:\> Get-EntraDirSyncConfiguration 
```

```output
AccidentalDeletionThreshold DeletionPreventionType
--------------------------- ----------------------
                        500 enabledForCount
```

This command gets directory synchronization settings.

### Example 2: Get directory synchronization settings by TenantId
```powershell
PS C:\> Get-EntraDirSyncConfiguration -TenantId "d5aec55f-2d12-4442-8d2f-ccca95d4390e"
```

```output
AccidentalDeletionThreshold DeletionPreventionType
--------------------------- ----------------------
                        500 enabledForCount
```

This command gets directory synchronization settings by TenantId.

## Parameters

### -TenantId
The unique ID of the tenant to perform the operation on. 
If this isn't provided then it defaults to the tenant of the current user. 
This parameter is only applicable to partner users.

```yaml
Type: Guid
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

## Inputs

### System.Nullable`1[[System.Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]
## Outputs

## Notes

## Related Links

[Set-EntraDirSyncConfiguration](Set-EntraDirSyncConfiguration.md)
