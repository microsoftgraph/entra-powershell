# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<#
.SYNOPSIS
    Attributes blocked public-gallery network connections to a build step for
    CFSClean2 investigation.

.DESCRIPTION
    The 1ES network-isolation CFSClean2 policy flags connections to
    www.powershellgallery.com, but its report gives no timestamp, command line or
    step attribution. DNS-layer attribution also fails, because the netiso
    HostsFileStabilizer pre-populates the gallery hostname in the hosts file, so the
    name resolves with NO DNS query while the blocked TCP connection still fires.

    Remove-PublicPSGallery.ps1 enables Windows Filtering Platform (WFP) connection
    auditing at the start of the isolated job. A blocked egress produces Security
    event 5157 (and packet drops produce 5152) containing the process image name,
    PID, destination address/port and timestamp. This script reads the Security log
    at the end of the job and prints every blocked outbound connection to port 443
    from pwsh.exe (the process the CFSClean2 report attributes the violation to),
    including the event time (local and UTC).

    Correlate the UTC timestamps below against the pipeline timeline's per-step
    start/finish times (each build step runs in its own pwsh process with a distinct
    startTime/finishTime) to identify which step issued the connection, then
    eliminate it at its source.

    Runs only when a private dependency repository is configured (DEPENDENCY_PS_REPO
    set to something other than 'PSGallery'); a no-op on developer machines.
#>
[CmdletBinding()]
param(
    [string] $Repository = $env:DEPENDENCY_PS_REPO,

    # Destination ports of interest (gallery is HTTPS/443).
    [int[]] $Ports = @(443, 80),

    # Process image names of interest; the CFSClean2 report attributes the
    # violation to pwsh.exe.
    [string[]] $Process = @('pwsh.exe', 'powershell.exe', 'dotnet.exe', 'nuget.exe')
)

$ErrorActionPreference = 'Stop'

if (-not $Repository -or $Repository -eq 'PSGallery') {
    Write-Host 'No private dependency repository configured (DEPENDENCY_PS_REPO); skipping network attribution.'
    return
}

Write-Host '===== Public gallery network-connection attribution ====='
Write-Host "Reading Security log for blocked WFP connections (event 5157/5152) on ports: $($Ports -join ', ')"

# WFP audit event 5157 = "The Windows Filtering Platform has blocked a connection".
# Event 5152 = "blocked a packet". Both carry Application, ProcessID, and the
# Source/Destination address + port fields.
$events = $null
try {
    $events = Get-WinEvent -FilterHashtable @{ LogName = 'Security'; Id = @(5157, 5152) } -ErrorAction Stop
}
catch {
    Write-Host "  (Unable to read Security log for WFP events: $($_.Exception.Message))"
    Write-Host '  Ensure the build agent is elevated and auditpol enabled the subcategory.'
    Write-Host '===== End network-connection attribution ====='
    return
}

if (-not $events) {
    Write-Host '  No blocked WFP connection events were recorded.'
    Write-Host '===== End network-connection attribution ====='
    return
}

function Get-EventField {
    param($EventXml, [string] $Name)
    $node = $EventXml.Event.EventData.Data | Where-Object { $_.Name -eq $Name }
    if ($node) { return [string]$node.'#text' }
    return ''
}

$rows = foreach ($e in ($events | Sort-Object TimeCreated)) {
    $xml = [xml]$e.ToXml()
    $app = Get-EventField $xml 'Application'
    $destPort = Get-EventField $xml 'DestPort'
    $destAddr = Get-EventField $xml 'DestAddress'
    $procId = Get-EventField $xml 'ProcessID'
    $direction = Get-EventField $xml 'Direction'

    $imageName = if ($app) { [System.IO.Path]::GetFileName(($app -replace '\\device\\harddiskvolume\d+', '')) } else { '' }
    $portInt = 0; [void][int]::TryParse($destPort, [ref]$portInt)

    if ($Ports -notcontains $portInt) { continue }
    if ($Process -and $imageName -and ($Process -notcontains $imageName)) { continue }

    [PSCustomObject]@{
        UtcTime   = $e.TimeCreated.ToUniversalTime().ToString('o')
        LocalTime = $e.TimeCreated.ToString('o')
        EventId   = $e.Id
        Pid       = $procId
        Image     = $imageName
        DestAddr  = $destAddr
        DestPort  = $destPort
        Direction = $direction
    }
}

if (-not $rows) {
    Write-Host '  No blocked outbound connections on the configured ports/processes were recorded.'
    Write-Host '  (If CFSClean2 still reports violations, widen -Ports/-Process or inspect all 5157 events.)'
    Write-Host '===== End network-connection attribution ====='
    return
}

$rows | Format-Table UtcTime, LocalTime, EventId, Pid, Image, DestAddr, DestPort, Direction -AutoSize |
    Out-String -Width 4096 | Write-Host

Write-Host "Total matching blocked connections: $($rows.Count)"
Write-Host 'Correlate UtcTime values against the pipeline timeline (step startTime/finishTime) to attribute each connection.'
Write-Host '===== End network-connection attribution ====='
