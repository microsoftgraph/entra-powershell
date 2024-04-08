# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Set-EntraDirSyncFeature {
        [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
        param (
            [Parameter(ParameterSetName = "GetQuery", Mandatory = $true, ValueFromPipelineByPropertyName = $true)][System.String] $Feature,
            [Parameter(ParameterSetName = "GetQuery", Mandatory = $true, ValueFromPipelineByPropertyName = $true)][System.Boolean] $Enabled,
            [Parameter(ParameterSetName = "GetQuery", ValueFromPipelineByPropertyName = $true)][ValidateNotNullOrEmpty()][ValidateScript({if ($_ -is [System.Guid]) { $true } else {throw "TenantId must be of type [System.Guid]."}})][System.Guid] $TenantId,
            [switch] $Force
        )
        PROCESS {
    
            $params = @{}
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
            if ($PSBoundParameters.ContainsKey("Verbose")) {
                $Verbose = $Null
            }
            if ($null -ne $PSBoundParameters["Feature"]) {
                $Feature = $PSBoundParameters["Feature"] + "Enabled"
            }
            if ($null -ne $PSBoundParameters["Enabled"]) {
                $Enabled = $PSBoundParameters["Enabled"]
            }
            if ($PSBoundParameters.ContainsKey("Debug")) {
                $params["Debug"] = $Null
            }
    
            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")
            if ([string]::IsNullOrWhiteSpace($TenantId)) {
                $OnPremisesDirectorySynchronizationId = (Get-MgDirectoryOnPremiseSynchronization).Id
            }
            else {
                $OnPremisesDirectorySynchronizationId = $TenantId
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
                $response = Update-MgDirectoryOnPremiseSynchronization -Headers $customHeaders -OnPremisesDirectorySynchronizationId $OnPremisesDirectorySynchronizationId -BodyParameter $body 
                $response
            }
            else {
                return
            }
    
        
        }
    }