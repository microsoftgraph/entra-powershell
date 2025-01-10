# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Set-EntraBetaDirSyncFeature {
        [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
        param (
            [Parameter(ParameterSetName = "GetQuery", Mandatory = $true, ValueFromPipelineByPropertyName = $true)][System.String] $Feature,
            [Parameter(ParameterSetName = "GetQuery", Mandatory = $true, ValueFromPipelineByPropertyName = $true)][System.Boolean] $Enabled,
            [Parameter(ParameterSetName = "GetQuery", ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId,
            [switch] $Force
        )
        PROCESS {
    
            $params = @{}
            $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
            if ($PSBoundParameters.ContainsKey("Verbose")) {
                $params["Verbose"] = $Null
            }
            if ($null -ne $PSBoundParameters["Feature"]) {
                $Feature = $PSBoundParameters["Feature"] + "Enabled"
            }
            if ($null -ne $PSBoundParameters["Enabled"]) {
                $Enabled = $PSBoundParameters["Enabled"]
            }
            if ($PSBoundParameters.ContainsKey("Debug")) {
                $params["Debug"] = $PSBoundParameters["Debug"]
            }
            if($null -ne $PSBoundParameters["WarningVariable"])
            {
                $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
            }
            if($null -ne $PSBoundParameters["InformationVariable"])
            {
                $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
            }
            if($null -ne $PSBoundParameters["InformationAction"])
            {
                $params["InformationAction"] = $PSBoundParameters["InformationAction"]
            }
            if($null -ne $PSBoundParameters["OutVariable"])
            {
                $params["OutVariable"] = $PSBoundParameters["OutVariable"]
            }
            if($null -ne $PSBoundParameters["OutBuffer"])
            {
                $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
            }
            if($null -ne $PSBoundParameters["ErrorVariable"])
            {
                $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
            }
            if($null -ne $PSBoundParameters["PipelineVariable"])
            {
                $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
            }
            if($null -ne $PSBoundParameters["ErrorAction"])
            {
                $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
            }
            if($null -ne $PSBoundParameters["WarningAction"])
            {
                $params["WarningAction"] = $PSBoundParameters["WarningAction"]
            }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        if ([string]::IsNullOrWhiteSpace($TenantId)) {
            $OnPremisesDirectorySynchronizationId = (Get-MgBetaDirectoryOnPremiseSynchronization).Id
        }
        else {
            $OnPremisesDirectorySynchronizationId = Get-MgBetaDirectoryOnPremiseSynchronization -OnPremisesDirectorySynchronizationId $TenantId -ErrorAction SilentlyContinue -ErrorVariable er
            if ([string]::IsNullOrWhiteSpace($er)) {
                $OnPremisesDirectorySynchronizationId = $OnPremisesDirectorySynchronizationId.Id
            }
            else {
                throw "Set-EntraBetaDirsyncFeature :$er"
                break
            }
        }
    
        $body = @{
            features = @{ $Feature = $Enabled }
        }
        $body = $body | ConvertTo-Json
        if ($Force) {
            # If -Force is used, skip confirmation and proceed with the action.
            $decision = 0
        }
        else {
            $title = 'Confirm'
            $question = 'Do you want to continue?'
            $Suspend = new-Object System.Management.Automation.Host.ChoiceDescription "&Suspend", "S"
            $Yes = new-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Y"
            $No = new-Object System.Management.Automation.Host.ChoiceDescription "&No", "N"
            $choices = [System.Management.Automation.Host.ChoiceDescription[]]( $Yes, $No, $Suspend)
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        }
        if ($decision -eq 0) {
            $response = Update-MgBetaDirectoryOnPremiseSynchronization -Headers $customHeaders -OnPremisesDirectorySynchronizationId $OnPremisesDirectorySynchronizationId -BodyParameter $body -ErrorAction SilentlyContinue -ErrorVariable "er"
            $er
            break
            if ([string]::IsNullOrWhiteSpace($er)) {
                $response
            }
            else {
                Write-Error "Cannot bind parameter 'TenantId'. Cannot convert value `"$TenantId`" to type 
                    `"System.Guid`". Error: `"Guid should contain 32 digits with 4 dashes (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx).`" "
            }
    
        }
        else {
            return
        }
    
        
    }
}
    