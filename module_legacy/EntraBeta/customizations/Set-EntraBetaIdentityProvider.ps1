# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Set-AzureADMSIdentityProvider"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'   
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Type,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $ClientSecret,
    [Alias('Id')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $IdentityProviderBaseId,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $ClientId,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Name
    )
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $body = @{}        
        if($null -ne $PSBoundParameters["IdentityProviderBaseId"])
        {
            $params["IdentityProviderBaseId"] = $PSBoundParameters["IdentityProviderBaseId"]
        }
        if($null -ne $PSBoundParameters["Type"])
        {
            $body["identityProviderType"] = $PSBoundParameters["Type"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
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
        if($null -ne $PSBoundParameters["Name"])
        {
            $body["displayName"] = $PSBoundParameters["Name"]
        }
        if($null -ne $PSBoundParameters["ClientId"])
        {
            $body["clientId"] = $PSBoundParameters["ClientId"]
        }
        if($null -ne $PSBoundParameters["ClientSecret"])
        {
            $body["clientSecret"] = $PSBoundParameters["ClientSecret"]
        }
        $body["@odata.type"] = "#microsoft.graph.socialIdentityProvider"
        $params["BodyParameter"] = $body 
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Update-MgBetaIdentityProvider @params -Headers $customHeaders
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
    
            }
        }
        $response
    }
'@
}