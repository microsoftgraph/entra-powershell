function Set-EntraDirSyncEnabled {
    [CmdletBinding(DefaultParameterSetName = 'All')]
    param (
        [Parameter(ParameterSetName = "All", ValueFromPipelineByPropertyName = $true, Mandatory = $true)][System.Boolean] $EnableDirsync,
        [Parameter(ParameterSetName = "All", ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId,
        [switch] $Force
    )

    PROCESS {
        $params = @{}
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $Null
        }
        if ($EnableDirsync -or (-not($EnableDirsync))) {
            $params["OnPremisesSyncEnabled"] =$PSBoundParameters["EnableDirsync"]
        }
        if ($null -ne $PSBoundParameters["TenantId"]) {
            $params["OrganizationId"] = $PSBoundParameters["TenantId"]
        }
        if ([string]::IsNullOrWhiteSpace($TenantId)) {
            $OnPremisesDirectorySynchronizationId = (Get-MgDirectoryOnPremiseSynchronization).Id
            $params["OrganizationId"] = $OnPremisesDirectorySynchronizationId
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        if ($Force) {
            $decision = 0
        }
        else {
            $title = 'Confirm'
            $question = 'Do you want to continue?'
            $Suspend = New-Object System.Management.Automation.Host.ChoiceDescription "&Suspend", "S"
            $Yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Y"
            $No = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "S"
            $choices = [System.Management.Automation.Host.ChoiceDescription[]]($Yes, $No, $Suspend)
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        }
            $response = Update-MgOrganization @params
            $response
    }
}