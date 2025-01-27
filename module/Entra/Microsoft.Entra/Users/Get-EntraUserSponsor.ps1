function Get-EntraUserSponsor {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $UserId,
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Int32] $Top,
        [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [switch] $All,
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
        [System.String[]] $Property
    )

    PROCESS {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $Method = "GET"
        $baseUri = 'https://graph.microsoft.com/v1.0/users'
        $properties = '$select=*'
        if($null -ne $PSBoundParameters["Property"])
        {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
        }
        if($null -ne $PSBoundParameters["UserId"])
        {
            $params["UserId"] = $PSBoundParameters["UserId"]
            $URI = "$baseUri/$($params.UserId)/sponsors?$properties"
        }
        if($null -ne $PSBoundParameters["All"])
        {
            $URI = "$baseUri/$($params.UserId)/sponsors?$properties"
        }
        if($PSBoundParameters.ContainsKey("Top"))
        {
            $topCount = $PSBoundParameters["Top"]
            $URI = "$baseUri/$($params.UserId)/sponsors?`$top=$topCount&$properties"
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")   
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        try {
            $data = $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            $directoryObjectList = @()
            $all = $All.IsPresent
            $increment = $topCount - $data.Count

            while ($response.'@odata.nextLink' -and (($all -and ($increment -lt 0)) -or $increment -gt 0)) {
                $params["Uri"] = $response.'@odata.nextLink'
                if ($increment -gt 0) {
                    $topValue = [Math]::Min($increment, 999)
                    $params["Uri"] = $params["Uri"].Replace('$top=999', "`$top=$topValue")
                    $increment -= $topValue
                }
                $response = Invoke-GraphRequest -Headers $customHeaders -Uri $URI -Method $Method | ConvertTo-Json -Depth 10 | ConvertFrom-Json
                $data += $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
            }
        } catch {}
        
            foreach ($item in $data) {
                if ($null -ne $item) {
                    # Determine the type based on @odata.type
                    switch ($item.'@odata.type') {
                        '#microsoft.graph.user' {
                            $directoryObject = [Microsoft.Graph.PowerShell.Models.MicrosoftGraphUser]::new()
                        }
                        '#microsoft.graph.group' {
                            $directoryObject = [Microsoft.Graph.PowerShell.Models.MicrosoftGraphGroup]::new()
                        }
                        default {
                            Write-Warning "Unknown type: $($item.'@odata.type')"
                            continue
                        }
                    }
                    $item.PSObject.Properties | ForEach-Object {
                        $propertyName = $_.Name
                        $propertyValue = $_.Value
                        $directoryObject | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                    }     
                    $directoryObjectList += $directoryObject
                }
            }
           $directoryObjectList
        }
}
