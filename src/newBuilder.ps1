hidden [CommandTranslation] NewFunctionURLMap11([PSCustomObject] $Command, [CommandUrlMap] $URLMapping ){
    Write-Host "Creating new function for $($Command.Generate) with graph URL"
    $parameterDefinitions ="";
    $ParamterTransformations="";
    if($Command.type -eq "new"){
        $parameterDefinitions =$this.GetParametersDefinitionsForNewURLCmd($URLMapping)
        write-host("parameterDefinitions  " +$parameterDefinitions)

        $ParamterTransformations = $this.GetParametersTransformationsFromUrlMappingNewURL($URLMapping)
        write-host("ParamterTransformations  " +$ParamterTransformations)
    }
    
    # else {
    #     $parameterDefinitions = $this.GetParametersDefinitionsForNewURLCmd($URLMapping)
    #     write-host("parameterDefinitions  " +$parameterDefinitions)
    #     $ParamterTransformations = $this.GetParametersTransformationsFromUrlMappingNewURL($URLMapping)
    #     write-host("ParamterTransformations  " +$ParamterTransformations)
    # }

    #$ParamterTransformations = $this.GetParametersTransformations($Command)
    $OutputTransformations = $this.GetOutputTransformations($Command)
    $keyId=''
    if($Command.type -ne "new"){
        $keyId = $this.GetKeyIdPair($Command)
    }
    $customHeadersCommandName = "New-EntraCustomHeaders"
    $URLCommand = $this.GetURLCommand($URLMapping)


    if($this.ModuleName -eq 'Microsoft.Graph.Entra.Beta')
    {
        $customHeadersCommandName = "New-EntraBetaCustomHeaders"
    }

    $function = @"
function $($Command.Generate) {
[CmdletBinding($($Command.DefaultParameterSet))]
param (
$parameterDefinitions
)

PROCESS {    
`$params = @{}
`$customHeaders = $customHeadersCommandName -Command `$MyInvocation.MyCommand
$($keyId)
$ParamterTransformations
Write-Debug("============================ TRANSFORMATIONS ============================")
`$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
Write-Debug("=========================================================================``n")

`$response = $($URLCommand) -Headers `$customHeaders
$OutputTransformations
`$response
}
}

"@
    $codeBlock = [Scriptblock]::Create($function)
    return [CommandTranslation]::New($Command.Generate,$Command.Old,$codeBlock)
}

hidden [string] GetOutputTransformations([PSCustomObject] $Command) {
    $responseVerbs = @("Get","Add","New")
    $output = ""

    if($this.CmdCustomizations.ContainsKey($Command.Old)) { 
        $cmd = $this.CmdCustomizations[$Command.Old] 
        if($null -ne $cmd.Outputs){                   
            foreach($key in $cmd.Outputs.GetEnumerator()) {
                $customOutput =  $cmd.Outputs[$key.Name]
                if([TransformationTypes]::Name -eq $customOutput.ConversionType){
                    $output += $this.GetOutputTransformationName($customOutput.Name, $customOutput.TargetName)
                }
                elseif([TransformationTypes]::ScriptBlock -eq $customOutput.ConversionType){
                    $output += $this.GetOutputTransformationCustom($customOutput)
                }
                elseif([TransformationTypes]::FlatObject -eq $customOutput.ConversionType){
                    $output += $this.GetOutputTransformationFlatObject($customOutput)
                }
            }
        }
    }
    
    foreach($key in $this.GenericOutputTransformations.GetEnumerator()) {
        $customOutput =  $this.GenericOutputTransformations[$key.Name]
        if(2 -eq $customOutput.ConversionType){
            $output += $this.GetOutputTransformationName($customOutput.Name, $customOutput.TargetName)
        }
        elseif([TransformationTypes]::ScriptBlock -eq $customOutput.ConversionType){
            $output += $this.GetOutputTransformationCustom($customOutput)
        }
        elseif([TransformationTypes]::FlatObject -eq $customOutput.ConversionType){
            $output += $this.GetOutputTransformationFlatObject($customOutput)
        }
    }             
                
    if("" -ne $output){
        $transform = @"
`$response | ForEach-Object {
    if(`$null -ne `$_) {
$($output)
    }
}
"@
        return $transform
    }
    return ""
}

hidden [string] GetURLCommand([CommandUrlMap] $URLMapping){
    switch ($URLMapping.Method) {
        "POST" { return " Invoke-GraphRequest -Uri $($URLMapping.URL) -Method  $($URLMapping.Method) -body `$params"}            
    }

    return ""
}

hidden [string] GetParametersDefinitionsForNewURLCmd([PSCustomObject] $Command) {
    $commonParameterNames = @("ProgressAction","Verbose", "Debug","ErrorAction", "ErrorVariable", "WarningAction", "WarningVariable", "OutBuffer", "PipelineVariable", "OutVariable", "InformationAction", "InformationVariable","WhatIf","Confirm")          
    
    $paramsList = @()
    foreach ($param in $Command.Parameters) {
        if($commonParameterNames.Contains($param.Name)) {
            continue
        }
        $paramBlock = @"
$($this.GetParameterAttributesNeweURL($Param))[$($param.DataType)] `$$($param.Name)
"@
        $paramsList += $paramBlock
    }
    
    return $paramsList -Join ",`n"
}

hidden [string] GetParametersTransformationsFromUrlMappingNewURL([CommandUrlMap] $URLMapping) {
    $paramsList = ""
     foreach ($param in $URLMapping.Parameters){
         $paramsList += $this.GetCustomParameterTransformation($param.Name)
     }
     return $paramsList
 }

 hidden [string] GetCustomParameterTransformation([string] $ParameterName){
    $paramBlock = @"
if(`$null -ne `$PSBoundParameters["$($ParameterName)"])
{
    `$params["$($ParameterName)"] = `$PSBoundParameters["$($ParameterName)"]
}

"@
    return $paramBlock
}

hidden [string] GetParameterAttributesNeweURL($param){
    $attributesString = ""

    
        $arrayAttrib = @()
        
        try {
            if($param.ParameterSetName -ne "__AllParameterSets"){
                $arrayAttrib += "ParameterSetName = `"$($param.ParameterSetName)`""
            }
        }
        catch {}                
        
       try {
            if($param.Mandatory){
                $arrayAttrib += "Mandatory = `$true"
            }
       }
       catch {}
            
       
       try {
            if($param.ValueFromPipeline){
                $arrayAttrib += "ValueFromPipeline = `$true"
            }
       }
       catch {}
            
        try {
            if($param.ValueFromPipelineByPropertyName){
                $arrayAttrib += "ValueFromPipelineByPropertyName = `$true"
            }
        }
        catch {}
       
        $strAttrib = $arrayAttrib -Join ', '

        if($strAttrib.Length -gt 0){
            $attributesString += "[Parameter($strAttrib)]`n    "
        }
    

    return $attributesString
}