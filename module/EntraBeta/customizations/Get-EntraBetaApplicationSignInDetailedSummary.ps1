@{
    SourceName = "Get-AzureADApplicationSignInDetailedSummary"
    TargetName = $null
    Parameters = $null
    Outputs = $null
    CustomScript = @"
    PROCESS {    
        `$params = @{}
        `$customHeaders = New-EntraCustomHeaders -Command `$MyInvocation.MyCommand
        `$keysChanged = @{}
        if(`$null -ne `$PSBoundParameters["Top"])
        {
            `$params["Top"] = `$PSBoundParameters["Top"]
        }
        if(`$null -ne `$PSBoundParameters["Filter"])
        {
            `$params["Filter"] = `$PSBoundParameters["Filter"]
        }
    
        if(`$PSBoundParameters.ContainsKey("Verbose"))
        {
            `$params["Verbose"] = `$Null
        }
        
        if(`$PSBoundParameters.ContainsKey("Debug"))
        {
            `$params["Debug"] = `$Null
        }
        Write-Debug("============================ TRANSFORMATIONS ============================")
        `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
        Write-Debug("=========================================================================`n")
        
        `$response = Get-MgBetaReportApplicationSignInDetailedSummary @params -Headers `$customHeaders
        `$response | ForEach-Object {
            if (`$null -ne `$_) {
                    `$value = `$_.Status | ConvertTo-Json | ConvertFrom-Json
                    `$_ | Add-Member -MemberType NoteProperty -Name Status -Value (`$value) -Force
            }
        }
        `$response
        }
"@
}
