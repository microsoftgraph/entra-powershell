function Set-EntraBetaApplicationProxyApplicationSingleSignOn {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ObjectId,
    [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $SingleSignOnMode,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $KerberosDelegatedLoginIdentity,
    [Parameter(Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [String] $KerberosInternalApplicationServicePrincipalName
    )

    PROCESS {    
        $params = @{}
        $customHeaders = New-EntraBetaCustomHeaders -Command $MyInvocation.MyCommand
        $params["Method"] = "PATCH"
        $body = @{}
        if($null -ne $PSBoundParameters["ObjectId"])
        {
            $params["Uri"] = "https://graph.microsoft.com/beta/applications/$ObjectId"
        }
        if($null -ne $PSBoundParameters["SingleSignOnMode"])
        {
            $SingleSignOnMode = $PSBoundParameters["SingleSignOnMode"]
            $SingleSignOnMode = $SingleSignOnMode.Substring(0, 1).ToLower() + $SingleSignOnMode.Substring(1)
        }
        if($null -ne $PSBoundParameters["KerberosDelegatedLoginIdentity"])
        {
            $KerberosDelegatedLoginIdentity = $PSBoundParameters["KerberosDelegatedLoginIdentity"]
            $KerberosDelegatedLoginIdentity = $KerberosDelegatedLoginIdentity.Substring(0, 1).ToLower() + $KerberosDelegatedLoginIdentity.Substring(1)
        }
        if($null -ne $PSBoundParameters["KerberosInternalApplicationServicePrincipalName"])
        {
            $KerberosInternalApplicationServicePrincipalName = $PSBoundParameters["KerberosInternalApplicationServicePrincipalName"]
            $KerberosInternalApplicationServicePrincipalName = $KerberosInternalApplicationServicePrincipalName.Substring(0, 1).ToLower() + $KerberosInternalApplicationServicePrincipalName.Substring(1)
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
        $body = @{
            onPremisesPublishing = @{
                singleSignOnSettings = @{
                    singleSignOnMode = $SingleSignOnMode
                }
            }
        }
        
        if (-not [string]::IsNullOrWhiteSpace($KerberosInternalApplicationServicePrincipalName) -or -not [string]::IsNullOrWhiteSpace($KerberosDelegatedLoginIdentity) -and ($SingleSignOnMode -ne 'none' -and $SingleSignOnMode -ne 'headerbased'))
        {
            if ($KerberosInternalApplicationServicePrincipalName -eq '') {
                Write-Error "Set-EntraBetaApplicationProxyApplicationSingleSignOn : KerberosInternalApplicationServicePrincipalName is a required field for kerberos mode."
                break
            } 
            elseif ($KerberosDelegatedLoginIdentity -eq '') {
                Write-Error "Set-EntraBetaApplicationProxyApplicationSingleSignOn : KerberosDelegatedLoginIdentity is a required field for kerberos mode."
                break
            } 
            $body.onPremisesPublishing.singleSignOnSettings.kerberosSignOnSettings = @{
                kerberosServicePrincipalName = $KerberosInternalApplicationServicePrincipalName
                kerberosSignOnMappingAttributeType = $KerberosDelegatedLoginIdentity
            }             
        }
        
        $body = $body | ConvertTo-Json -Depth 10

        Write-Debug("============================ TRANSFORMATIONS ============================")
        $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")

        Invoke-GraphRequest -Headers $customHeaders -Method $params.method -Uri $params.uri -Body $body -ContentType "application/json"
    }        
}