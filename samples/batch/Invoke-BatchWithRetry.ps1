function Invoke-BatchWithRetry {
    param(
        [array]$BatchRequests,
        [int]$MaxRetries = 3
    )
    $batchUri = "https://graph.microsoft.com/v1.0/`$batch"
    $responses = @{}
    $pending = @($BatchRequests) # Ensure it's an array
    $retryCount = 0

    while ($pending -ne $null -and $pending.Count -gt 0 -and $retryCount -le $MaxRetries) {
        $batchBody = @{
            requests = $pending
        } | ConvertTo-Json -Depth 5

        $result = Invoke-MgGraphRequest -Method POST -Uri $batchUri -Body $batchBody -ContentType "application/json"
        foreach ($resp in $result.responses) {
            "Id : $($resp.id), Status : $($resp.status)" | Out-File -FilePath "Path\To\log.txt" -Append
            if ($resp.status -eq 429) {
                # Do nothing - will retry later
            } else {
                $responses[$resp.id] = $resp
                # Remove from pending
                $pending = $pending | Where-Object { $_.id -ne $resp.id }
            }
        }

        if ($pending -ne $null -and $pending.Count -gt 0) {
            Start-Sleep -Seconds 5
            $retryCount++
        }
    }
    return $responses
}

# Get Users

if (-not (Get-Command Connect-Entra -ErrorAction SilentlyContinue)) {
    Write-Error "Connect-Entra not found. Install Microsoft.Entra and run Connect-Entra."
    return
}

if (-not (Get-EntraContext)) {
    $errorMessage = "Not connected to Microsoft Entra. Use 'Connect-Entra -Scopes User.Read.All' to authenticate."
    Write-Error -Message $errorMessage -ErrorAction Stop
    return
}

$users = Get-EntraUser -All

# Prepare batch requests (20 per batch)
$batchSize = 20
$allResults = @{}
for ($i = 0; $i -lt $users.Count; $i += $batchSize) {
    $batch = @()
    $batchUsers = $users[$i..([Math]::Min($i+$batchSize-1, $users.Count-1))]
    foreach ($user in $batchUsers) {
        $batch += @{
            id     = $user.id
            method = "GET"
            url    = "/users/$($user.id)/authentication/methods"
        }
    }
    $responses = Invoke-BatchWithRetry -BatchRequests $batch -debug
    foreach ($id in $responses.Keys) {
        $allResults[$id] = $responses[$id]
    }

    $activity = "Processed Users - $i of $($users.count) - $([System.Math]::Round($i / $($users.count) * 100))%"

	Write-Progress -Activity $activity -Status "Fetching authentication methods" -PercentComplete (($i / $users.count) * 100)
}

Write-Output "Completed fetching authentication methods for $($users.count) users. Returned results for $($allResults.Count) users."

# How to execute this script:

# . .\samples\batch\Invoke-BatchWithRetry.ps1

# To execute the script and measure performance, you can use the following command:

# Measure-Command { . .\samples\batch\Invoke-BatchWithRetry.ps1 }