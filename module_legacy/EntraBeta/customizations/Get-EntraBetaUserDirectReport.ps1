# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADUserDirectReport"
    TargetName = $null
    Parameters = $null
    outputs = $null
    CustomScript = @'  
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.Int32]] $Top,
    [Alias('ObjectId')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $UserId,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [switch] $All,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
    [System.String[]] $Property
    ) 
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $topCount = $null
        $baseUri = 'https://graph.microsoft.com/beta/users'
        $properties = '$select=*'
        $Method = "GET"
       
        if($null -ne $PSBoundParameters["Property"])
        {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
        }        
        if($null -ne $PSBoundParameters["UserId"])
        {
            $params["UserId"] = $PSBoundParameters["UserId"]
            $URI = "$baseUri/$($params.UserId)/directReports?$properties"
        }
        
        if($null -ne $PSBoundParameters["All"])
        {
            $URI = "$baseUri/$($params.UserId)/directReports?$properties"
        }        
        if($PSBoundParameters.ContainsKey("Top"))
        {
            $topCount = $PSBoundParameters["Top"]
            $URI = "$baseUri/$($params.UserId)/directReports?`$top=$topCount&$properties"
        }        
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method).value
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        
        $targetList = @()
        foreach ($res in $data) {
            $targetType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphDirectoryObject
            $res.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name.Substring(0,1).ToUpper() + $_.Name.Substring(1)
                $propertyValue = $_.Value
                $targetType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $targetList += $targetType
        }
        $targetList 
        }
'@
}