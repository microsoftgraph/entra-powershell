function Invoke-EntraRequest {
    [CmdletBinding(DefaultParameterSetName="All")]
    param (
        [Parameter(Mandatory = $true)]
        [Uri]$Uri,
        
        [Parameter()]
        [ValidateSet("GET", "POST", "PUT", "DELETE", "PATCH")]
        [string]$Method = 'GET',
        
        [Parameter()]
        [PSObject]$Body,
        
        [Parameter()]
        [hashtable]$Headers=@{},
        
        [Parameter()]
        [string]$OutputFilePath,
        
        [Parameter()]
        [switch]$InferOutputFileName,
        
        [Parameter()]
        [string]$InputFilePath,
        
        [Parameter()]
        [switch]$PassThru,
        
        [Parameter()]
        [switch]$SkipHeaderValidation,
        
        [Parameter()]
        [string]$ContentType,
        
        [Parameter()]
        [string]$SessionVariable,
        
        [Parameter()]
        [string]$ResponseHeadersVariable,
        
        [Parameter()]
        [string]$StatusCodeVariable,
        
        [Parameter()]
        [switch]$SkipHttpErrorCheck,
        
        [Parameter()]
        [Microsoft.Graph.PowerShell.Authentication.Helpers.GraphRequestSession]$GraphRequestSession,
        
        [Parameter()]
        [string]$UserAgent,
        
        [Parameter()]
        [OutputType]$OutputType
        
    )
    $params=@{}

    # Create a hash table to store the parameters to pass to Invoke-MgGraphRequest cmdlet

    if($null -ne $PSBoundParameters["Uri"]) {
        $params["Uri"] = $PSBoundParameters["Uri"]
    }
    if($null -ne $PSBoundParameters["Method"]) {
        $params["Method"] = $PSBoundParameters["Method"]
    }
    if($null -ne $PSBoundParameters["Body"]) {
        $params["Body"] = $PSBoundParameters["Body"]
    }
    if($null -ne $PSBoundParameters["Headers"]) {
        $params["Headers"] = $PSBoundParameters["Headers"]
    }
    if($null -ne $PSBoundParameters["OutputFilePath"]) {
        $params["OutputFilePath"] = $PSBoundParameters["OutputFilePath"]
    }
    if($null -ne $PSBoundParameters["InferOutputFileName"]) {
        $params["InferOutputFileName"] = $true
    }
    if($null -ne $PSBoundParameters["InputFilePath"]) {
        $params["InputFilePath"] = $PSBoundParameters["InputFilePath"]
    }
    if($null -ne $PSBoundParameters["PassThru"]) {
        $params["PassThru"] = $true
    }
    if($null -ne $PSBoundParameters["SkipHeaderValidation"]) {
        $params["SkipHeaderValidation"] = $true
    }
    if($null -ne $PSBoundParameters["ContentType"]) {
        $params["ContentType"] = $PSBoundParameters["ContentType"]
    }
    if($null -ne $PSBoundParameters["SessionVariable"]) {
        $params["SessionVariable"] = $PSBoundParameters["SessionVariable"]
    }
    if($null -ne $PSBoundParameters["ResponseHeadersVariable"]) {
        $params["ResponseHeadersVariable"] = $PSBoundParameters["ResponseHeadersVariable"]
    }
    if($null -ne $PSBoundParameters["StatusCodeVariable"]) {
        $params["StatusCodeVariable"] = $PSBoundParameters["StatusCodeVariable"]
    }
    if($null -ne $PSBoundParameters["SkipHttpErrorCheck"]) {
        $params["SkipHttpErrorCheck"] = $true
    }
    if($null -ne $PSBoundParameters["GraphRequestSession"]) {
        $params["GraphRequestSession"] = $PSBoundParameters["GraphRequestSession"]
    }
    if($null -ne $PSBoundParameters["UserAgent"]) {
        $params["UserAgent"] = $PSBoundParameters["UserAgent"]
    }
    if($null -ne $PSBoundParameters["OutputType"]) {
        $params["OutputType"] = $PSBoundParameters["OutputType"]
    }

    # Map the Common Parameters
    
   if($PSBoundParameters.ContainsKey("Debug"))
    {
            $params["Debug"] = $Null
    }

    if($PSBoundParameters.ContainsKey("Verbose"))
    {
            $params["Verbose"] = $Null
    }
    if($null -ne $PSBoundParameters["Online"])
    {
            if($PSBoundParameters["Online"])
            {
                $params["Online"] = $PSBoundParameters["Online"]
            }
    }
    if($PSBoundParameters.ContainsKey("Debug"))
    {
            $params["Debug"] = $Null
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
    if($null -ne $PSBoundParameters["Top"])
    {
            $params["Top"] = $PSBoundParameters["Top"]
    }

    Write-Debug("============================ TRANSFORMATIONS ============================")
    $params.Keys | ForEach-Object {"$_ : $($params[$_])" } | Write-Debug
    Write-Debug("=========================================================================`n")

    # Call Invoke-MgGraphRequest with the prepared parameters
    Invoke-MgGraphRequest @params
}
