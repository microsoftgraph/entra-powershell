# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Get-EntraDirSyncfeature {
    <#
    .SYNOPSIS
        Used to check the status of identity synchronization features for a tenant.
    
    
    .DESCRIPTION
        The Get-EntraDirSyncfeature cmdlet is used to check the status of identity synchronization features for a tenant. Features that can be used with this cmdlet include:
    
            DeviceWriteback
            DirectoryExtensions
            DuplicateProxyAddressResiliency
            DuplicateUPNResiliency
            EnableSoftMatchOnUpn
            PasswordSync
            SynchronizeUpnForManagedUsers
            UnifiedGroupWriteback
            UserWriteback
    
            The cmdlet can also be run without any feature being specified, in which case it will return a list of all features and whether they are enabled or disabled.
    
    .PARAMETER Feature
        The DirSync feature to get the status of.
    
        
    .PARAMETER TenantId
        The unique ID of the tenant to perform the operation on. If this is not provided then the value will default to the tenant of the current user. This parameter is only applicable to partner users.
    
    
    .PARAMETER <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see 
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).
    
    .EXAMPLE
        Get-EntraDirSyncfeature
    
        Description
    
        -----------
    
        Returns a list of all possible DirSync features and whether they are enabled (True) or disabled (False).
    
    
    .EXAMPLE
        Get-EntraDirSyncfeature -Feature PasswordSync
    s
        Description
        
        -----------
        
        Returns whether PasswordSync is enabled for the tenant (True) or disabled (False).
    
    #>
        [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
        param (
            [Parameter(ParameterSetName = "GetQuery",  ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId,
            [Parameter(ParameterSetName = "GetQuery",  ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][System.String]$Feature
        )
        PROCESS {    
            $params = @{}
            if ($PSBoundParameters.ContainsKey("Verbose")) {
                $params["Verbose"] = $Null
            }
            if ($null -ne $PSBoundParameters["Feature"]) {
                $Feature = $PSBoundParameters["Feature"]
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
            $jsonData = Get-MgDirectoryOnPremiseSynchronization @params | ConvertTo-Json
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