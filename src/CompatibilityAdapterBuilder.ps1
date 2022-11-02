# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

class CompatibilityAdapterBuilder {
    [string] $SourceModuleName
    [string[]] $SourceModulePrefixs
    [string] $NewPrefix
    [string[]] $DestinationModuleName
    [string[]] $DestinationPrefixs
    [string] $ModuleName
    hidden [string[]] $MissingCommandsToMap = @()
    hidden [hashtable] $CmdCustomizations = @{}
    hidden [hashtable] $GenericParametersTransformations = @{}
    hidden [hashtable] $GenericOutputTransformations = @{}
    hidden [string] $OutputFolder = (join-path $PSScriptRoot '../bin')
    hidden [MappedCmdCollection] $ModuleMap = $null
    hidden [bool] $GenerateCommandsToMapData
    hidden [hashtable] $HelperCmdletsToExport = @{}
    hidden [string] $LoadMessage

    # Constructor that changes the output folder, load all the Required Modules and creates the output folder.
    CompatibilityAdapterBuilder() {        
        $this.Configure("../config/ModuleSettings.json")
    }

    CompatibilityAdapterBuilder([string] $ModuleSettingsPath){        
        $this.Configure($ModuleSettingsPath)
    }

    hidden Configure([string] $ModuleSettingsPath){
        $settingPath = Join-Path $PSScriptRoot $ModuleSettingsPath
        $content = Get-Content -Path $settingPath | ConvertFrom-Json
        $this.SourceModuleName = $content.sourceModule
        $this.SourceModulePrefixs = $content.sourceModulePrefix
        $this.NewPrefix = $content.newPrefix
        $this.DestinationModuleName = $content.destinationModuleName
        $this.DestinationPrefixs = $content.destinationPrefix
        $this.ModuleName = $content.moduleName
        Import-Module $this.SourceModuleName | Out-Null
        foreach ($moduleName in $this.DestinationModuleName){
            Import-Module $moduleName | Out-Null
        }

        if(!(Test-Path $this.OutputFolder)){
            New-Item -ItemType Directory -Path $this.OutputFolder | Out-Null
        }

        $this.LoadMessage = $content.loadMessage
    }

    # Generates the module then generates all the files required to create the module.
    BuildModule() {
        $this.WriteModuleFile()   
        $this.WriteModuleManifest()     
    }
    
        # Add customization based on the the CommandMap object.
    AddCustomization([hashtable[]] $Commands) {
        foreach($cmd in $Commands) {
            $parameters = $null
            $outputs = $null
            if($cmd.Parameters){
                $parameters = @{}
                foreach($param in $cmd.Parameters){
                    if($null -eq $cmd.SourceName) {
                        $this.GenericParametersTransformations.Add($param.SourceName, [DataMap]::New($param.SourceName, $param.TargetName, $param.ConversionType, [Scriptblock]::Create($param.SpecialMapping)))
                    }
                    else{
                        $parameters.Add($param.SourceName, [DataMap]::New($param.SourceName, $param.TargetName, $param.ConversionType, [Scriptblock]::Create($param.SpecialMapping)))
                    }
                }
            }
            
            if($cmd.Outputs){
                $outputs = @{}
                foreach($param in $cmd.Outputs){
                    if($null -eq $cmd.SourceName) {
                        $this.GenericOutputTransformations.Add($param.SourceName, [DataMap]::New($param.SourceName, $param.TargetName, $param.ConversionType, [Scriptblock]::Create($param.SpecialMapping)))
                    }
                    else{
                        $outputs.Add($param.SourceName, [DataMap]::New($param.SourceName, $param.TargetName, $param.ConversionType, [Scriptblock]::Create($param.SpecialMapping)))
                    }
                }
            }

            if($null -ne $cmd.SourceName) {
                $customCommand = [CommandMap]::New($cmd.SourceName,$cmd.TargetName, $parameters, $outputs)
                $this.CmdCustomizations.Add($cmd.SourceName, $customCommand)
            }
        }
    }

