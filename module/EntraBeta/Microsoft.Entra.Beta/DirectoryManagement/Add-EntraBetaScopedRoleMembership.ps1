# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Add-EntraBetaScopedRoleMembership {
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $RoleObjectId,    
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $AdministrativeUnitObjectId,
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [Microsoft.Open.MSGraph.Model.MsRoleMemberInfo] $RoleMemberInfo,
    [Alias('ObjectId')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $AdministrativeUnitId
    )
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        if($null -ne $PSBoundParameters["ErrorAction"])
        {
            $params["ErrorAction"] = $PSBoundParameters["ErrorAction"]
        }
        if($null -ne $PSBoundParameters["PipelineVariable"])
        {
            $params["PipelineVariable"] = $PSBoundParameters["PipelineVariable"]
        }
        if($null -ne $PSBoundParameters["OutVariable"])
        {
            $params["OutVariable"] = $PSBoundParameters["OutVariable"]
        }
        if($null -ne $PSBoundParameters["InformationAction"])
        {
            $params["InformationAction"] = $PSBoundParameters["InformationAction"]
        }
        if($null -ne $PSBoundParameters["WarningVariable"])
        {
            $params["WarningVariable"] = $PSBoundParameters["WarningVariable"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if($null -ne $PSBoundParameters["RoleObjectId"])
        {
            $params["RoleId"] = $PSBoundParameters["RoleObjectId"]
        }
        if($null -ne $PSBoundParameters["ErrorVariable"])
        {
            $params["ErrorVariable"] = $PSBoundParameters["ErrorVariable"]
        }
        if($null -ne $PSBoundParameters["AdministrativeUnitId"])
        {
            $params["AdministrativeUnitId"] = $PSBoundParameters["AdministrativeUnitId"]
        }
        if($null -ne $PSBoundParameters["OutBuffer"])
        {
            $params["OutBuffer"] = $PSBoundParameters["OutBuffer"]
        }
        if($null -ne $PSBoundParameters["WarningAction"])
        {
            $params["WarningAction"] = $PSBoundParameters["WarningAction"]
        }
        if($null -ne $PSBoundParameters["RoleMemberInfo"])
        {
            $TmpValue = $PSBoundParameters["RoleMemberInfo"]
                        $Value = @{
                            id = ($TmpValue).Id
                        } | ConvertTo-Json
            $params["RoleMemberInfo"] = $Value
        }
        if($null -ne $PSBoundParameters["AdministrativeUnitObjectId"])
        {
            $params["AdministrativeUnitId1"] = $PSBoundParameters["AdministrativeUnitObjectId"]
        }
        if($null -ne $PSBoundParameters["InformationVariable"])
        {
            $params["InformationVariable"] = $PSBoundParameters["InformationVariable"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = New-MgBetaDirectoryAdministrativeUnitScopedRoleMember @params -Headers $customHeaders
        $response | ForEach-Object {
            if($null -ne $_) {
            Add-Member -InputObject $_ -MemberType AliasProperty -Name AdministrativeUnitObjectId -Value AdministrativeUnitId
            Add-Member -InputObject $_ -MemberType AliasProperty -Name RoleObjectId -Value RoleId
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            $propsToConvert = @('RoleMemberInfo')
                    try{
                        foreach ($prop in $propsToConvert) {
                            $value = $_.$prop | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                            $_ | Add-Member -MemberType NoteProperty -Name $prop -Value ($value) -Force
                        }
                    }catch{} 
    
            }
        }
        $response
    }    
}

