# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
@{
    SourceName = "New-AzureADApplicationPasswordCredential"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @'
    [CmdletBinding(DefaultParameterSetName = '')]
    param (
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.DateTime]] $EndDate,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $CustomKeyIdentifier,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.Nullable`1[System.DateTime]] $StartDate,
    [Alias('ObjectId')]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ApplicationId,
    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Value
    )
    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        
        $body=@{}

        if($null -ne $PSBoundParameters["StartDate"])
        {
            $body["startDateTime"] = $PSBoundParameters["StartDate"]
        }
        if($null -ne $PSBoundParameters["EndDate"])
        {
            $body["endDateTime"] = $PSBoundParameters["EndDate"]
        }
        if($null -ne $PSBoundParameters["CustomKeyIdentifier"])
        {
            $body["displayName"] = $PSBoundParameters["CustomKeyIdentifier"]
        }
        if($null -ne $PSBoundParameters["ApplicationId"])
        {
            $params["ApplicationId"] = $PSBoundParameters["ApplicationId"]
        }
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $PSBoundParameters["Verbose"]
        }
        if($PSBoundParameters.ContainsKey("Debug"))
        {
            $params["Debug"] = $PSBoundParameters["Debug"]
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
        $params["PasswordCredential"] = $body

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================
")
        
        $response = Add-MgBetaApplicationPassword @params -Headers $customHeaders 
        $response | ForEach-Object {
            If($_.DisplayName){
                $Value = [System.Text.Encoding]::ASCII.GetBytes($_.DisplayName)
                Add-Member -InputObject $_ -MemberType NoteProperty -Name CustomKeyIdentifier -Value $Value -Force
            }
            Add-Member -InputObject $_ -MemberType AliasProperty -Name Value -Value SecretText
        }
        $response
    }   
'@
}