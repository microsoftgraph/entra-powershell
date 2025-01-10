# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADMSAttributeSet"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    [CmdletBinding(DefaultParameterSetName = 'InvokeByDynamicParameters')]
    param (
    [Alias('Id')]            
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $AttributeSetId,                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.Nullable`1[System.Int32]] $MaxAttributesPerSet,                
    [Parameter(ParameterSetName = "InvokeByDynamicParameters")]
    [System.String] $Description
    )

    PROCESS {    
    $params = @{}
    $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
    
    if ($null -ne $PSBoundParameters["AttributeSetId"])
    {
        $params["Id"] = $PSBoundParameters["AttributeSetId"]
    }
    if ($null -ne $PSBoundParameters["MaxAttributesPerSet"])
    {
        $params["MaxAttributesPerSet"] = $PSBoundParameters["MaxAttributesPerSet"]
    }
    if ($null -ne $PSBoundParameters["Description"])
    {
        $params["Description"] = $PSBoundParameters["Description"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")
    
    $response = New-MgBetaDirectoryAttributeSet @params -Headers $customHeaders
    $response | ForEach-Object {
        if($null -ne $_) {
        Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id

        }
    }
    $response
    }
'@
    
}