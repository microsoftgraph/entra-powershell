function Get-EntraBetaAgentIdentity {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, HelpMessage = "The ID of the Agent Identity to retrieve.")]
        [ValidateNotNullOrEmpty()]
        [string]$AgentId
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Application.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    process {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = '/beta/servicePrincipals'
        
        try {
            Write-Verbose "Retrieving Agent Identity: $AgentId"
            
            # Call the Graph API to get the agent identity
            $uri = "$baseUri/microsoft.graph.agentIdentity/$AgentId"
            $result = Invoke-MgGraphRequest -Headers $customHeaders -Method GET -Uri $uri -ErrorAction Stop
            
            Write-Verbose "Successfully retrieved Agent Identity"
            return $result
        }
        catch {
            # Check if it's a 404 (not found) error
            if ($_.Exception.Message -like "*404*" -or $_.Exception.Message -like "*NotFound*") {
                Write-Error "Agent Identity with ID '$AgentId' not found."
            }
            else {
                Write-Error "Failed to retrieve Agent Identity: $_"
            }
            throw
        }
    }
}