    AddHelperCommand([string] $FileName){
        $properties = Get-ItemProperty -Path $FileName
        if($null -ne $properties){
            $name = $properties.PSChildName.Replace(".ps1","")
            $this.HelperCmdletsToExport.Add($name, $(Get-Content -Path $FileName) -join "`n")
        }
    }
    
    hidden WriteModuleFile() {       
        $filePath = Join-Path $this.OutputFolder "$($this.ModuleName).psm1"
        #This call create the mapping used to create the final module.
        $data = $this.Map()

        $psm1FileContent = $this.GetFileHeader()
        foreach($cmd in $data.Commands) {
            $psm1FileContent += $cmd.CommandBlock
        }

        $psm1FileContent += $this.GetAlisesFunction()        
        foreach($function in $this.HelperCmdletsToExport.GetEnumerator()){
            $psm1FileContent += $function.Value
        }
        $psm1FileContent += $this.GetExportMemeber()        
        $psm1FileContent += $this.SetMissingCommands()
        $psm1FileContent += $this.LoadMessage
        $psm1FileContent | Out-File -FilePath $filePath
    }

    hidden WriteModuleManifest() {
        $settingPath = "../config/ModuleMetadata.json"
        $settingPath = Join-Path $PSScriptRoot $settingPath
        $files = @("$($this.ModuleName).psd1", "$($this.ModuleName).psm1")
        $content = Get-Content -Path $settingPath | ConvertFrom-Json
        $PSData = @{
            Tags = $($content.tags)
            LicenseUri = $($content.licenseUri)
            ProjectUri = $($content.projectUri)
            IconUri = $($content.iconUri)
            ReleaseNotes = $($content.releaseNotes)
            ExternalModuleDependencies = $($content.requiredModules)
        }
        $manisfestPath = Join-Path $this.OutputFolder "$($this.ModuleName).psd1"
        $functions = $this.ModuleMap.CommandsList + "Set-CompatADAlias"
        $moduleSettings = @{
            Path = $manisfestPath
            ModuleVersion = "$($content.version)"
            FunctionsToExport = $functions
            Author =  $($content.authors)
            CompanyName = $($content.owners)
            FileList = $files
            RootModule = "$($this.ModuleName).psm1" 
            Description = 'Microsoft Graph PowerShell Compatibility for AzureAD.'    
            DotNetFrameworkVersion = $([System.Version]::Parse('4.7.2')) 
            PowerShellVersion = $([System.Version]::Parse('5.1'))
            CompatiblePSEditions = @('Desktop','Core')
            RequiredModules = $content.requiredModules
        }
        
        $this.LoadMessage = $this.LoadMessage.Replace("{VERSION}", $content.version)
        New-ModuleManifest @moduleSettings
        Update-ModuleManifest -Path $manisfestPath -PrivateData $PSData
    }

    # Creates the ModuleMap object, this is mainly used by other methods but can be called when debugging or finding missing cmdlets
    hidden [MappedCmdCollection] Map(){
        $this.ModuleMap = [MappedCmdCollection]::new($this.ModuleName)
        $originalCmdlets = $this.GetModuleCommands($this.SourceModuleName, $this.SourceModulePrefixs, $true)
        $targetCmdlets = $this.GetModuleCommands($this.DestinationModuleName, $this.DestinationPrefixs, $true)
        $newCmdletData = @()
        $cmdletsToExport = @()
        $missingCmdletsToExport = @()
        foreach ($cmd in $originalCmdlets.Keys){
            $originalCmdlet = $originalCmdlets[$cmd]
            $newFunction = $this.GetNewCmdTranslation($cmd, $originalCmdlet, $targetCmdlets, $this.NewPrefix)
            if($newFunction){
                $newCmdletData += $newFunction
                $cmdletsToExport += $newFunction.Generate                
            }
            else{  
                $missingCmdletsToExport += $cmd                          
                $this.MissingCommandsToMap += $cmd
            } 
        }

        foreach($function in $this.HelperCmdletsToExport.GetEnumerator()){
            $cmdletsToExport += $function.Key
        }
      
        $this.ModuleMap.CommandsList = $cmdletsToExport
        $this.ModuleMap.MissingCommandsList = $missingCmdletsToExport
        $this.ModuleMap.Commands = $this.NewModuleMap($newCmdletData)

        return $this.ModuleMap
    }    

