function Add-EntraBetaClientSecretToAgentIdentityBlueprint {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "The ID of the Agent Identity Blueprint to add the secret to.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentBlueprintId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

        # Use stored blueprint ID if not provided
        if (-not $AgentBlueprintId) {
            if (-not $script:CurrentAgentBlueprintId) {
                Write-Error "No Agent Blueprint ID available. Please create a blueprint first using New-EntraAgentIdentityBlueprint or provide an explicit AgentBlueprintId parameter."
                return
            }
            $AgentBlueprintId = $script:CurrentAgentBlueprintId
            Write-Verbose "Using stored Agent Blueprint ID: $AgentBlueprintId"
        }
        else {
            Write-Verbose "Using provided Agent Blueprint ID: $AgentBlueprintId"
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = '/beta/applications'
        $Method = "POST"
        
        try {
            Write-Verbose "Adding secret to Agent Blueprint: $AgentBlueprintId"

            # Create the password credential object
            $passwordCredential = @{
                displayName = "1st blueprint secret for dev/test. Not recommended for production use"
                endDateTime = (Get-Date).AddDays(90).ToString("yyyy-MM-ddTHH:mm:ssZ")
            }

            # Add the secret to the application with retry logic
            $retryCount = 0
            $maxRetries = 10
            $secretResult = $null
            $success = $false

            $body = @{
                passwordCredential = $passwordCredential
            }
            $JsonBody = $body | ConvertTo-Json -Depth 10
            Write-Debug "Request Body: $JsonBody"

            while ($retryCount -lt $maxRetries -and -not $success) {
                try {
                    $ApiUrl = "$baseUri/$AgentBlueprintId/addPassword"
                    Write-Debug "API URL: $ApiUrl"

                    $secretResult = Invoke-MgGraphRequest -Headers $customHeaders -Method $Method -Uri $ApiUrl -Body $JsonBody -ErrorAction Stop
                    $success = $true
                }
                catch {
                    $retryCount++
                    if ($retryCount -lt $maxRetries) {
                        Write-Verbose "Waiting for propagation..."
                        Write-Verbose "Attempt $retryCount failed. Waiting 10 seconds before retry..."
                        Start-Sleep -Seconds 10
                    }
                    else {
                        Write-Error "Failed to add secret to Agent Blueprint after $maxRetries attempts: $_"
                        throw
                    }
                }
            }

            Write-Host "Successfully added secret to Agent Blueprint" -ForegroundColor Green

            # Add additional properties for easy access
            $secretResult | Add-Member -MemberType NoteProperty -Name "Description" -Value "Not recommended for production use" -Force
            $secretResult | Add-Member -MemberType NoteProperty -Name "AgentBlueprintId" -Value $AgentBlueprintId -Force

            # Store the secret in module-level variables for use by other functions
            $script:CurrentAgentBlueprintSecret = $secretResult
            $script:LastClientSecret = ConvertTo-SecureString $secretResult.SecretText -AsPlainText -Force

            return $secretResult
        }
        catch {
            Write-Error "Failed to add secret to Agent Blueprint: $_"
            throw
        }
    }
}
