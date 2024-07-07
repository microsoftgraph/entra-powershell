function Get-EntraFeatureRolloutPolicy {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Id,
    [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $SearchString,
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Filter,
    [Parameter(Mandatory = $false, ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
    [System.String[]] $Property
    )

    PROCESS {
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
        $params = @{}
        $baseUri = 'https://graph.microsoft.com/beta/policies/featureRolloutPolicies/'
        $params["Method"] = "GET"
        $params["Uri"] = "$baseUri"
        
        if($null -ne $PSBoundParameters["Id"])
        {
            $Id = $PSBoundParameters["Id"]
            $params["Uri"] += "$($Id)/?"
        }
        if($null -ne $PSBoundParameters["SearchString"])
        {
            $FilterValue = $PSBoundParameters["SearchString"]
            $filter="displayName eq '$FilterValue' or startswith(displayName,'$FilterValue')"
            $f = '$' + 'Filter'
            $params["Uri"] += "?$f=$filter&"
        }
        if($null -ne $PSBoundParameters["Filter"])
        {
            $Filter = $PSBoundParameters["Filter"]
            $f = '$' + 'Filter'
            $params["Uri"] += "?$f=$Filter&"
        } 
	    
        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        $data = Invoke-GraphRequest @params -Headers $customHeaders | ConvertTo-Json | ConvertFrom-Json
        try {    
            $data = $data.value | ConvertTo-Json | ConvertFrom-Json
        }
        catch {}       
       
        if($null -ne $PSBoundParameters["Property"]){
            $data = $data | Select-Object $Property
        }

        $userList = @()
        foreach ($response in $data) {
            $userType = New-Object Microsoft.Graph.PowerShell.Models.MicrosoftGraphFeatureRolloutPolicy
            $response.PSObject.Properties | ForEach-Object {
                $propertyName = $_.Name
                $propertyValue = $_.Value
                $userType | Add-Member -MemberType NoteProperty -Name $propertyName -Value $propertyValue -Force
            }
            $userList += $userType
        }
        $userList 
    }
}