# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaApplicationKeyCredential {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies a custom identifier for the key credential.")]
        [System.String] $CustomKeyIdentifier,
            
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the start date and time from which the key credential is valid.")]
        [System.Nullable[System.DateTime]] $StartDate,
            
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the end date and time after which the key credential expires.")]
        [System.Nullable[System.DateTime]] $EndDate,
            
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the value of the key credential, typically the public key in base64-encoded format.")]
        [System.String] $Value,
            
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the type of key credential (e.g., AsymmetricX509Cert, Symmetric).")]
        [System.Nullable[Microsoft.Open.AzureAD.Graph.PowerShell.Custom.KeyType]] $Type,

        [Alias('ObjectId')]            
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the unique identifier (ObjectId) of the application to which the key credential is added.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $ApplicationId,
            
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the usage of the key credential (e.g., Sign, Verify).")]
        [System.Nullable[Microsoft.Open.AzureAD.Graph.PowerShell.Custom.KeyUsage]] $Usage
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
        if ($null -ne $PSBoundParameters["Value"]) {
            $params["Value"] = $PSBoundParameters["Value"]
        }
        if ($null -ne $PSBoundParameters["ProgressAction"]) {
            $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
        }
        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if ($null -ne $PSBoundParameters["OutBuffer"]) {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if ($null -ne $PSBoundParameters["WarningVariable"]) {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if ($null -ne $PSBoundParameters["WarningAction"]) {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if ($null -ne $PSBoundParameters["CustomKeyIdentifier"]) {
            $params["CustomKeyIdentifier"] = $PSBoundParameters["CustomKeyIdentifier"]
        }
        if ($null -ne $PSBoundParameters["ApplicationId"]) {
            $params["ApplicationId"] = $PSBoundParameters["ApplicationId"]
        }
        if ($null -ne $PSBoundParameters["OutVariable"]) {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if ($null -ne $PSBoundParameters["StartDate"]) {
            $params["StartDate"] = $PSBoundParameters["StartDate"]
        }
        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if ($null -ne $PSBoundParameters["PipelineVariable"]) {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if ($null -ne $PSBoundParameters["Type"]) {
            $params["Type"] = $PSBoundParameters["Type"]
        }
        if ($null -ne $PSBoundParameters["InformationAction"]) {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if ($null -ne $PSBoundParameters["InformationVariable"]) {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
        if ($null -ne $PSBoundParameters["EndDate"]) {
            $params["EndDate"] = $PSBoundParameters["EndDate"]
        }
        if ($null -ne $PSBoundParameters["Usage"]) {
            $params["Usage"] = $PSBoundParameters["Usage"]
        }
        if ($null -ne $PSBoundParameters["ErrorAction"]) {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if ($null -ne $PSBoundParameters["ErrorVariable"]) {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Add-MgBetaApplicationKey @params -Headers $customHeaders
        $response | ForEach-Object {
            if ($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

            }
        }
        $response
    }
}

