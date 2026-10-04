# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 

function Get-EntraBetaUserSponsor {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Filter to apply to the query.")]
        [System.String] $Filter,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The unique identifier (User ID) of the user whose sponsor information you want to retrieve.")]
        [Alias('ObjectId', 'UPN', 'Identity', 'UserPrincipalName')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -match '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' -or 
                    $_ -match '^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$') {
                    return $true
                }
                throw "UserId must be a valid email address or GUID."
            })]
        [System.String] $UserId,

        [Alias('Limit')]
        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Maximum number of results to return.")]
        [System.Nullable`1[System.Int32]] $Top,

        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Retrieve all user's sponsors.")]
        [switch] $All,

        [Alias('DirectoryObjectId')]
        [Parameter(ParameterSetName = "GetById", Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "The User Sponsor ID to retrieve.")]
        [System.String] $SponsorId,

        [Alias('Select')]
        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true, HelpMessage = "Properties to include in the results.")]
        [System.String[]] $Property
    )

    begin {
        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes User.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }
    }

    PROCESS {
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $topCount = $null
        $baseUri = "/beta/users/$UserId/sponsors"
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
        if ($null -ne $PSBoundParameters["SponsorId"]) {
            $params["Uri"] += "&`$filter=id eq '$SponsorId'"
        }
        if ($null -ne $PSBoundParameters["Filter"]) {
            $Filter = $PSBoundParameters["Filter"]
            $f = '$' + 'Filter'
            $params["Uri"] += "&$f=$Filter"
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")   
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $($params.Uri) -Method GET | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        try {
            $data = $response.value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
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
        }
        catch {}

        if ($data) {
            $memberList = @()
            foreach ($response in $data) {
                $memberType = New-Object Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphDirectoryObject
                if (-not ($response -is [PSObject])) {
                    $response = [PSCustomObject]@{ Value = $response }
                }
                $response.PSObject.Properties | ForEach-Object {
                    $propertyName = $_.Name
                    $propertyValue = $_.Value
                    $memberType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
                }
                $memberType.PSTypeNames.Insert(0, "Microsoft.Entra.Beta.User.Simple")
                $memberList += $memberType
            }
            return $memberList
        }
    }
}