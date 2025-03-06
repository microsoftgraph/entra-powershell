function Get-EntraDirectorySubscription {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string] $SubscriptionId,

        [Parameter()]
        [string[]] $Property
    )

    try {
        if ($SubscriptionId) {
            # Get a specific subscription by ID
            $uri = "https://graph.microsoft.com/v1.0/directory/subscriptions/$SubscriptionId"
            $response = Invoke-MgGraphRequest -Method GET -Uri $uri

            if ($Property -and $Property.Count -gt 0) {
                $response | Select-Object -Property $Property
            }
            else {
                $response
            }
        }
        else {
            # Get all subscriptions
            $uri = "https://graph.microsoft.com/v1.0/directory/subscriptions"
            $subscriptions = @()
            $page = 1

            do {
                Write-Progress `
                    -Activity "Retrieving Microsoft Entra subscriptions" `
                    -Status "Fetching page $page..." `
                    -PercentComplete (($page - 1) * 10)

                $response = Invoke-MgGraphRequest -Method GET -Uri $uri

                if ($response.value) {
                    $subscriptions += $response.value
                }

                $uri = $response.'@odata.nextLink'
                $page++
            }
            while ($uri)

            Write-Progress -Activity "Retrieving Microsoft Entra subscriptions" -Completed

            if ($Property -and $Property.Count -gt 0) {
                $subscriptions | Select-Object -Property $Property
            }
            else {
                $subscriptions
            }
        }
    }
    catch {
        Write-Error "Failed to retrieve subscriptions: $_"
    }
}
