function Set-EntraBetaDirSyncEnabled {
    <#
    .SYNOPSIS
        Turns directory synchronization on or off for a company.
    
    
    .DESCRIPTION
        The Set-MsolDirSyncEnabled cmdlet turns directory synchronization on or off for a company.

        Important
        It may take up to 72 hours to complete deactivation once you have disabled DirSync through this cmdlet. 
        The time depends on the number of objects that are in your cloud service subscription account. You cannot cancel the disable action. It will need to complete before you can take any other action, including re-enabling of DirSync. If you choose to re-enable DirSync, a full synchronization of your synced objects will happen. 
        This may take a considerable time depending on the number of objects in your Active Directory.
    
    .PARAMETER EnableDirSync
        Specifies whether to turn on directory synchronization on for your company.
    
        
    .PARAMETER TenantId
        Specifies the unique ID of the tenant on which to perform the operation. The default value is the tenant of the current user. This parameter applies only to partner users.
    
    
    .PARAMETER <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).
    
    .EXAMPLE
        Set-EntraBetaDirSyncEnabled -EnableDirsync $true
    
        Description
    
        -----------
    
        Enables directory synchronization for the company
    
    
    .EXAMPLE
        Set-EntraBetaDirSyncEnabled -EnableDirsync $false -TenantId 8d396c5a-6337-4321-9d28-2829c94b31dd
        Description
        
        -----------
        
        Disables directory synchronization for the specifc tenant.
    
    #>
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
            $OnPremisesDirectorySynchronizationId = (Get-MgBetaDirectoryOnPremiseSynchronization).Id
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
            $response = Update-MgBetaOrganization @params
            $response
    }
}