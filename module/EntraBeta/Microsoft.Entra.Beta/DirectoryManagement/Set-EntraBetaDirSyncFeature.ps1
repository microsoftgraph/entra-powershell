# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Set-EntraBetaDirSyncFeature {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    [OutputType([System.String])]
    param (
        [Parameter(ParameterSetName = 'GetQuery', Mandatory = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "specifies the directory synchronization feature(s) to turn on or off")]
        [Alias("Feature")]     
        [ValidateScript({
            if ($_ -eq $null -or $_.Count -eq 0) {
                throw "The 'Features' parameter cannot be null or empty. Please provide at least one feature."
            }

            foreach ($item in $_) {
                if ([string]::IsNullOrWhiteSpace($item)) {
                    throw "Each feature must be a non-empty string. Invalid item: '$item'"
                }
            }

            return $true
        })]
        [System.String[]] $Features,

        [Parameter(ParameterSetName = 'GetQuery', Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Boolean]
        $Enabled,

        [Parameter(ParameterSetName = 'GetQuery', ValueFromPipelineByPropertyName = $true)]
        [Obsolete('This parameter provides compatibility with Azure AD and MSOnline for partner scenarios. TenantID is the signed-in user''s tenant ID. It should not be used for any other purpose.')]
        [System.Guid]$TenantId,

        [switch]
        $Force
    )

    begin {
        $params = @{}
        $featuresCollection = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if ($PSBoundParameters.ContainsKey('Verbose')) {
            $params['Verbose'] = $Null
        }
        if ($null -ne $PSBoundParameters['Enabled']) {
            $Enabled = $PSBoundParameters['Enabled']
        }
        if ($PSBoundParameters.ContainsKey("Feature")) {
            foreach ($feature in $Features) {
                if ($feature.ToLower().EndsWith("enabled")) {
                    $featuresCollection[$feature] = $Enabled
                } else {
                    $featuresCollection[$feature + "Enabled"] = $Enabled
                }
            }
        }
        if ($PSBoundParameters.ContainsKey('Debug')) {
            $params['Debug'] = $PSBoundParameters['Debug']
        }
        if ($null -ne $PSBoundParameters['WarningVariable']) {
            $params['WarningVariable'] = $PSBoundParameters['WarningVariable']
        }
        if ($null -ne $PSBoundParameters['InformationVariable']) {
            $params['InformationVariable'] = $PSBoundParameters['InformationVariable']
        }
        if ($null -ne $PSBoundParameters['InformationAction']) {
            $params['InformationAction'] = $PSBoundParameters['InformationAction']
        }
        if ($null -ne $PSBoundParameters['OutVariable']) {
            $params['OutVariable'] = $PSBoundParameters['OutVariable']
        }
        if ($null -ne $PSBoundParameters['OutBuffer']) {
            $params['OutBuffer'] = $PSBoundParameters['OutBuffer']
        }
        if ($null -ne $PSBoundParameters['ErrorVariable']) {
            $params['ErrorVariable'] = $PSBoundParameters['ErrorVariable']
        }
        if ($null -ne $PSBoundParameters['PipelineVariable']) {
            $params['PipelineVariable'] = $PSBoundParameters['PipelineVariable']
        }
        if ($null -ne $PSBoundParameters['ErrorAction']) {
            $params['ErrorAction'] = $PSBoundParameters['ErrorAction']
        }
        if ($null -ne $PSBoundParameters['WarningAction']) {
            $params['WarningAction'] = $PSBoundParameters['WarningAction']
        }
        Write-Debug('============================ TRANSFORMATIONS ============================')
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    }

    process {
        if ([string]::IsNullOrWhiteSpace($TenantId)) {
            $OnPremisesDirectorySynchronizationId = (Get-MgBetaDirectoryOnPremiseSynchronization).Id
        }
        else {
            $OnPremisesDirectorySynchronizationId = Get-MgBetaDirectoryOnPremiseSynchronization -OnPremisesDirectorySynchronizationId $TenantId -ErrorAction SilentlyContinue -ErrorVariable er
            if ([string]::IsNullOrWhiteSpace($er)) {
                $OnPremisesDirectorySynchronizationId = $OnPremisesDirectorySynchronizationId.Id
            }
            else {
                throw "Set-EntraBetaDirSyncFeature :$er"
                break
            }
        }

        $body = @{
            features = $featuresCollection
        }
        $body = $body | ConvertTo-Json
        if ($Force) {
            # If -Force is used, skip confirmation and proceed with the action.
            $decision = 0
        }
        else {
            $title = 'Confirm'
            $question = 'Do you want to continue?'
            $Suspend = New-Object System.Management.Automation.Host.ChoiceDescription '&Suspend', 'S'
            $Yes = New-Object System.Management.Automation.Host.ChoiceDescription '&Yes', 'Y'
            $No = New-Object System.Management.Automation.Host.ChoiceDescription '&No', 'N'
            $choices = [System.Management.Automation.Host.ChoiceDescription[]]( $Yes, $No, $Suspend)
            $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        }
        if ($decision -eq 0) {
            $response = Update-MgBetaDirectoryOnPremiseSynchronization -Headers $customHeaders -OnPremisesDirectorySynchronizationId $OnPremisesDirectorySynchronizationId -BodyParameter $body -ErrorAction SilentlyContinue -ErrorVariable 'er'
            $er
            break
            if ([string]::IsNullOrWhiteSpace($er)) {
                $response
            }
            else {
                Write-Error "Cannot bind parameter 'TenantId'. Cannot convert value `"$TenantId`" to type
                    `"System.Guid`". Error: `"Guid should contain 32 digits with 4 dashes (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx).`""
            }

        }
        else {
            return
        }
    }

    end { }
}

