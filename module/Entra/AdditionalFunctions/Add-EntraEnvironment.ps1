function Add-EntraEnvironment{
    [CmdletBinding(DefaultParameterSetName = '')]
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
        $customHeaders = New-EntraCustomHeaders -Command $MyInvocation.MyCommand
  
         if ($PSBoundParameters.ContainsKey("Verbose")) {
              $params["Verbose"] = $Null
          }
         if ($PSBoundParameters.ContainsKey("Debug")) {
              $params["Debug"] = $Null
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
  
          Add-MgEnvironment @params  -Headers $customHeaders
      
      }
  
  
  }
  
  
  