    hidden [scriptblock] GetAlisesFunction() {
        if($this.ModuleMap){
            $aliases = ''
            foreach ($func in $this.ModuleMap.Commands) {       
                $aliases += "   Set-Alias -Name $($func.SourceName) -Value $($func.Name) -Scope Global -Force`n"
            }
    $aliasFunction = @"
function Set-CompatADAlias {
$($aliases)}

"@
            return [Scriptblock]::Create($aliasFunction)
        }

        return $null
    }

    hidden [scriptblock] GetExportMemeber() {
        $CommandsToExport = $this.ModuleMap.CommandsList
        $CommandsToExport += "Set-CompatADAlias"
        $functionsToExport = @"
Export-ModuleMember -Function @(
    '$($CommandsToExport -Join "','")'
)

"@
        return [Scriptblock]::Create($functionsToExport)
    }

    hidden [scriptblock] SetMissingCommands() {
        $missingCommands = @"
Set-Variable -name MISSING_CMDS -value @('$($this.ModuleMap.MissingCommandsList -Join "','")') -Scope Global -Option ReadOnly -Force

"@
        return [Scriptblock]::Create($missingCommands)
    }

    hidden [CommandTranslation[]] NewModuleMap([PSCustomObject[]] $Commands) {
        [CommandTranslation[]] $translations = @()
        foreach($Command in $Commands){
            $translations += $this.NewFunctionMap($Command)
        }
        return $translations
    }

    hidden [CommandTranslation] NewFunctionMap([PSCustomObject] $Command){
        $parameterDefinitions = $this.GetParametersDefinitions($Command)
        $ParamterTransformations = $this.GetParametersTransformations($Command)
        $OutputTransformations = $this.GetOutputTransformations($Command)
        $keyId = $this.GetKeyIdPair($Command)
        $function = @"
function $($Command.Generate) {
    [CmdletBinding($($Command.DefaultParameterSet))]
    param (
$parameterDefinitions
    )

    PROCESS {    
    `$params = @{}
    $($keyId)
$ParamterTransformations
    Write-Debug("============================ TRANSFORMATIONS ============================")
    `$params.Keys | ForEach-Object {"`$_ : `$(`$params[`$_])" } | Write-Debug
    Write-Debug("=========================================================================``n")
    
    `$response = $($Command.New) @params
$OutputTransformations
    `$response
    }
}

"@
        $codeBlock = [Scriptblock]::Create($function)
        return [CommandTranslation]::New($Command.Generate,$Command.Old,$codeBlock)
    }

