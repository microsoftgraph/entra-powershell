# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADUserOwnedObject"
    TargetName = $null
    Parameters = $null
    Outputs = $null
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
        if ($null -ne $PSBoundParameters["UserId"]) {
            $params["UserId"] = $PSBoundParameters["UserId"]
        }
                

        $URI = "/beta/users/$($params.UserId)/ownedObjects"

        if($null -ne $PSBoundParameters["Property"])
        {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
            $URI = "/beta/users/$($params.UserId)/ownedObjects?$properties"
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $Method = "GET"

        $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method).value;
        
        $Top = $null
        if ($null -ne $PSBoundParameters["Top"]) {
            $Top = $PSBoundParameters["Top"]
        }

        if($Top -ne $null){
            $response | ForEach-Object {
                if ($null -ne $_ -and $Top -gt 0) {
                    $data=  $_ | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                }

                $Top = $Top - 1
            }
        }
        else {
            $response | ForEach-Object {
                if ($null -ne $_) {
                    $data= $_ | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                }
            }
        }

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