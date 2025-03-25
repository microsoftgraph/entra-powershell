# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Set-EntraBetaAttributeSet {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
    [Alias("Id")]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $AttributeSetId,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Description,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
    [System.Int32] $MaxAttributesPerSet
    )
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        
        if ($null -ne $PSBoundParameters["AttributeSetId"])
        {
            $params["AttributeSetId"] = $PSBoundParameters["AttributeSetId"]
        }
        if ($null -ne $PSBoundParameters["Description"])
        {
            $params["Description"] = $PSBoundParameters["Description"]
        }
        if ($null -ne $PSBoundParameters["MaxAttributesPerSet"])
        {
            $params["MaxAttributesPerSet"] = $PSBoundParameters["MaxAttributesPerSet"]
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = Update-MgBetaDirectoryAttributeSet @params -Headers $customHeaders
        $response
    }    
}

