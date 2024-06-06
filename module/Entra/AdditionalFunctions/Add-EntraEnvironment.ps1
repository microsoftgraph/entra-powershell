function Add-EntraEnvironment{
    [CmdletBinding(DefaultParameterSetName = 'AddQuery')]
      param (
      [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
      [System.String] $Name,
      [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
      [System.String] $AzureADEndpoint,
      [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
      [System.String] $GraphEndpoint
      )
  
      PROCESS{
        $params=@{}
         if ($PSBoundParameters.ContainsKey("Verbose")) {
              $params["Verbose"] = $Null
          }
         if ($PSBoundParameters.ContainsKey("Debug")) {
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
        if($null -ne $PSBoundParameters["Name"]){
           $params["Name"]=$PSBoundParameters["Name"]
         }
  
         if($null -ne $PSBoundParameters["AzureADEndpoint"]){
           $params["AzureADEndpoint"]=$PSBoundParameters["AzureADEndpoint"]
         }
  
         if($null -ne $PSBoundParameters["GraphEndpoint"]){
           $params["GraphEndpoint"]=$PSBoundParameters["GraphEndpoint"]
         }
  
          Write-Debug("============================ TRANSFORMATIONS ============================")
          $params.Keys | ForEach-Object { "$_ : $($params[$_])" } | Write-Debug
          Write-Debug("=========================================================================`n")
  
          Add-MgEnvironment @params
      
      }
  }
  
  
  