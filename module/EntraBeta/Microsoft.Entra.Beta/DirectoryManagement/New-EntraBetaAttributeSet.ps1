# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function New-EntraBetaAttributeSet {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
    [Alias('Id')]            
    [Parameter(ParameterSetName = "Default")]
    [System.String] $AttributeSetId,
    
    [Parameter(ParameterSetName = "Default")]
    [System.Nullable`1[System.Int32]] $MaxAttributesPerSet,

    [Parameter(ParameterSetName = "Default")]
    [System.String] $Description
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes CustomSecAttributeDefinition.ReadWrite.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

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
}

