# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraBetaObjectSetting {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The type of object to get settings for. For example, 'group' or 'servicePrincipal'.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $TargetType,
                
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies whether to return all object items.")]
        [switch] $All,
                
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the setting. Should be a valid GUID value.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $Id,
                
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the target object. Should be a valid GUID value.")]
        [ValidateNotNullOrEmpty()]
        [System.String] $TargetObjectId,
                
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Specifies the maximum number of items to return.")]
        [Alias("Limit")]
        [System.Nullable`1[System.Int32]] $Top,
        
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [Alias("Select")]
        [System.String[]] $Property
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes Directory.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {    
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $topCount = $null
        $baseUri = "/beta/$TargetType/$TargetObjectId/settings"
        $params["Method"] = "GET"
        $params["Uri"] = $baseUri + '?$select=*'

        if ($null -ne $PSBoundParameters["Property"]) {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $params["Uri"] = $baseUri + "?`$select=$($selectProperties)"
        }

        if ($PSBoundParameters.ContainsKey("Top") -and (-not $PSBoundParameters.ContainsKey("All"))) {
            $topCount = $PSBoundParameters["Top"]
            if ($topCount -gt 999) {
                $params["Uri"] += "&`$top=999"
            }
            else {
                $params["Uri"] += "&`$top=$topCount"
            }
        }

        if ($null -ne $PSBoundParameters["Id"]) {
            $Id = $PSBoundParameters["Id"]
            $params["Uri"] = "$baseUri/$($Id)"
        }

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $response = Invoke-GraphRequest @params -Headers $customHeaders
        $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        try {
            $data = $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $all = $All.IsPresent
            $increment = $topCount - $data.Count
            while ($response.'@odata.nextLink' -and (($all) -or ($increment -gt 0 -and -not $all))) {
                $params["Uri"] = $response.'@odata.nextLink'
                if (-not $all) {
                    $topValue = [Math]::Min($increment, 999)
                    $params["Uri"] = $params["Uri"].Replace('$top=999', "`$top=$topValue")
                    $increment -= $topValue
                }
                $response = Invoke-GraphRequest @params 
                $data += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            }
        }
        catch {}        

        $targetTypeList = @()

        foreach ($res in $data) {
            $target = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphDirectorySetting
            $res.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name.Substring(0, 1).ToUpper() + $_.Name.Substring(1)
                $propertyValue = $_.Value
                $target | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $targetTypeList += $target
        }

        $targetTypeList
    }    
}

