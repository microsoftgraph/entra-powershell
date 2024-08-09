# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "Get-AzureADUserOwnedObject"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    PROCESS {  
        $params = @{}
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        if ($null -ne $PSBoundParameters["ObjectId"]) {
            $params["UserId"] = $PSBoundParameters["ObjectId"]
        }

        if ($PSBoundParameters.ContainsKey("Debug")) {
            $params["Debug"] = $PSBoundParameters["Debug"]
        }

        if ($PSBoundParameters.ContainsKey("Verbose")) {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
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

        $URI = "/v1.0/users/$($params.UserId)/ownedObjects"

        if($null -ne $PSBoundParameters["Property"])
        {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
            $URI = "/v1.0/users/$($params.UserId)/ownedObjects?$properties"
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

        if($null -ne $Top){
            $userList = @()
            $response | ForEach-Object {
                if ($null -ne $_ -and $Top -gt 0) {
                    $data = $_ | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                    $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
                    $data.PSObject.Properties | ForEach-Object {
                        $propertyName = $_.Name
                        $propertyValue = $_.Value
                        $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                    }
                    $userList += $userType
                    $Top = $Top - 1
                }
            }
            $userList
        }
        else {
            $userList = @()
            $response | ForEach-Object {
                if ($null -ne $_) {
                    $data = $_ | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                    $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphDirectoryObject
                    $data.PSObject.Properties | ForEach-Object {
                        $propertyName = $_.Name
                        $propertyValue = $_.Value
                        $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                    }
                    $userList += $userType
                }
            }
            $userList
        }
    }
'@
}