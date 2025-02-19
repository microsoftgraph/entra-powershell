function Get-EntraBetaUserSponsor {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter to apply to the query.")]
        [System.String] $Filter,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The unique identifier (User ID) of the user whose sponsor information you want to retrieve.")]
        [System.String] $UserId,

        [Alias('Limit')]
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Maximum number of results to return.")]
        [System.Nullable`1[System.Int32]] $Top,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Retrieve all user's sponsors.")]
        [switch] $All,

        [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.String] $SearchString,

        [Alias('SponsorId')]
        [Parameter(ParameterSetName = "GetById", Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The User Sponsor ID to retrieve.")]
        [System.String] $DirectoryObjectId,

        [Alias('Select')]
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [System.String[]] $Property
    )

    PROCESS {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $topCount = $null
        $baseUri = "https://graph.microsoft.com/v1.0/users/$UserId/sponsors"
        $properties = '$select=*'
        $params["Method"] = "GET"
        $params["Uri"] = "$baseUri/?$properties"        
        if ($null -ne $PSBoundParameters["Property"]) {
            $selectProperties = $PSBoundParameters["Property"]
            $selectProperties = $selectProperties -Join ','
            $properties = "`$select=$($selectProperties)"
            $params["Uri"] = "$baseUri/?$properties"
        }
        if ($PSBoundParameters.ContainsKey("Top")) {
            $topCount = $PSBoundParameters["Top"]
            if ($topCount -gt 999) {
                $params["Uri"] += "&`$top=999"
            }
            else {
                $params["Uri"] += "&`$top=$topCount"
            }
        }        
        if ($null -ne $PSBoundParameters["DirectoryObjectId"]) {
            $params["Uri"] += "&`$filter=id eq '$DirectoryObjectId'"
        }
        if ($null -ne $PSBoundParameters["Filter"]) {
            $Filter = $PSBoundParameters["Filter"]
            $f = '$' + 'Filter'
            $params["Uri"] += "&$f=$Filter"
        }
        if ($null -ne $PSBoundParameters["SearchString"]) {
            $TmpValue = $PSBoundParameters["SearchString"]
            $SearchString = "`$search=`"userprincipalname:$TmpValue`" OR `"state:$TmpValue`" OR `"mailNickName:$TmpValue`" OR `"mail:$TmpValue`" OR `"jobTitle:$TmpValue`" OR `"displayName:$TmpValue`" OR `"department:$TmpValue`" OR `"country:$TmpValue`" OR `"city:$TmpValue`""
            $params["Uri"] += "&$SearchString"
        } 
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")   
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $($params.Uri) -Method GET | ConvertTo-Json -Depth 10 | ConvertFrom-Json
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