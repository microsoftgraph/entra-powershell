# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
function Set-EntraBetaDirSyncFeature {
    <#
    .SYNOPSIS
        Used to set identity synchronization features for a tenant.
    
    .DESCRIPTION
        The Set-EntraBetaDirSyncFeature cmdlet is used to turn identity synchronization features on or off for 
        a tenant. Features that can be used with this cmdlet include:
        
            SynchronizeUpnForManagedUsers- allows for the synchronization of UserPrincipalName updates from on-premises for managed (non-federated) users that have been assigned a license. These updates will be blocked if this feature is not enabled. Once this feature is enabled it cannot be disabled.
    
            EnableSoftMatchOnUpn- Soft Match is the process used to link an object being synced from on-premises for the first time with one that already exists in the cloud. When this feature is enabled Soft Match will first be attempted using the standard logic, based on primary SMTP address. If a match is not found based on primary SMTP, then a match will be attempted based on UserPrincipalName. Once this feature is enabled it cannot be disabled.
    
            DuplicateUPNResiliency (preview)- normally if a user was attempted to be provisioned with a non-unique UserPrincipalName, the user would fail to be created/updated due to the uniqueness violation. When this feature is enabled the conflicting UPN value will be “quarantined”, a temporary UPN will be generated, and the user will be provisioned with that temporary UPN. This UPN will have the format of "<UserName>+<Random Integer>@<Tenant Initial Domain>.onmicrosoft.com".
    
            DuplicateProxyAddressResiliency (preview)- normally if an object was attempted to be provisioned with a non-unique ProxyAddress, the object would fail to be created/updated due to the uniqueness violation. When this feature is enabled the conflicting ProxyAddress value will be “quarantined” and the object will be provisioned without that specific ProxyAddress value.
    
    .PARAMETER Feature
        The DirSync feature to turn on or off.
    
    .PARAMETER Enable
        When true, the specified feature will be turned on for the company.
    
    .PARAMETER TenantId
        The unique ID of the tenant to perform the operation on. If this is not provided then the value will default to the tenant of the current user. This parameter is only applicable to partner users.
    
    .PARAMETER <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).
        
        
    .EXAMPLE
    --------------------------  Example 1  --------------------------
        
        Set-EntraBetaDirSyncFeature -Feature EnableSoftMatchOnUpn -Enable $true
        
        Description
        
        -----------
        
        Enables the SoftMatchOnUpn feature for the tenant.
    #>
        [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
        param (
            [Parameter(ParameterSetName = "GetQuery", Mandatory = $true, ValueFromPipelineByPropertyName = $true)][System.String] $Feature,
            [Parameter(ParameterSetName = "GetQuery", Mandatory = $true, ValueFromPipelineByPropertyName = $true)][System.Boolean] $Enabled,
            [Parameter(ParameterSetName = "GetQuery", ValueFromPipelineByPropertyName = $true)][System.Guid] $TenantId,
            [switch] $Force
        )
        PROCESS {
    
            $params = @{}
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
                $OnPremisesDirectorySynchronizationId = (Get-MgBetaDirectoryOnPremiseSynchronization).Id
            }
            else {
                $OnPremisesDirectorySynchronizationId = Get-MgBetaDirectoryOnPremiseSynchronization -OnPremisesDirectorySynchronizationId $TenantId -ErrorAction SilentlyContinue -ErrorVariable er
                if(![string]::IsNullOrWhiteSpace($er)) {
                    $OnPremisesDirectorySynchronizationId = $OnPremisesDirectorySynchronizationId.Id
                }
                else {
                    Write-Error "Cannot bind parameter 'TenantId'. Cannot convert value `"$TenantId`" to type 
                    `"System.Guid`". Error: `"Guid should contain 32 digits with 4 dashes (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx).`" "
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
                $response = Update-MgBetaDirectoryOnPremiseSynchronization -OnPremisesDirectorySynchronizationId $OnPremisesDirectorySynchronizationId -BodyParameter $body -ErrorAction SilentlyContinue -ErrorVariable "er"
                $er
                break
                if([string]::IsNullOrWhiteSpace($er)) {
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
    