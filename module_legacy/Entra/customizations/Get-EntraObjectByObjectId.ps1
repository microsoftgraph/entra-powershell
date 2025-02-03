# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADObjectByObjectId"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $body = @{}        
        $URI = 'https://graph.microsoft.com/v1.0/directoryObjects/microsoft.graph.getByIds?$select=*'
        if($null -ne $PSBoundParameters["Property"])
        {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
            $URI = "https://graph.microsoft.com/v1.0/directoryObjects/microsoft.graph.getByIds?$properties"
        }
        if($null -ne $PSBoundParameters["Types"])
        {
            $body["Types"] = $PSBoundParameters["Types"]
        }
        if($null -ne $PSBoundParameters["ObjectIds"])
        {
            $body["Ids"] = $PSBoundParameters["ObjectIds"]
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        $response = Invoke-GraphRequest -Uri $URI  -Method POST -Body $body -Headers $customHeaders | ConvertTo-Json -depth 10 | ConvertFrom-Json
        try {
            $response = $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        }
        catch {}
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