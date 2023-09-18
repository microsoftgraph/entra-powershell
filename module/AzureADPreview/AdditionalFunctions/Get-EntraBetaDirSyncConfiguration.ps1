# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraBetaDirSyncConfiguration {
    <#
    .PARAMETER TenantId
    
    .PARAMETER <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216). 
    
    .INPUTS 
        System.Nullable`1[[System.Guid, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]]
    
    
    #>
        [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
        param (
            [Parameter(ParameterSetName = "GetQuery", Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][System.guid] $TenantId
        )
    
        PROCESS {    
            $params = @{}
            $keysChanged = @{$TenantId = "OnPremisesDirectorySynchronizationId" }
            if ($PSBoundParameters.ContainsKey("Verbose")) {
                $params["Verbose"] = $Null
            }
            if ($null -ne $PSBoundParameters["TenantId"]) {
                $params["OnPremisesDirectorySynchronizationId"] = $PSBoundParameters["TenantId"]
            }
            if ($PSBoundParameters.ContainsKey("Debug")) {
                $params["Debug"] = $Null
            }
            Write-Debug("============================ TRANSFORMATIONS ============================")
            $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
            Write-Debug("=========================================================================`n")
            $response = ((Get-MgBetaDirectoryOnPremiseSynchronization @params -ErrorVariable Eq -erroraction SilentlyContinue).configuration | Select-Object -Property AccidentalDeletionPrevention).AccidentalDeletionPrevention
            # Create a custom table
            if ($null -ne $eq) {
                write-error "Get-EntraBetaDirSyncConfiguration : Cannot bind parameter 'TenantId'. Cannot convert value `"$($params["OnPremisesDirectorySynchronizationId"])`" to type `"System.Guid`". Error: `"Guid should contain 32 digits with 4 dashes (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx).`"
                "
            }
            else {
                $customTable = [PSCustomObject]@{
                    "AccidentalDeletionThreshold" = $response.AlertThreshold
                    "DeletionPreventionType"      = $response.SynchronizationPreventionType
                }
                $customTable | Format-Table
            }
        }
    }