    hidden [string] GetParametersDefinitions([PSCustomObject] $Command) {
        $commonParameterNames = @("Verbose", "Debug","ErrorAction", "ErrorVariable", "WarningAction", "WarningVariable", "OutBuffer", "PipelineVariable", "OutVariable", "InformationAction", "InformationVariable")  
        $params = $(Get-Command -Name $Command.Old).Parameters
        $paramsList = @()
        foreach ($paramKey in $Command.Parameters.Keys) {
            if($commonParameterNames.Contains($paramKey)) {
                continue
            }
            $param = $params[$paramKey]
            $paramBlock = @"
    $($this.GetParameterAttributes($Param))[$($param.ParameterType.ToString())] `$$($param.Name)
"@
            $paramsList += $paramBlock
        }

        return $paramsList -Join ",`n"
    }

    hidden [string] GetParameterAttributes($param){
        $attributesString = ""

        foreach($attrib in $param.Attributes){
            $arrayAttrib = @()
            if($attrib.ParameterSetName -ne "__AllParameterSets"){
                $arrayAttrib += "ParameterSetName = `"$($attrib.ParameterSetName)`""
            }
            if($attrib.Mandatory){
                $arrayAttrib += "Mandatory = `$true"
            }
            if($attrib.ValueFromPipeline){
                $arrayAttrib += "ValueFromPipeline = `$true"
            }
            if($attrib.ValueFromPipelineByPropertyName){
                $arrayAttrib += "ValueFromPipelineByPropertyName = `$true"
            }
            $strAttrib = $arrayAttrib -Join ', '

            if($strAttrib.Length -gt 0){
                $attributesString = "[Parameter($strAttrib)]"
            }
        }

        return $attributesString
    }

    hidden [string] GetParametersTransformations([PSCustomObject] $Command) {
        $paramsList = ""

        foreach ($paramKey in $Command.Parameters.Keys) {        
            $param = $Command.Parameters[$paramKey]
            $paramBlock = ""
            
            if(1 -eq $param.ConversionType){
                $paramBlock = $this.GetParameterTransformationName($param.Name, $param.Name)
            }
            elseif(2 -eq $param.ConversionType){
                $paramBlock = $this.GetParameterTransformationName($param.Name, $param.TargetName)
            }
            elseif(3 -eq $param.ConversionType){
                $paramBlock = $this.GetParameterTransformationBoolean2Switch($param.Name, $param.TargetName)
            }
            elseif(4 -eq $param.ConversionType){
                $paramBlock = $this.GetParameterTransformationSystemSwitch($param.Name)
            }
            elseif(98 -eq $param.ConversionType){
                $paramBlock = $this.GetParameterException($param)
            }
            elseif(99 -eq $param.ConversionType){
                $paramBlock = $this.GetParameterCustom($param)
            }
            
            $paramsList += $paramBlock            
        }
            
        return $paramsList
    }

    hidden [string] GetKeyIdPair($Command){        
        $keys = @()
        foreach ($paramKey in $Command.Parameters.Keys) {        
            $param = $Command.Parameters[$paramKey]
            if($param.NameChanged){
                if($param.Name -eq "ObjectId"){
                    $keys += "$($param.Name) = `"Id`""
                }
                elseif($param.Name -eq "Id"){
                }
                else{
                    $keys += "$($param.Name) = `"$($param.TargetName)`""
                }
            }            
        }
            
        return "`$keysChanged = @{$($keys -Join "; ")}"
    }

    hidden [string] GetParameterTransformationName([string] $OldName, [string] $NewName){
        $paramBlock = @"
    if(`$null -ne `$PSBoundParameters["$($OldName)"])
    {
        `$params["$($NewName)"] = `$PSBoundParameters["$($OldName)"]
    }

"@
        return $paramBlock
    }

    hidden [string] GetParameterTransformationBoolean2Switch([string] $OldName, [string] $NewName){
        $paramBlock = @"
    if(`$null -ne `$PSBoundParameters["$($OldName)"])
    {
        if(`$PSBoundParameters["$($OldName)"])
        {
            `$params["$($NewName)"] = `$Null
        }
    }

"@
        return $paramBlock
    }

    hidden [string] GetParameterTransformationSystemSwitch([string] $Name){
        $paramBlock = @"
    if(`$PSBoundParameters.ContainsKey("$($Name)"))
    {
        `$params["$($Name)"] = `$Null
    }

"@
        return $paramBlock
    }


    hidden [string] GetParameterException([DataMap] $Param){
        $paramBlock = ""
        return $paramBlock
    }

    hidden [string] GetParameterCustom([DataMap] $Param){
        $paramBlock = @"
    if(`$null -ne `$PSBoundParameters["$($Param.Name)"])
    {
        `$TmpValue = `$PSBoundParameters["$($Param.Name)"]
        $($Param.SpecialMapping)
        `$params["$($Param.TargetName)"] = `$Value
    }

"@
        return $paramBlock
    }
    
    hidden [string] GetOutputTransformations([PSCustomObject] $Command) {
        $responseVerbs = @("Get","Add","New")
        $output = ""
    
        if($this.CmdCustomizations.ContainsKey($Command.Old)) { 
            $cmd = $this.CmdCustomizations[$Command.Old] 
            if($null -ne $cmd.Outputs){                   
                foreach($key in $cmd.Outputs.GetEnumerator()) {
                    $customOutput =  $cmd.Outputs[$key.Name]
                    if(2 -eq $customOutput.ConversionType){
                        $output += $this.GetOutputTransformationName($customOutput.Name, $customOutput.TargetName)
                    }
                    elseif(99 -eq $customOutput.ConversionType){
                        $output += $this.GetOutputTransformationCustom($customOutput)
                    }
                }
            }
        }
        else {
            foreach($key in $this.GenericOutputTransformations.GetEnumerator()) {
                $customOutput =  $this.GenericOutputTransformations[$key.Name]
                if(2 -eq $customOutput.ConversionType){
                    $output += $this.GetOutputTransformationName($customOutput.Name, $customOutput.TargetName)
                }
                elseif(99 -eq $customOutput.ConversionType){
                    $output += $this.GetOutputTransformationCustom($customOutput)
                }
            }             
        }
               

        if("" -ne $output){
            $transform = @"
    if(`$null -ne `$response){
$($output)
    }
"@
            return $transform
        }
        return ""
    }

    hidden [string] GetOutputTransformationName([string] $OldName, [string] $NewName){
        $outputBlock =@"
        `$response | Add-Member -MemberType AliasProperty -Name $($NewName) -Value $($OldName)

"@
        return $outputBlock
    }

    hidden [string] GetOutputTransformationCustom([DataMap] $Param){
        $outputBlock =@"
        $($Param.SpecialMapping)
        `$response | Add-Member -MemberType ScriptProperty -Name $($Param.TargetName) -Value `$Value

"@
        return $outputBlock
    }

    hidden [hashtable] GetModuleCommands([string[]] $ModuleNames, [string[]] $Prefix, [bool] $IgnoreEmptyNoun = $false){
        
        $names = @()
        foreach ($moduleName in $ModuleNames) {
            $module = Get-Module -Name $moduleName
            $names += $module.ExportedCmdlets.Keys
            $names += $module.ExportedFunctions.Keys
        }
    
        $namesDic = @{}
        foreach ($name in $names) {
            $cmdComponents = $this.GetParsedCmd($name, $Prefix)
            if(!$cmdComponents){
                $this.MissingCommandsToMap += $name
                continue
            }
            if($IgnoreEmptyNoun -and !$cmdComponents.Noun) {
                continue
            }

            $namesDic.Add($name, $cmdComponents)
        }
    
        return $namesDic
    }

    hidden [PSCustomObject] GetParsedCmd([string]$Name, [string[]]$Prefixs){
        foreach ($prefix in $Prefixs) {
            $components = $name -split '-'      
            $verb = $components[0]
            $prefixNoun = $components[1]
            $components = $prefixNoun -split $prefix
            if($components.Length -eq 1)
            {
                continue
            }
            $noun = $prefixNoun.Substring($prefix.Length, $prefixNoun.Length - $prefix.Length)
        
            return [PSCustomObject] @{
                Verb = $verb
                Noun = $noun
                Prefix = $prefix
            }                  
        }
        return $null
    }

    hidden [PSCustomObject] GetNewCmdTranslation($SourceCmdName, $SourceCmdlet, $TargetCmdlets, $NewPrefix){
        $verbsEquivalence = @{
            'Get' = @('Get')
            'New' = @('New','Add')
            'Add' = @('New','Add')
            'Remove' = @('Remove','Delete')
            'Delete' = @('Remove','Delete')
            'Set' = @('Set','Update')
            'Update' = @('Set','Update')
            'Confirm' = @('Confirm')
            'Enable' = @('New')
        }
    
        $targetCmd = $null
        if($this.CmdCustomizations.ContainsKey($SourceCmdName)){
            $targetCmd = $this.CmdCustomizations[$SourceCmdName].TargetName
        }
        else {
            foreach ($prefix in $this.DestinationPrefixs){
                foreach ($verb in $verbsEquivalence[$SourceCmdlet.Verb]){
                    $tmpCmd = "$($verb)-$($prefix)$($SourceCmdlet.Noun)"
                    if($TargetCmdlets.ContainsKey($tmpCmd)){
                        $targetCmd = $tmpCmd;
                        break;
                    }
                }
            }
        }

        if($null -ne $targetCmd){
            if($SourceCmdlet.Prefix.contains('MS')){
                $Prefix = $NewPrefix  + 'MS'
            } else {
                $prefix = $NewPrefix
            }
            $cmd = [PSCustomObject]@{
                Old = '{0}-{1}{2}' -f $SourceCmdlet.Verb, $SourceCmdlet.Prefix, $SourceCmdlet.Noun
                New = $targetCmd
                Generate = '{0}-{1}{2}' -f $SourceCmdlet.Verb, $Prefix, $SourceCmdlet.Noun
                Noun = $SourceCmdlet.Noun
                Verb = $SourceCmdlet.Verb
                Parameters = $null
                DefaultParameterSet = ""
            }
            $cmd.Parameters = $this.GetCmdletParameters($cmd)
            $defaulParam = $this.GetDefaultParameterSet($SourceCmdName)
            $cmd.DefaultParameterSet = "DefaultParameterSetName = '$defaulParam'"
            return $cmd
        }

        return $null
    }

    hidden [string] GetDefaultParameterSet($Cmdlet){
        $sourceCmd = Get-Command -Name $Cmdlet

        return $sourceCmd.DefaultParameterSet
    }

    hidden [hashtable] GetCmdletParameters($Cmdlet){
        $exceptionParameterNames = @("SearchString")
        $Bool2Switch = @("All")
        $SystemDebug = @("Verbose", "Debug")
        $commonParameterNames = @("ErrorAction", "ErrorVariable", "WarningAction", "WarningVariable", "OutBuffer", "PipelineVariable", "OutVariable", "InformationAction", "InformationVariable")
        $sourceCmd = Get-Command -Name $Cmdlet.Old
        $targetCmd = Get-Command -Name $Cmdlet.New

        $paramsList = @{}
        foreach ($paramKey in $sourceCmd.Parameters.Keys) {
            $param = $sourceCmd.Parameters[$paramKey]
            $paramObj = [DataMap]::New($param.Name)
            
            if($this.CmdCustomizations.ContainsKey($Cmdlet.Old)) {
                $custom = $this.CmdCustomizations[$Cmdlet.Old]
                if(($null -ne $custom.Parameters) -and ($custom.Parameters.contains($param.Name))){
                    $paramsList.Add($param.Name, $custom.Parameters[$param.Name])
                    continue
                }
            }
            elseif($this.GenericParametersTransformations.ContainsKey($param.Name)) {
                $genericParam = $this.GenericParametersTransformations[$param.Name]
                if(5 -eq $genericParam.ConversionType){
                    $tempName = "$($Cmdlet.Noun)$($genericParam.TargetName)"
                    if($targetCmd.Parameters.ContainsKey($tempName)){
                        $paramObj.SetTargetName($tempName)
                    }
                    else
                    {
                        foreach ($key in $targetCmd.Parameters.Keys) {
                            if($key.EndsWith($genericParam.TargetName)){
                                $paramObj.SetTargetName($key)
                                break
                            }
                        }
                    }
                    $paramsList.Add($paramObj.Name,$paramObj)                    
                }else{
                    $paramsList.Add($genericParam.Name, $genericParam)
                }   
                continue
            }
            
            if($commonParameterNames.Contains($param.Name)) {
                continue
            }
           
            if($exceptionParameterNames.Contains($param.Name)){
                $paramObj.SetException()
            }
            elseif($Bool2Switch.Contains($param.Name)) {
                $paramObj.SetBool2Switch($param.Name)
            }
            elseif($SystemDebug.Contains($param.Name)) {
                $paramObj.SetSystemSwitch($param.Name)
            }
            else
            {
                if($targetCmd.Parameters.ContainsKey($param.Name)){
                    $paramObj.SetNone()                       
                }
            }
        
            $paramsList.Add($paramObj.Name,$paramObj)
        }
    
        return $paramsList        
    }

    hidden [string] GetFileHeader(){
        return @"
# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

"@
    }
}