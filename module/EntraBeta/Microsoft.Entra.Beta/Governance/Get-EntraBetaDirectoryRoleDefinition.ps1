# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaDirectoryRoleDefinition {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Int32]] $Top,
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Filter,
    [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $SearchString,
    [Alias('Id')]
    [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $UnifiedRoleDefinitionId,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [switch] $All,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
    [System.String[]] $Property
    )
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $keysChanged = @{SearchString = "Filter"}
        if($null -ne $PSBoundParameters["UnifiedRoleDefinitionId"])
        {
            $params["UnifiedRoleDefinitionId"] = $PSBoundParameters["UnifiedRoleDefinitionId"]
        }
        if($null -ne $PSBoundParameters["Filter"])
        {
            $TmpValue = $PSBoundParameters["Filter"]
            foreach($i in $keysChanged.GetEnumerator()){
                $TmpValue = $TmpValue.Replace($i.Key, $i.Value)
            }
            $Value = $TmpValue
            $params["Filter"] = $Value
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }
        if($null -ne $PSBoundParameters["All"])
        {
            if($PSBoundParameters["All"])
            {
                $params["All"] = $PSBoundParameters["All"]
            }
        }
        if($null -ne $PSBoundParameters["SearchString"])
        {
            $TmpValue = $PSBoundParameters["SearchString"]
                     $Value = "startswith(displayName,'$TmpValue')"
            $params["Filter"] = $Value
        }
        if($PSBoundParameters.ContainsKey("Top"))
        {
            $params["Top"] = $PSBoundParameters["Top"]
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
        if($null -ne $PSBoundParameters["Property"])
        {
            $params["Property"] = $PSBoundParameters["Property"]
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Get-MgBetaRoleManagementDirectoryRoleDefinition @params -Headers $customHeaders
        $response | ForEach-Object {
            if($null -ne $_) {
            $propsToConvert = @('RolePermissions')
            foreach ($prop in $propsToConvert) {
                $value = $_.$prop | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                $_ | Add-Member -MemberType NoteProperty -Name $prop -Value ($value) -Force
            }
            Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
    
            }
        }
        
        $response
        }    
}

