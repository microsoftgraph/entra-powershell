# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName   = "Get-AzureADApplicationOwner"
    TargetName   = $null
    Parameters   = $null
    outputs      = $null
    CustomScript = @'
    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $topCount = $null
        $baseUri = 'https://graph.microsoft.com/v1.0/applications'
        $properties = '$select=*'
        $Method = "GET"        
        if($null -ne $PSBoundParameters["Property"])
        {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
        }
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["ApplicationId"] = $PSBoundParameters["ObjectId"]
            $URI = "$baseUri/$($params.ApplicationId)/owners?$properties"
        }
        if($null -ne $PSBoundParameters["All"])
        {
            $URI = "$baseUri/$($params.ApplicationId)/owners?$properties"
        }
        if($PSBoundParameters.ContainsKey("Top"))
        {
            $topCount = $PSBoundParameters["Top"]
            $URI = "$baseUri/$($params.ApplicationId)/owners?`$top=$topCount&$properties"
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = (Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method).value
        $response = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        $response | ForEach-Object {
            if($null -ne $_) {
                Add-Member -InputObject $_ -MemberType AliasProperty -Name ObjectId -Value Id
            }
        }
        if($response){
            $userList = @()
            foreach ($data in $response) {
                $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
                $data.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $userList += $userType
            }
            $userList
        }
    }
'@
}