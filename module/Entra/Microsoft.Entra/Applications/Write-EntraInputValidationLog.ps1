# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Write-EntraInputValidationLog {
    <#
    .SYNOPSIS
        Logs input validation failures to persistent storage for security audit compliance.
    .DESCRIPTION
        Writes a structured log entry when user-provided input fails validation.
        On Windows, logs are written to both the Windows Event Log (Application log,
        source 'Microsoft.Entra') and to a file-based log. On Linux/macOS, logs are
        written to a file and optionally to syslog via the 'logger' command.
        This function satisfies Microsoft.Security.SystemsADM.10031 which requires
        persistent logging of all user input that does not match expected patterns.
    .PARAMETER CmdletName
        The name of the cmdlet where the validation failure occurred.
    .PARAMETER ParameterName
        The name of the parameter that failed validation.
    .PARAMETER InvalidValue
        The value that failed validation. Sensitive values are masked.
    .PARAMETER ExpectedPattern
        A description of the expected input pattern.
    .PARAMETER Message
        An optional additional message describing the validation failure.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$CmdletName,

        [Parameter(Mandatory = $true)]
        [string]$ParameterName,

        [Parameter(Mandatory = $false)]
        [string]$InvalidValue,

        [Parameter(Mandatory = $false)]
        [string]$ExpectedPattern,

        [Parameter(Mandatory = $false)]
        [string]$Message
    )

    $timestamp = [DateTime]::UtcNow.ToString('o')
    $username = if ($IsWindows -or ($PSVersionTable.PSEdition -eq 'Desktop')) {
        [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    } else {
        [System.Environment]::UserName
    }

    # Mask potentially sensitive values - show only first 4 chars for values longer than 8 chars
    $maskedValue = if ([string]::IsNullOrEmpty($InvalidValue)) {
        '[empty]'
    } elseif ($InvalidValue.Length -gt 8) {
        $InvalidValue.Substring(0, 4) + '****'
    } else {
        '****'
    }

    $logEntry = [ordered]@{
        Timestamp       = $timestamp
        EventType       = 'InputValidationFailure'
        CmdletName      = $CmdletName
        ParameterName   = $ParameterName
        InvalidValue    = $maskedValue
        ExpectedPattern = if ($ExpectedPattern) { $ExpectedPattern } else { 'N/A' }
        Message         = if ($Message) { $Message } else { 'N/A' }
        User            = $username
    }

    $logMessage = ($logEntry.GetEnumerator() | ForEach-Object { "$($_.Key)=$($_.Value)" }) -join '; '

    # Write to file-based log (always available, no admin required)
    try {
        $logDirectory = Join-Path ([Environment]::GetFolderPath('LocalApplicationData')) 'Microsoft.Entra\Logs'
        if (-not (Test-Path $logDirectory)) {
            New-Item -ItemType Directory -Path $logDirectory -Force | Out-Null
        }
        $logFilePath = Join-Path $logDirectory "InputValidation-$(Get-Date -Format 'yyyyMMdd').log"
        Out-File -FilePath $logFilePath -Append -Encoding UTF8 -InputObject $logMessage
    }
    catch {
        Write-Verbose "Write-EntraInputValidationLog: Failed to write to file log: $_"
    }

    # Write to Windows Event Log (persistent, centrally auditable) - Windows only
    if ($IsWindows -or ($PSVersionTable.PSEdition -eq 'Desktop')) {
        try {
            $source = 'Microsoft.Entra'
            if (-not [System.Diagnostics.EventLog]::SourceExists($source)) {
                [System.Diagnostics.EventLog]::CreateEventSource($source, 'Application')
            }
            Write-EventLog -LogName 'Application' -Source $source -EventId 1001 -EntryType Warning -Message $logMessage
        }
        catch {
            # Event log write failure is non-fatal; file log is the primary persistent store
            Write-Verbose "Write-EntraInputValidationLog: Failed to write to Event Log: $_"
        }
    } else {
        # On non-Windows, log to syslog via logger if available
        try {
            if (Get-Command 'logger' -ErrorAction SilentlyContinue) {
                logger -p user.warning -t 'Microsoft.Entra' $logMessage
            }
        }
        catch {
            Write-Verbose "Write-EntraInputValidationLog: Failed to write to syslog: $_"
        }
    }

    Write-Verbose "Input validation failure logged: $logMessage"
}
