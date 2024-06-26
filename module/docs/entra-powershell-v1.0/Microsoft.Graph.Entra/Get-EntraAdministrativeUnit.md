---
Title: Get-EntraAdministrativeUnit
Description: This article provides details on the Get-EntraAdministrativeUnit command.

Ms.service: entra
Ms.topic: reference
Ms.date: 06/26/2024
Ms.author: eunicewaweru
Ms.reviewer: stevemutungi
Manager: CelesteDG

External help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
Online version:
Schema: 2.0.0
---

# Get-EntraAdministrativeUnit

## Synopsis

Gets an administrative unit.

## Syntax

### GetQuery (Default)

```powershell
Get-EntraAdministrativeUnit 
 [-Top <Int32>] 
 [-All] 
 [-Filter <String>] 
 [<CommonParameters>]
```

### GetById

```powershell
Get-EntraAdministrativeUnit 
 -Id <String> 
 [-All] 
 [<CommonParameters>]
```

## Description

The `Get-EntraAdministrativeUnit` cmdlet gets a Microsoft Entra ID administrative unit.

## Examples

### Example 1: Get all administrative units

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnit
```

```Output
Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
Aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb           Dynamic AU testing in CORP tenant               DAU-Test
Bbbbbbbb-1111-2222-3333-cccccccccccc                                                           SOC Retention
Cccccccc-2222-3333-4444-dddddddddddd           Container AU for restricted object control      DSR RMAU
Dddddddd-3333-4444-5555-eeeeeeeeeeee           Use to contain Personnel-managed project groups Personnel Projects
```

This command gets all the administrative units.

### Example 2: Get all administrative units using '-All' parameter

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnit -All 
```

```Output
Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
Aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb           Dynamic AU testing in CORP tenant               DAU-Test
Bbbbbbbb-1111-2222-3333-cccccccccccc                                                           SOC Retention
Cccccccc-2222-3333-4444-dddddddddddd           Container AU for restricted object control      DSR RMAU
Dddddddd-3333-4444-5555-eeeeeeeeeeee           Use to contain Personnel-managed project groups Personnel Projects
```

This command gets all the administrative units.

### Example 3: Get a specific administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnit -Id aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
```

```Output
Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
Aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb           Dynamic AU testing in CORP tenant               DAU-Test
```

This example returns the details of the specified administrative unit.

### Example 4: Get administrative units filter by display name

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnit -Filter "DisplayName eq 'DAU-Test'"
```

```Output
Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
Aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb           Dynamic AU testing in CORP tenant               DAU-Test
```

This example list of administrative units containing display name with the specified name.

### Example 5: Get top one administrative unit

```powershell
Connect-Entra -Scopes 'AdministrativeUnit.Read.All'
Get-EntraAdministrativeUnit -Top 1
```

```Output
Id                                   OdataType Description                                     DisplayName
--                                   --------- -----------                                     -----------
Aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb           Dynamic AU testing in CORP tenant               DAU-Test
```

This example returns the specified top administrative units.

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

Specifies an oData v3.0 filter statement.
This parameter filters which objects are returned.

For more information about oData v3.0 filter expressions, see <https://msdn.microsoft.com/library/hh169248%28v=nav.90%29.aspx>

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

### -Id

Specifies the ID of an administrative unit in Microsoft Entra ID.

```yaml
Type: System.String
Parameter Sets: GetById
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
Type: System.Int32
Parameter Sets: GetQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

## Outputs

## Notes

## Related Links

[New-EntraAdministrativeUnit](New-EntraAdministrativeUnit.md)

[Remove-EntraAdministrativeUnit](Remove-EntraAdministrativeUnit.md)

[Set-EntraAdministrativeUnit](Set-EntraAdministrativeUnit.md)
