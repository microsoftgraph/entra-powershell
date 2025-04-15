# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
function Get-EntraAuthenticationMethodUserRegistrationDetailReport {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
        [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, HelpMessage = "Unique ID of the user's registered authentication methods from the 'userRegistrationDetails' object.")]
        [Alias('Id')]
        [System.String] $UserRegistrationDetailsId ,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Specifies the number of items to return.")]
        [Alias("Limit")]
        [System.Int32] $Top,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Specifies whether to return all items.")]
        [switch] $All,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Filter the results based on the specified criteria.")]
        [System.String] $Filter,

        [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Specifies the property to sort by. Use property name for ascending, or property name with 'desc' suffix for descending (e.g., 'displayName' or 'displayName desc').")]
        [Alias("OrderBy", "SortBy")]
        [System.String] $Sort,

        [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $false, HelpMessage = "Specifies the properties to include in the response.")]
        [Alias("Select")]
        [System.String[]] $Property
    )

    begin {

        # Ensure connection to Microsoft Entra
        if (-not (Get-EntraContext)) {
            $errorMessage = "Not connected to Microsoft Graph. Use 'Connect-Entra -Scopes AuditLog.Read.All' to authenticate."
            Write-Error -Message $errorMessage -ErrorAction Stop
            return
        }

    }

    PROCESS {    
        $params = @{}
        $topCount = 0
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $baseUri = "/v1.0/reports/authenticationMethods/userRegistrationDetails"
        $properties = "`$select=*"
    
        if ($PSBoundParameters.ContainsKey("Property")) {
            $selectProperties = $Property -join ','
            $properties = "`$select=$selectProperties"
        }
    
        if ($PSBoundParameters.ContainsKey("UserRegistrationDetailsId")) {
            $userRegistrationDetailsId = $PSBoundParameters["UserRegistrationDetailsId"]
            $params["Uri"] = "${baseUri}/${userRegistrationDetailsId}?$properties"
        }
        else {
            $params["Uri"] = "${baseUri}?$properties"
            
            if ($PSBoundParameters.ContainsKey("Top")) {
                $topCount = $Top
                $params["Uri"] += if ($topCount -gt 999) { "&`$top=999" } else { "&`$top=$topCount" }
            }
    
            if ($PSBoundParameters.ContainsKey("Filter")) {
                $params["Uri"] += "&`$filter=$Filter"
            }

            if ($PSBoundParameters.ContainsKey("Sort")) {
                $params["Uri"] += "&`$orderBy=$($PSBoundParameters['Sort'])"
            }
        }
    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
    
        $response = Invoke-GraphRequest -Headers $customHeaders -Uri $params["Uri"] -Method GET
    
        try {
            if ($PSBoundParameters.ContainsKey("UserRegistrationDetailsId")) {
                $data = @($response)
            }
            else {
                $data = $response.value
                $all = $All.IsPresent
                $increment = $topCount - ($data.Count)
    
                while ($response.PSObject.Properties["`@odata.nextLink"] -and (($all -and $increment -lt 0) -or $increment -gt 0)) {
                    $params["Uri"] = $response.'@odata.nextLink'
                    if ($increment -gt 0) {
                        $topValue = [Math]::Min($increment, 999)
                        $params["Uri"] = $params["Uri"].Replace('`$top=999', "`$top=$topValue")
                        $increment -= $topValue
                    }
                    $response = Invoke-GraphRequest @params
                    $data += $response.value
                }
            }

            return $data | Select-Object *
        }
        catch {
            Write-Error "An error occurred while retrieving data: $_"
        }
    }
}
Set-Alias -Name Get-EntraAuthMethodUserRegistrationDetailReport -Value Get-EntraAuthenticationMethodUserRegistrationDetailReport -Description "Retrieves the user's registered authentication methods." -Scope Global -Force
