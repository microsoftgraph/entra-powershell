---
title: New-EntraBetaPrivateAccessApplicationSegment
description: This article provides details on the New-EntraBetaPrivateAccessApplicationSegment command.

ms.topic: reference
ms.date: 07/18/2024
ms.author: eunicewaweru
reviewer: andres-canello
manager: mwongerapk
author: andres-canello
external help file: Microsoft.Graph.Entra.Beta-Help.xml
Module Name: Microsoft.Graph.Entra.Beta
s
schema: 2.0.0
---

# New-EntraBetaPrivateAccessApplicationSegment

## Synopsis

Creates an application segment associated to a Private Access application.

## Syntax

```powershell
New-EntraBetaPrivateAccessApplicationSegment
 -ApplicationId <String>
 -DestinationHost <String>
 -DestinationType <String>
 [-Protocol <String>]
 [-Ports <String>]
 [<CommonParameters>]
```

## Description

The `New-EntraBetaPrivateAccessApplicationSegment` cmdlet creates an application segment associated to a Private Access application.

## Examples

### Example 1: Create a simple application segment

```powershell
Connect-Entra -Scopes 'NetworkAccessPolicy.ReadWrite.All', 'Application.ReadWrite.All', 'NetworkAccess.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "displayName eq '<GlobalSecureAccess_Application_DisplayName>'"
$params = @{
    ApplicationId = $application.Id
    DestinationHost = 'ssh.contoso.local'
    Ports = 22
    Protocol = 'TCP'
    DestinationType = 'FQDN'
}
New-EntraBetaPrivateAccessApplicationSegment @params
```

```Output
destinationHost : ssh.contoso.local
destinationType : FQDN
port            : 0
ports           : {22-22}
protocol        : tcp
id              : cccc2222-dd33-4444-55ee-666666ffffff
```

### Example 2: Create an application segment using ranges of IPs and multiple ports

```powershell
Connect-Entra -Scopes 'NetworkAccessPolicy.ReadWrite.All', 'Application.ReadWrite.All', 'NetworkAccess.ReadWrite.All'
$application = Get-EntraBetaApplication -Filter "displayName eq '<GlobalSecureAccess_Application_DisplayName>'"
$params = @{
    ApplicationId = $application.Id
    DestinationHost = '192.168.1.100..192.168.1.110'
    Ports = '22,3389'
    Protocol = 'TCP,UDP'
    DestinationType = 'ipRange'
}
New-EntraBetaPrivateAccessApplicationSegment @params
```

```Output
destinationHost : 192.168.1.100..192.168.1.110
destinationType : ipRange
port            : 0
ports           : {22-22, 3389-3389}
protocol        : tcp,udp
id              : cccc2222-dd33-4444-55ee-666666ffffff
```

### Example 3: Create application segment using an input file

AppSegments.csv

AppObjectId,DestHost,ports,protocol,type\
00001111-aaaa-2222-bbbb-3333cccc4444,10.106.97.0/24,"1-21,23-442,444-65535","TCP,udp",ipRangeCidr\
00001111-aaaa-2222-bbbb-3333cccc4444,10.106.96.0/24,"1-21,23-442,444-65535","udp",ipRangeCidr\
00001111-aaaa-2222-bbbb-3333cccc4444,10.106.95.0/24,"1-21","udp",ipRangeCidr

CreateAppSegments.ps1

```powershell
$csvFile = "C:\temp\AppSegments.csv"

# Assuming the CSV file has columns named 'AppObjectId', 'DestHost', 'ports', 'protocol', 'type'
$variables = Import-Csv $csvFile

# Loop through each row of the CSV and execute the command for each set of variables
foreach ($variable in $variables) {
    $appObjectId = $variable.AppObjectId
    $destHost = $variable.DestHost
    $ports = $variable.ports -split ","
    $protocol = $variable.protocol -split ","
    $type = $variable.type

    # Execute the command
    $params = @{
        ApplicationId = $appObjectId
        DestinationHost = $destHost
        Ports = $ports
        Protocol = $protocol
        DestinationType = $type
    }
    New-EntraBetaPrivateAccessApplicationSegment @params
}
```

## Parameters

### -ApplicationId

The object ID of a Private Access application object.

```yaml
Type: System.String
Parameter Sets:
Aliases: ObjectId

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DestinationHost

Destination host for the application segment. It can be an IP address, a range of IPs (10.10.10.1..10.10.10.200), a CIDR range (10.1.1.0/24) or an FQDN (ssh.contoso.local). Additionally, DNS suffixes for Quick Access can be created with dnsSuffix.

```yaml
Type: System.String
Parameter Sets:
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Ports

Ports for the application segment. It can be a single port, a range (1..100) or a list (22,3389).

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets:
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Protocol

Protocol for the application segment. It can be a single protocol (TCP) or a list (TCP,UDP).

```yaml
Type: System.Collections.Generic.List`1[System.String]
Parameter Sets:
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DestinationType

Destination type for the application segment. It can be "ipAddress", "dnsSuffix", "ipRangeCidr", "ipRange", or "FQDN".

```yaml
Type: System.String
Parameter Sets:
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: `-Debug`, `-ErrorAction`, `-ErrorVariable`, `-InformationAction`, `-InformationVariable`, `-OutVariable`, `-OutBuffer`, `-PipelineVariable`, `-Verbose`, `-WarningAction`, and `-WarningVariable`. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

System.Nullable\`1\[\[System. Boolean, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\] System.Nullable\`1\[\[System.Int32, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089\]\]

## Outputs

### System.Object

## Notes

## RELATED LINKS

[Get-EntraBetaPrivateAccessApplicationSegment](Get-EntraBetaPrivateAccessApplicationSegment.md)

[Remove-EntraBetaPrivateAccessApplicationSegment](Remove-EntraBetaPrivateAccessApplicationSegment.md)

[Get-EntraBetaApplication](Get-EntraBetaApplication.md)
