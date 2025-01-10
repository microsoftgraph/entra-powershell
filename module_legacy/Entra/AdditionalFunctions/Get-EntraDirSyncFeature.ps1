# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraDirSyncfeature {
        [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
        param (
            [Parameter(ParameterSetName = "GetQuery",  ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId,
            [Parameter(ParameterSetName = "GetQuery",  ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][System.String]$Feature
        )
        PROCESS {    
            $params = @{}
            $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
            if ($PSBoundParameters.ContainsKey("Verbose")) {
                $params["Verbose"] = $PSBoundParameters["Verbose"]
            }
            if ($null -ne $PSBoundParameters["Feature"]) {
                $Feature = $PSBoundParameters["Feature"]
            }
            if ($null -ne $PSBoundParameters["TenantId"]) {
                $params["OnPremisesDirectorySynchronizationId"] = $PSBoundParameters["TenantId"]
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
            $jsonData = Get-MgDirectoryOnPremiseSynchronization @params -Headers $customHeaders | ConvertTo-Json
            $object = ConvertFrom-Json $jsonData
            $table =@()
            foreach ($featureName in $object.Features.PSObject.Properties.Name) {
                $row = New-Object PSObject -Property @{
                    'DirSyncFeature' = $featureName -replace "Enabled", ""
                    'Enabled' = $object.Features.$featureName
                }
                $table += $row
            }
            if([string]::IsNullOrWhiteSpace($Feature)) {
                $table | Format-Table -AutoSize
            }
            else {
               $output =  $table | Where-Object {$_.dirsyncFeature -eq $Feature}
               if($null -eq $output) {
                Write-Error "Get-EntraDirSyncfeature : Invalid value for parameter.  Parameter Name: Feature."
               }
               else {
                $output
               }
            }
        }
    }