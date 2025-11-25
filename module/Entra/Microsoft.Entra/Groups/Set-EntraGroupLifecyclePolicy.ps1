# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Set-EntraGroupLifecyclePolicy {
    [CmdletBinding(DefaultParameterSetName = 'ByGroupLifecyclePolicyId')]
    param (                
        [Parameter(ParameterSetName = "ByGroupLifecyclePolicyId", HelpMessage = "A list of email addresses to which notifications are sent. The email addresses must be valid and separated by semicolons.")]
        [System.String] $AlternateNotificationEmails,
                
        [Parameter(ParameterSetName = "ByGroupLifecyclePolicyId", HelpMessage = "The group type for which the expiration policy applies. Possible values are All`, Selected or None.")]
        [System.String] $ManagedGroupTypes,
        
        [Alias('Id')]            
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "A unique identifier for a policy. Should be a valid GUID value.")]
        [ValidateNotNullOrEmpty()]
        [Guid] $GroupLifecyclePolicyId,
                
        [Parameter(ParameterSetName = "ByGroupLifecyclePolicyId", HelpMessage = "Number of days before a group expires and needs to be renewed. Once renewed`, the group expiration is extended by the number of days defined.")]
        [System.Nullable`1[System.Int32]] $GroupLifetimeInDays
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Directory.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
    
        if ($null -ne $PSBoundParameters["AlternateNotificationEmails"]) {
            $params["AlternateNotificationEmails"] = $PSBoundParameters["AlternateNotificationEmails"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["ManagedGroupTypes"]) {
            $params["ManagedGroupTypes"] = $PSBoundParameters["ManagedGroupTypes"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["GroupLifecyclePolicyId"]) {
            $params["GroupLifecyclePolicyId"] = $PSBoundParameters["GroupLifecyclePolicyId"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["GroupLifetimeInDays"]) {
            $params["GroupLifetimeInDays"] = $PSBoundParameters["GroupLifetimeInDays"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["ProgressAction"]) {
            $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Update-MgGroupLifecyclePolicy @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }
}

