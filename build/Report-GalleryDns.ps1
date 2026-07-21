# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

<#
.SYNOPSIS
    Reports DNS queries to the public PowerShell Gallery for CFSClean2 attribution.

.DESCRIPTION
    The 1ES network-isolation CFSClean2 policy flags connections to
    www.powershellgallery.com, but its report gives no timestamp, command line or
    step attribution. Remove-PublicPSGallery.ps1 enables the Windows DNS-Client
    Operational event log at the start of the isolated job; this script reads that
    log at the end of the job and prints every query whose name matches the public
    gallery, including the event time (local and UTC) and the initiating process id.

    Correlate the UTC timestamps below against the pipeline timeline's per-step
    start/finish times (each build step records startTime/finishTime) to identify
    which step issued the query, then eliminate that query at its source.

    Runs only when a private dependency repository is configured (DEPENDENCY_PS_REPO
    set to something other than 'PSGallery'); a no-op on developer machines.
#>
[CmdletBinding()]
param(
    [string] $Repository = $env:DEPENDENCY_PS_REPO,

    [string[]] $Pattern = @('powershellgallery', 'psg-prod', 'psg-'),

    [string] $LogName = 'Microsoft-Windows-DNS-Client/Operational'
)

$ErrorActionPreference = 'Stop'

if (-not $Repository -or $Repository -eq 'PSGallery') {
    Write-Host 'No private dependency repository configured (DEPENDENCY_PS_REPO); skipping DNS attribution.'
    return
}

Write-Host "===== Public gallery DNS query attribution ====="
Write-Host "Reading '$LogName' for queries matching: $($Pattern -join ', ')"

$events = $null
try {
    $events = Get-WinEvent -LogName $LogName -ErrorAction Stop |
        Where-Object {
            $message = $_.Message
            $message -and ($Pattern | Where-Object { $message -match [regex]::Escape($_) })
        }
}
catch {
    Write-Host "  (Unable to read '$LogName': $($_.Exception.Message))"
    Write-Host "===== End DNS query attribution ====="
    return
}

if (-not $events) {
    Write-Host '  No public-gallery DNS queries were recorded. No CFSClean2 source detected in this job.'
    Write-Host "===== End DNS query attribution ====="
    return
}

# DNS-Client event 3006 = "DNS query is called"; the message embeds the query name.
$rows = foreach ($e in ($events | Sort-Object TimeCreated)) {
    $queryName = ''
    if ($e.Message -match '(?im)(?:for the name|Query name[:=]?|name[:=])\s*([^\s,;]+)') {
        $queryName = $Matches[1].Trim()
    }
    [PSCustomObject]@{
        UtcTime   = $e.TimeCreated.ToUniversalTime().ToString('o')
        LocalTime = $e.TimeCreated.ToString('o')
        EventId   = $e.Id
        Pid       = $e.ProcessId
        QueryName = $queryName
    }
}

$rows | Format-Table UtcTime, LocalTime, EventId, Pid, QueryName -AutoSize | Out-String -Width 4096 | Write-Host

Write-Host "Total matching DNS queries: $($rows.Count)"
Write-Host 'Correlate UtcTime values against the pipeline timeline (step startTime/finishTime) to attribute each query.'
Write-Host "===== End DNS query attribution ====="
