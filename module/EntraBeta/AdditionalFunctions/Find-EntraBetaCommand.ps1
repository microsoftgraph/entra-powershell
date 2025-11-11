function Find-EntraBetaCommand {
    [CmdletBinding(DefaultParameterSetName = 'GetQuery')]
    param (
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Command,
    [Parameter(ParameterSetName = "GetQuery", ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
    [System.String] $Uri,
    [Parameter(ParameterSetName = "GetQuery", Mandatory = $false, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [System.String] $ApiVersion="v1.0"
    )

    PROCESS {    
        $params = @{}
        if($null -ne $PSBoundParameters["Command"])
        {
            $params["Command"]=$PSBoundParameters["Command"]
        }
        if($null -ne $PSBoundParameters["Uri"])
        {
            $params["Uri"] = $PSBoundParameters["Uri"]
        }
        if($null -ne $PSBoundParameters["ApiVersion"])
        {
            $params["ApiVersion"] = $PSBoundParameters["ApiVersion"]
        }
        
        if($PSBoundParameters.ContainsKey("Verbose"))
        {
            $params["Verbose"] = $Null
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

        #Look up to map from a Cmdlet to the Uris. 
        $dictionary=@{}

        ###############################################################################################################################
        #TODO: ADD NEW CMDLETS -> URIs MAPPINGS HERE
        $dictionary["Set-EntraBetaApplicationProxyApplication"]=@("applications/{object-id}","applications/{object-Id}/connectorGroup")
        $dictionary["New-EntraBetaApplicationProxyApplication"]=@("applications/{object-id}","/servicePrincipals","applications/{object-Id}/connectorGroup")
        $dictionary["Remove-EntraBetaApplicationProxyApplicationConnectorGroup"]=@("applications/{object-Id}/connectorGroup")
        

        ##############################################################################################################################

        $responses=@()
        # keyCmdlet is the commandlet that maps to more than one API call.
        $keyCmdlet=$params["Command"]
      
       if ($null -ne $keyCmdlet) {
        if($dictionary.ContainsKey($keyCmdlet)){
         $uris = $dictionary.$keyCmdlet
        
          foreach($uri in $uris){
             $response=Find-MgGraphCommand -Uri $uri -ApiVersion beta
             if($null -ne $response){
                $responses+=$response
             }  
           }
        }
        
       } else {
        #Invoke the Find-MgGraphCommand with the params
        $responses=Find-MgGraphCommand @params -ApiVersion beta
      }

      #Map the Command names and Module names 
        foreach($response in $responses){
             $commandValue=$response.Command
             $newCommandValue=$commandValue -replace '(Mg|MgGraph)', "Entra"
             $response.Command=$newCommandValue

             $appValue=$response.Module
             $newAppValue=$appValue -replace "Beta", "EntraBeta"
             $response.Module=$newAppValue
        }

        $responses
    }        
}