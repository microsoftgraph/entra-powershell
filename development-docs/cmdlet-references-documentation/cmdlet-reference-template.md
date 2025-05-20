---
title: <Command-Name> // for example, Add-EntraDeviceRegisteredOwner
description: Learn the format to follow when writing cmdlet reference content for Microsoft Entra PowerShell docs.


ms.topic: reference
ms.date: 07/12/2024 // format mm/dd/yyyy
ms.author: eunicewaweru
manager: CelesteDG
author: msewaweru
ms.reviewer: stevemutungi

external help file: Microsoft.Entra-Help.xml  //use `Microsoft.Entra.Beta-Help.xml` for beta commands
Module Name: Microsoft.Entra  //use `Microsoft.Entra.Beta` for beta commands
online version: https://learn.microsoft.com/powershell/module/Microsoft.Entra/<Command-Name> //use `https://learn.microsoft.com/powershell/module/Microsoft.Entra.Beta/<Command-Name>` for beta commands

schema: 2.0.0
---

# Cmdlet name

Reference

Module:

## Synopsis

{{Synopsis text - a brief description of the cmdlet}}

## Syntax

{{Add all parameter variants for the cmdlet here}}

## Description  
  
{{Detailed description of the cmdlet}}

## Permissions

{{List permissions required to run the cmdlet}}

## Examples

{{Add examples of how to use the cmdlet}}

// For every example

- When you mention the cmdlet names or parameters in text, use the `inline code` formatting. For example, `Get-EntraUser` or `-UserId`.
- Describe the parameters used in the examples as part of the description text after the example code block. The following example shows how to describe the parameters used in the example code block:

    ```powershell
    Connect-Entra -Scopes 'Application.ReadWrite.All'
    Add-EntraApplicationOwner -ObjectId $ApplicationId -RefObjectId $UserObjectId
    ```

    This example adds an owner to an application.
  - `-ObjectId` parameter specifies the application ID.
  - `-RefObjectId` parameter specifies the user ID of the owner to add.
  
- In the absence of the permissions table, ensure that the first command in every example specifies the scope required to successfully execute the example.
- Don't use PowerShell prompt as part of the example. That is, don't use: `PS C:\>`
- Don't use real GUIDs or other sensitive data in examples. Instead, replace real GUIDs with placeholder GUIDs, such as `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` that use the pattern `LLLLLLLL-NNNN-NNNN-NNNN-LLLLLLLLLLLL` where L is a letter and N is a number between 0-9. Refer to [this guidance](./sample-data/fictitious-guids.md) for GUID placeholders for different entities.
- Use this article to get a [list of sample names](./sample-data/fictitious-names.md).

### Example number: Example title

{{Example introduction text}}

// Since examples provided are intended to be copied and executed, use the following block-style syntax for examples:

```powershell
    <Your PowerShell code goes here> 
```

The example output should be enclosed in an **Output** code block.

```Output
    <Your output goes here>
```

{{Example remarks}} // not a mandatory

## Parameters

{{Add all parameters for the cmdlet here}}

// for every parameter

### -{Parameter name}

{{Parameter description text}}

```yaml // this gives us key/value highlighting
        Type: {Parameter type}  // can be omitted; the default is assumed
        Required: {true | false}
        Position: {(1..n) | named}
        Default value: {None | False (for switch parameters) | the actual default value}
        Accept pipeline input: {false | true (ByValue, ByPropertyName)}
        Accept wildcard characters: {true | false}
```

{{
Note: For the [Type: {Parameter type}], use the full System.<DataType> format. For example:

- `System.String` - to represent a String
- `System.Boolean` - to represent a Boolean
- `System.Management.Automation.SwitchParameter` - to represent SwitchParameter
- `System.Int32` - for Int32

Using the full format helps users to drill down to the data type definition within the docs.
}}

## Inputs

{{Add all inputs for the cmdlet here}}

## Outputs

{{Add all outputs for the cmdlet here}}

## Related Links

{{Add all related links for the cmdlet here}}

// for each link
[{link name}]({link url})
