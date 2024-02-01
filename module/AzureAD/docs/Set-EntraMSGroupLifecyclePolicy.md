---
external help file: Microsoft.Graph.Entra-Help.xml
Module Name: Microsoft.Graph.Entra
online version:
schema: 2.0.0
---

# Set-EntraMSGroupLifecyclePolicy

## SYNOPSIS
Updates a specific group Lifecycle Policy in Microsoft Entra ID

## SYNTAX

```
Set-EntraMSGroupLifecyclePolicy [-AlternateNotificationEmails <String>] [-GroupLifetimeInDays <Int32>]
 [-ManagedGroupTypes <String>] -Id <String> [<CommonParameters>]
```

## DESCRIPTION
The Set-EntraMSGroupLifecyclePolicy command updates a specific group Lifecycle Policy in Microsoft Entra ID

## EXAMPLES

### Example 1
```
PS C:\> Set-EntraMSGroupLifecyclePolicy -Id "b4c908b0-3595-4add-91b4-c5400b31b57b" -GroupLifetimeInDays 200 -AlternateNotificationEmails "admingroup@contoso.com"
```

This command updates the specified groupLifecyclePolicy in Microsoft Entra ID

## PARAMETERS

### -AlternateNotificationEmails
Notification emails for groups that have no owners will be sent to these email addresses.
List of email addresses separated by a ";".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupLifetimeInDays
The number of days a group can exist before it needs to be renewed

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
Specifies the ID of a groupLifecyclePolicies object in Microsoft Entra ID

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

### -ManagedGroupTypes
Allows the admin to select which office 365 groups the policy will apply to.
"None" will create the policy in a disabled state.
"All" will apply the policy to every Office 365 group in the tenant.
"Selected" will allow the admin to choose specific Office 365 groups that the policy will apply to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
