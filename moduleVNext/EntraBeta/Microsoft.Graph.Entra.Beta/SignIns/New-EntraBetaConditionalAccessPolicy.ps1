# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaConditionalAccessPolicy {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls] $GrantControls,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $ModifiedDateTime,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $State,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $DisplayName,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $CreatedDateTime,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [Microsoft.Open.MSGraph.Model.ConditionalAccessSessionControls] $SessionControls,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Id,
                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet] $Conditions
    )

    PROCESS {    
    $params = @{}
    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
    if($null -ne $PSBoundParameters["GrantControls"])
    {
        $TmpValue = $PSBoundParameters["GrantControls"]
                    $hash = @{}
            if($TmpValue._Operator) { $hash["Operator"] = $TmpValue._Operator }
            if($null -ne $TmpValue.BuiltInControls) { $hash["BuiltInControls"] = $TmpValue.BuiltInControls }
            if($TmpValue.CustomAuthenticationFactors) { $hash["CustomAuthenticationFactors"] = $TmpValue.CustomAuthenticationFactors }
            if($TmpValue.TermsOfUse) { $hash["TermsOfUse"] = $TmpValue.TermsOfUse }

            $Value = $hash
        $params["GrantControls"] = $Value
    }
    if ($null -ne $PSBoundParameters["ModifiedDateTime"])
    {
        $params["ModifiedDateTime"] = $PSBoundParameters["ModifiedDateTime"]
    }
    if ($null -ne $PSBoundParameters["WarningVariable"])
    {
        $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
    }
    if ($null -ne $PSBoundParameters["State"])
    {
        $params["State"] = $PSBoundParameters["State"]
    }
    if ($null -ne $PSBoundParameters["OutVariable"])
    {
        $params["OutVariable"] = $PSBoundParameters["OutVariable"]
    }
    if ($null -ne $PSBoundParameters["DisplayName"])
    {
        $params["DisplayName"] = $PSBoundParameters["DisplayName"]
    }
    if ($null -ne $PSBoundParameters["PipelineVariable"])
    {
        $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
    }
    if ($null -ne $PSBoundParameters["InformationVariable"])
    {
        $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
    }
    if ($null -ne $PSBoundParameters["ErrorVariable"])
    {
        $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
    }
    if ($null -ne $PSBoundParameters["CreatedDateTime"])
    {
        $params["CreatedDateTime"] = $PSBoundParameters["CreatedDateTime"]
    }
    if($null -ne $PSBoundParameters["SessionControls"])
    {
        $TmpValue = $PSBoundParameters["SessionControls"]
                    $Value = @{}
            $TmpValue.PSObject.Properties | foreach {
                $propName = $_.Name
                $propValue = $_.Value
                if ($propValue -is [System.Object]) {
                    $nestedProps = @{}
                    $propValue.PSObject.Properties | foreach {
                        $nestedPropName = $_.Name
                        $nestedPropValue = $_.Value
                        $nestedProps[$nestedPropName] = $nestedPropValue
                    }
                    $Value[$propName] = $nestedProps
                } 
            }
        $params["SessionControls"] = $Value
    }
    if($PSBoundParameters.ContainsKey("Debug"))
    {
        $params["Debug"] = $PSBoundParameters["Debug"]
    }
    if ($null -ne $PSBoundParameters["ProgressAction"])
    {
        $params["ProgressAction"] = $PSBoundParameters["ProgressAction"]
    }
    if($PSBoundParameters.ContainsKey("Verbose"))
    {
        $params["Verbose"] = $PSBoundParameters["Verbose"]
    }
    if ($null -ne $PSBoundParameters["Id"])
    {
        $params["Id"] = $PSBoundParameters["Id"]
    }
    if ($null -ne $PSBoundParameters["ErrorAction"])
    {
        $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
    }
    if ($null -ne $PSBoundParameters["InformationAction"])
    {
        $params["InformationAction"] = $PSBoundParameters["InformationAction"]
    }
    if ($null -ne $PSBoundParameters["OutBuffer"])
    {
        $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
    }
    if ($null -ne $PSBoundParameters["WarningAction"])
    {
        $params["WarningAction"] = $PSBoundParameters["WarningAction"]
    }
    if($null -ne $PSBoundParameters["Conditions"])
    {
        $TmpValue = $PSBoundParameters["Conditions"]
                    $Value = @{}
            $TmpValue.PSObject.Properties | foreach {
                $propName = $_.Name
                $propValue = $_.Value
                if ($propName -eq 'clientAppTypes') {
                    $Value[$propName] = $propValue
                }
                elseif ($propValue -is [System.Object]) {
                    $nestedProps = @{}
                    $propValue.PSObject.Properties | foreach {
                        $nestedPropName = $_.Name
                        $nestedPropValue = $_.Value
                        $nestedProps[$nestedPropName] = $nestedPropValue
                    }
                    $Value[$propName] = $nestedProps
                } 
            }
        $params["Conditions"] = $Value
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $response = New-MgBetaIdentityConditionalAccessPolicy @params -Headers $customHeaders
    $response | ForEach-Object {
        if($null -ne $_) {
        Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

        }
    }
    $response
    }
}

