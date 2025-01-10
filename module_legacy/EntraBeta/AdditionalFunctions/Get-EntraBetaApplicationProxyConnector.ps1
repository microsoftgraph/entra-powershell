# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

function Get-EntraBetaApplicationProxyConnector {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(ParameterSetName = "GetVague", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $SearchString,
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Int32] $Top,
    [Parameter(ParameterSetName = "GetById", Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [Alias("Id")]
    [System.String] $OnPremisesPublishingProfileId,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [switch] $All,
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Filter
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Method"] = "GET"
        $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectors"
        if($null -ne $PSBoundParameters["SearchString"])
        {
            $f = '$' + 'Filter'
            $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectors?$f=machineName eq '$SearchString' OR startswith(machineName,'$SearchString')"    
        }
        if($null -ne $PSBoundParameters["OnPremisesPublishingProfileId"])
        {
            $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectors/$OnPremisesPublishingProfileId"
        }
        if($null -ne $PSBoundParameters["Filter"])
        {
            $f = '$' + 'Filter'
            $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectors?$f=$filter"
        }        
        if($null -ne $PSBoundParameters["All"])
        {
            $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectors"
        }        
        if($PSBoundParameters.ContainsKey("Top"))
        {
            $t = '$' + 'Top'
            $params["Uri"] = "https://graph.microsoft.com/beta/onPremisesPublishingProfiles/applicationProxy/connectors?$t=$top"
        }        

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        $response = Invoke-GraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri 
        
        try {    
            $data = $response.Value | ConvertTo-Json -Depth 10 | ConvertFrom-Json
        }
        catch {
            $data = $response | ConvertTo-Json -Depth 10 | ConvertFrom-Json
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
}