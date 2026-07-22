# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<#
.SYNOPSIS
    Attributes public-gallery network connections to a build step for CFSClean2
    investigation.

.DESCRIPTION
    The 1ES network-isolation CFSClean2 policy flags connections to
    www.powershellgallery.com, but its report gives no timestamp, command line or
    step attribution. DNS-layer attribution fails, because the netiso
    HostsFileStabilizer pre-populates the gallery hostname in the hosts file, so the
    name resolves with NO DNS query while the connection still fires.

    Remove-PublicPSGallery.ps1 enables Windows Filtering Platform (WFP) connection
    auditing at the start of the isolated job. Each connection that WFP inspects
    produces a Security event: 5156 (permitted) or 5157 (blocked); 5152 covers
    dropped packets. Every event carries the process image, PID, destination
    address/port and timestamp. netiso frequently runs in *audit* mode, where the
    connection is permitted (5156) but still reported as a violation, so this script
    reads 5156, 5157 and 5152.

    It prints the effective audit setting, total event counts, and a grouped
    summary of outbound port-443/80 destinations (with process, count and first/last
    timestamp) so the public-gallery IP surfaces even when the initiating process is
    not pwsh.exe. Correlate the UTC timestamps against the pipeline timeline's
    per-step start/finish times to identify which step issued the connection, then
    eliminate it at its source.

    Runs only when a private dependency repository is configured (DEPENDENCY_PS_REPO
    set to something other than 'PSGallery'); a no-op on developer machines.
#>
[CmdletBinding()]
param(
    [string] $Repository = $env:DEPENDENCY_PS_REPO,

    # Destination ports of interest (gallery is HTTPS/443).
    [int[]] $Ports = @(443, 80),

    # Known public-gallery front-door IP(s) from the CFSClean2 report, highlighted
    # in the output when seen.
    [string[]] $GalleryIp = @('150.171.109.114', '150.171.108.114')
)

$ErrorActionPreference = 'Stop'

if (-not $Repository -or $Repository -eq 'PSGallery') {
    Write-Host 'No private dependency repository configured (DEPENDENCY_PS_REPO); skipping network attribution.'
    return
}

Write-Host '===== Public gallery network-connection attribution ====='

# Show the effective audit policy so we can tell whether auditing was actually on.
try {
    Write-Host '--- Effective WFP audit policy ---'
    & auditpol.exe /get /subcategory:'Filtering Platform Connection' 2>&1 | ForEach-Object { Write-Host "  $_" }
}
catch {
    Write-Host "  (auditpol /get failed: $($_.Exception.Message))"
}

$events = $null
# Filter on the destination port inside the query (XPath) so we do not have to
# materialise every 5156 permit event the agent generates.
$portPredicate = ($Ports | ForEach-Object { "Data[@Name='DestPort']='$_'" }) -join ' or '
$filterXml = @"
<QueryList>
  <Query Id="0" Path="Security">
    <Select Path="Security">*[System[(EventID=5156 or EventID=5157 or EventID=5152)]] and (*[EventData[$portPredicate]])</Select>
  </Query>
</QueryList>
"@
try {
    $events = Get-WinEvent -FilterXml ([xml]$filterXml) -ErrorAction Stop
}
catch {
    Write-Host "  (No matching Security events, or unable to read the Security log: $($_.Exception.Message))"
    Write-Host '  This means WFP connection auditing produced no events on this agent.'
    Write-Host '===== End network-connection attribution ====='
    return
}

Write-Host "Total WFP connection/drop events on ports $($Ports -join ','): $($events.Count)"

function Get-EventField {
    param($EventXml, [string] $Name)
    $node = $EventXml.Event.EventData.Data | Where-Object { $_.Name -eq $Name }
    if ($node) { return [string]$node.'#text' }
    return ''
}

$rows = foreach ($e in $events) {
    $xml = [xml]$e.ToXml()
    $app = Get-EventField $xml 'Application'
    $destPort = Get-EventField $xml 'DestPort'
    $destAddr = Get-EventField $xml 'DestAddress'
    $procId = Get-EventField $xml 'ProcessID'
    $direction = Get-EventField $xml 'Direction'

    $imageName = if ($app) { [System.IO.Path]::GetFileName(($app -replace '\\device\\harddiskvolume\d+', '')) } else { '' }
    $portInt = 0; [void][int]::TryParse($destPort, [ref]$portInt)
    if ($Ports -notcontains $portInt) { continue }

    [PSCustomObject]@{
        Time      = $e.TimeCreated
        UtcTime   = $e.TimeCreated.ToUniversalTime().ToString('o')
        EventId   = $e.Id
        Pid       = $procId
        Image     = $imageName
        DestAddr  = $destAddr
        DestPort  = $destPort
        Direction = $direction
    }
}

if (-not $rows) {
    Write-Host "  No outbound connections on ports $($Ports -join ',') were audited."
    Write-Host '===== End network-connection attribution ====='
    return
}

Write-Host ''
Write-Host '--- Outbound destinations grouped by image + address + port ---'
$rows | Group-Object Image, DestAddr, DestPort |
    Sort-Object Count -Descending |
    ForEach-Object {
        $first = ($_.Group | Sort-Object Time | Select-Object -First 1)
        $last = ($_.Group | Sort-Object Time | Select-Object -Last 1)
        $flag = if ($GalleryIp -contains $first.DestAddr) { '  <== PUBLIC GALLERY' } else { '' }
        '{0,4}x  {1,-16} {2,-16}:{3,-5} first={4} last={5}{6}' -f `
            $_.Count, $first.Image, $first.DestAddr, $first.DestPort, `
            $first.UtcTime, $last.UtcTime, $flag | Write-Host
    }

Write-Host ''
Write-Host '--- Individual connections to the known public-gallery IP(s) ---'
$galleryRows = $rows | Where-Object { $GalleryIp -contains $_.DestAddr } | Sort-Object Time
if ($galleryRows) {
    $galleryRows | Format-Table UtcTime, EventId, Pid, Image, DestAddr, DestPort, Direction -AutoSize |
        Out-String -Width 4096 | Write-Host
    Write-Host "Total connections to public-gallery IP(s): $($galleryRows.Count)"
    Write-Host 'Correlate the UtcTime values above against the pipeline timeline (step startTime/finishTime) to attribute each connection.'
}
else {
    Write-Host '  No connections to the known public-gallery IP were audited on ports of interest.'
    Write-Host '  Review the grouped destination list above for the gallery front-door address.'
}

Write-Host '===== End network-connection attribution ====='
