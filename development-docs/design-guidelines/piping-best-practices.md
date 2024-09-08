# Piping Best Practices

PowerShell pipelining allows cmdlets to pass objects directly from one to another, enabling streamlined and efficient data processing.

## Piping in PowerShell

### Understanding Piping

In PowerShell, cmdlets pipe objects between one another; cmdlets should return objects, not text (strings).

For example, in Entra PowerShell, you can perform updates from the output of another command as inputs. For example, updating the Postal Code address for all group members after a reporting line changes.

```powershell
Get-EntraGroup -Filter "DisplayName eq 'Contoso Team'" | Get-EntraGroupMember | Set-EntraUser -PostalCode 90134 
```

The cmdlet `Get-EntraGroupMember` returns a set of `GroupMember` objects, and those objects are individually piped to the `Set-EntraUser` cmdlet, where they're updated.

When an object is being piped to a cmdlet, PowerShell checks to see if it can bind the input object to a parameter with the same type and has the property `ValueFromPipeline = true`. If no parameters are bound at this point, PowerShell does the same check for parameters with the `ValueFromPipeline = true` parameter, but it sees if it can convert the input object to the type of the parameter. If no parameters are bound at this point, PowerShell then sees if it can bind the properties of the input object with parameters that share the same name and have the property `ValueFromPipelineByPropertyName = true` that are all in the same parameter set.

For more information on piping, see the article [_Understanding pipelines_](https://learn.microsoft.com/powershell/scripting/learn/understanding-the-powershell-pipeline).

## Piping in Entra PowerShell

Pipeline support is based on a specific scenario. Several patterns are supported.

1. Pattern One

Get-Entra<Object> | Set/Update/Remove-Entra<Object>

For example:

```powershell
Get-EntraGroup | Set-EntraGroup -DisplayName 'New Display Name'
```

1. Pattern Two

Get-Entra<Object> | Get/<otherVerbs>-Entra<object2><childObject>

For example:

```powershell
Get-EntraUser | Get-EntraGroupMember
```

1. Pattern 3 - Multiple commands

Example 1: Input is an array of group IDs

```powershell
Get-Content groupIDs.txt | Get-EntraGroup | Update-EntraGroup
```

Example 2: Input is an array of the PSCustomObjects that represent user objects

```powershell
Get-EntraUser | Export-Csv users.csv
Import-Csv users.csv | Update-EntraUser | New-EntraGroupMember
```
