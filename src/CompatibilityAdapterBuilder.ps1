# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

class CompatibilityAdapterBuilder {
    [string] $SourceModuleName = 'AzureAD'
    [string[]] $SourceModulePrefixs = @('AzureADMS','AzureAD')
    [string] $NewPrefix = 'CompatAD'
    [string[]] $DestinationModuleName = @('Microsoft.Graph.Users','Microsoft.Graph.Users.Actions', 'Microsoft.Graph.Users.Functions', 'Microsoft.Graph.Groups', 'Microsoft.Graph.Identity.DirectoryManagement', 'Microsoft.Graph.Identity.Governance', 'Microsoft.Graph.Identity.SignIns','Microsoft.Graph.Applications')
    [string[]] $DestinationPrefixs = @('Mg') 
    [string] $ModuleName = 'Microsoft.Graph.Compatibility.AzureAD'
    hidden [CommandMap[]] $CommandsToMap = $null
    hidden [CommandMap[]] $MissingCommandsToMap = @()
    hidden [hashtable] $CmdletCustomizations = @{}
    hidden [string] $OutputFolder = (join-path $PSScriptRoot '../bin')
    hidden [MappedCmdCollection] $ModuleMap = $null
    hidden [bool] $GenerateCommandsToMapData

    # Constructor that changes the output folder, load all the Required Modules and creates the output folder.
    CompatibilityAdapterBuilder([string] $OutputFolder = $null){
        if($OutputFolder) {
            $this.OutputFolder = $OutputFolder
        }

        Import-Module $this.SourceModuleName | Out-Null
        foreach ($moduleName in $this.DestinationModuleName){
            Import-Module $moduleName | Out-Null
        }

        if(!(Test-Path $this.OutputFolder)){
            New-Item -ItemType Directory -Path $this.OutputFolder | Out-Null
        }
    }

        # Generates the module then generates all the files required to create the module.
    BuildModule() {
        $this.WriteModuleFile()
        $this.WriteModuleManifest()
    }
    
        # Add customization based on the the CommandMap object.
    AddCustomization([hashtable[]] $Cmdlets) {
        foreach($cmd in $Cmdlets) {
            $parameters = $null
            $outputs = $null
            if($cmd.Parameters){
                $parameters = @{}
                foreach($param in $cmd.Parameters){
                    $parameters.Add($param.SourceName, [DataMap]::New($param.SourceName, $param.TargetName, $param.ConversionType, [Scriptblock]::Create($param.SpecialMapping)))
                }
            }
            
            if($cmd.Outputs){
                $outputs = @{}
                foreach($param in $cmd.Parameters){
                    $outputs.Add($param.SourceName, [DataMap]::New($param.SourceName, $param.TargetName, $param.ConversionType, [Scriptblock]::Create($param.SpecialMapping)))
                }
            }

            $customCommand = [CommandMap]::New("New-AzureADUser","New-MgUser", $parameters, $outputs)
            $this.CmdletCustomizations.Add($cmd.SourceName, $customCommand)
        }
    }

    # Creates the ModuleMap object, this is mainly used by other methods but can be called when debugging or finding missing cmdlets
    hidden [MappedCmdCollection] Map(){
        $this.ModuleMap = [MappedCmdCollection]::new($this.ModuleName)
        $originalCmdlets = $this.GetModuleCommands($this.SourceModuleName, $this.SourceModulePrefixs, $true)
        $targetCmdlets = $this.GetTargetModuleCommands($this.DestinationModuleName, $this.DestinationPrefixs, $true)
        $newCmdletData = @()
        $cmdletsToExport = @()
        $missingCmdletsToExport = @()
        foreach ($cmdlet in $originalCmdlets.Keys){
            $originalCmdlet = $originalCmdlets[$cmdlet]
            $newCmdlet = $this.FindCmdletNoun($cmdlet,$originalCmdlet.Noun, $targetCmdlets)
            if($newCmdlet.Exact){
                $newFunction = $this.GetCmdNameTranslation($originalCmdlet, $targetCmdlets, $this.NewPrefix, $newCmdlet)
                if($newFunction){
                    $newCmdletData += $newFunction
                    $cmdletsToExport += $newFunction.Generate
                    $this.CommandsToMap += [CommandMap]::New($newFunction.Old, $newFunction.New, $newFunction.Parameters)
                }
                else {
                    $missingCmdletsToExport += $cmdlet
                    $this.MissingCommandsToMap += [CommandMap]::New($cmdlet, $newCmdlet)
                }                 
            }
            else{  
                $missingCmdletsToExport += $cmdlet                          
                $this.MissingCommandsToMap += [CommandMap]::New($cmdlet,$newCmdlet.SimilarNames -Join ",")
            } 
        }
      
        $this.ModuleMap.CmdletsList = $cmdletsToExport
        $this.ModuleMap.MissingCmdletsList = $missingCmdletsToExport
        $this.ModuleMap.Cmdlets = $this.NewModuleMap($newCmdletData)

        return $this.ModuleMap
    }    

    hidden [scriptblock] GetAlisesFunction() {
        if($this.ModuleMap){
            $aliases = ''
            foreach ($func in $this.ModuleMap.Cmdlets) {       
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
        $cmdletsToExport = $this.ModuleMap.CmdletsList
        $cmdletsToExport += "Set-CompatADAlias"
        $functionsToExport = @"
Export-ModuleMember -Function @(
    '$($cmdletsToExport -Join "','")'
)

"@
        return [Scriptblock]::Create($functionsToExport)
    }

    hidden [scriptblock] SetMissingCmdlets() {
        $missingCmdlets = @"
Set-Variable -name MISSING_CMDLETS -value @('$($this.ModuleMap.MissingCmdletsList -Join "','")') -Scope Global -Option ReadOnly -Force

"@
        return [Scriptblock]::Create($missingCmdlets)
    }

    hidden [CommandTranslation[]] NewModuleMap([PSCustomObject[]] $Cmdlets) {
        [CommandTranslation[]] $translations = @()
        foreach($Cmdlet in $Cmdlets){
            $translations += $this.NewFunctionMap($Cmdlet)
        }
        return $translations
    }

    hidden WriteModuleFile() {
        $headerCode = @"
# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

"@
        $filePath = Join-Path $this.OutputFolder "$($this.ModuleName).psm1"
        $data = $this.Map()
        Write-File -FileName $filePath -Text $headerCode
        foreach($cmd in $data.Cmdlets) {
            Write-File -FileName $filePath -Text $cmd.CommandBlock
        }

        Write-File -FileName $filePath -Text $this.GetAlisesFunction()
        Write-File -FileName $filePath -Text $this.GetExportMemeber()
        Write-File -FileName $filePath -Text $this.SetMissingCmdlets()
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
        }
        $manisfestPath = Join-Path $this.OutputFolder "$($this.ModuleName).psd1"
        $functions = $this.ModuleMap.CmdletsList + "Set-CompatADAlias"
        $moduleSettings = @{
            Path = $manisfestPath
            ModuleVersion = "$($content.version)"
            FunctionsToExport = $functions
            Author =  $($content.authors)
            CompanyName = $($content.owners)
            FileList = $files
            RootModule = "$($this.ModuleName).psm1" 
            Description = 'Microsoft Graph PowerShell AzureAD Compatibility Module.'    
            DotNetFrameworkVersion = $([System.Version]::Parse('4.7.2')) 
            PowerShellVersion = $([System.Version]::Parse('5.1'))
            CompatiblePSEditions = @('Desktop','Core')
        }
        
        New-ModuleManifest @moduleSettings
        Update-ModuleManifest -Path $manisfestPath -PrivateData $PSData
    }

    hidden [CommandTranslation] NewFunctionMap([PSCustomObject] $Cmdlet){

        $parameterDefinitions = $this.GetParametersDefinitions($Cmdlet)
        $ParamterTransformations = $this.GetParametersTransformations($Cmdlet)
        $OutputTransformations = $this.GetOutputTransformations($Cmdlet)
        $function = @"
function $($Cmdlet.Generate) {
    [CmdletBinding()]
    param (
$parameterDefinitions
    )
        
    `$params = @{}   
$ParamterTransformations
    `$response = $($Cmdlet.New) @params
$OutputTransformations
    `$response
}
        
"@
        $codeBlock = [Scriptblock]::Create($function)
        return [CommandTranslation]::New($Cmdlet.Generate,$Cmdlet.Old,$codeBlock)
    }

    hidden [string] GetParametersDefinitions([PSCustomObject] $Cmdlet) {
        $params = $(Get-Command -Name $Cmdlet.Old).Parameters
        $paramsList = @()
        foreach ($paramKey in $Cmdlet.Parameters.Keys) {
            $param = $params[$paramKey]
            $paramBlock = @"
    [$($param.ParameterType.ToString())] `$$($param.Name)
"@
            $paramsList += $paramBlock
        }

        return $paramsList -Join ",`n"
    }


    hidden [string] GetParametersTransformations([PSCustomObject] $Cmdlet) {
        $paramsList = ""

        foreach ($paramKey in $Cmdlet.Parameters.Keys) {        
            $param = $Cmdlet.Parameters[$paramKey]
            $paramBlock = ""
            
            if(1 -eq $param.ConversionType){
                $paramBlock = $this.GetParameterTransformationName($param.Name, $param.Name)
            }
            elseif(2 -eq $param.ConversionType){
                $paramBlock = $this.GetParameterTransformationName($param.Name, $param.TargetName)
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

    hidden [string] GetParameterTransformationName([string] $OldName, [string] $NewName){
        $paramBlock = @"
    if(`$PSBoundParameters["$($OldName)"] -ne `$null)
    {
        `$params["$($NewName)"] =  `$PSBoundParameters["$($OldName)"]
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
    if(`$PSBoundParameters["$($Param.Name)"] -ne `$null)
    {
        `$TmpValue =  `$PSBoundParameters["$($Param.Name)"]
        $($Param.SpecialMapping)
        `$params["$($Param.TargetName)"] = `$Value
    }

"@
        return $paramBlock
    }
    
    hidden [string] GetOutputTransformations([PSCustomObject] $Cmdlet) {
        $responseVerbs = @("Get","Add","New")
        $output = ""
    
        if($this.CmdletCustomizations.Contains($Cmdlet.Old)) { 
            $cmd = $this.CmdletCustomizations[$Cmdlet.Old] 
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
        
        if($responseVerbs.Contains($Cmdlet.Verb)) {
        $output += @"
        `$response | Add-Member -MemberType AliasProperty -Name ObjectId -Value Id
"@
        }

        if("" -ne $output){
            $transform = @"
    if(`$response -ne `$null){
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
            $cmdComponents = $this.GetParsedCmdlet($name, $Prefix)
            if(!$cmdComponents){
                $this.MissingCommandsToMap += [CommandMap]::New($name, $name)
                continue
            }
            if($IgnoreEmptyNoun -and !$cmdComponents.Noun) {
                continue
            }

            $namesDic.Add($name, $cmdComponents)
        }
    
        return $namesDic
    }
    
    hidden [hashtable] GetTargetModuleCommands([string[]] $ModuleNames, [string[]] $Prefix, [bool] $IgnoreEmptyNoun = $false){
        
        $names = @()
        foreach ($moduleName in $ModuleNames) {
            $module = Get-Module -Name $moduleName
            $names += $module.ExportedCmdlets.Keys
            $names += $module.ExportedFunctions.Keys
        }
    
        $namesDic = @{}
        foreach ($name in $names) {
            $cmdComponents = $this.GetParsedCmdlet($name, $Prefix)
            if(!$cmdComponents){
                continue
            }
            if($IgnoreEmptyNoun -and !$cmdComponents.Noun) {
                continue
            }
            if($namesDic.ContainsKey($cmdComponents.Noun)) {
                $namesDic[$cmdComponents.Noun] += $cmdComponents
            } 
            else {
                $namesDic.Add($cmdComponents.Noun, @($cmdComponents))
            }
        }
    
        return $namesDic
    }

    hidden [PSCustomObject] GetParsedCmdlet([string]$Name, [string[]]$Prefixs){
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

    hidden [PSCustomObject] FindCmdletNoun([string] $CmdletName, [string] $Cmdlet, [hashtable]$CmdletList ) {
        $response = [PSCustomObject]@{
            Exact = $false
            Name = ''
            SimilarNames = @()
        }        
        if($this.CmdletCustomizations.Contains($CmdletName)){
            $response.Exact = $true
            $tmpName = $this.GetParsedCmdlet($this.CmdletCustomizations[$CmdletName].TargetName, $this.DestinationPrefixs)
            $response.Name = $tmpName.Noun
        }
        elseif($CmdletList.Contains($Cmdlet)) {
            $response.Exact = $true
            $response.Name = $Cmdlet
        }
        elseif($CmdletList.Contains($Cmdlet+'ByRef')) {
            $response.Exact = $true
            $response.Name = $Cmdlet+'ByRef'
        }
        else {
            $wild1 = "*$Cmdlet*"    
            foreach ($name in $CmdletList.Keys) {
                $wild2 = "*$name*"
                if($name -like $wild1){
                    $response.SimilarNames += $name             
                }
                if($Cmdlet -like $wild2){
                    $response.SimilarNames += $name             
                }
            }
            $response.Name = $response.SimilarNames -join ","
        }
    
        return $response
    }

    hidden [PSCustomObject] GetCmdNameTranslation($OldCmdlet, $NewCmdlets, $NewPrefix, $foundCmdlet){
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
    
        foreach ($item in $NewCmdlets[$foundCmdlet.Name]) {
            if($verbsEquivalence[$OldCmdlet.Verb].Contains($item.Verb)){
                if($OldCmdlet.Prefix.contains('MS')){
                    $Prefix = $NewPrefix  + 'MS'
                } else {
                    $prefix = $NewPrefix
                }
                $cmds = [PSCustomObject]@{
                    Old = '{0}-{1}{2}' -f $OldCmdlet.Verb, $OldCmdlet.Prefix, $OldCmdlet.Noun
                    New = '{0}-{1}{2}' -f $item.Verb, $item.Prefix, $item.Noun
                    Generate = '{0}-{1}{2}' -f $OldCmdlet.Verb, $Prefix, $OldCmdlet.Noun
                    Noun = $OldCmdlet.Noun
                    Verb = $OldCmdlet.Verb
                    Parameters = $null
                }
                $cmds.Parameters = $this.GetCmdletParameters($cmds)
                return $cmds
            }            
        }

        foreach ($item in $NewCmdlets[$foundCmdlet.Name + 'ByRef']) {
            if($verbsEquivalence[$OldCmdlet.Verb].Contains($item.Verb)){
                if($OldCmdlet.Prefix.contains('MS')){
                    $Prefix = $NewPrefix  + 'MS'
                } else {
                    $prefix = $NewPrefix
                }
                $cmds = [PSCustomObject]@{
                    Old = '{0}-{1}{2}' -f $OldCmdlet.Verb, $OldCmdlet.Prefix, $OldCmdlet.Noun
                    New = '{0}-{1}{2}' -f $item.Verb, $item.Prefix, $item.Noun
                    Generate = '{0}-{1}{2}' -f $OldCmdlet.Verb, $Prefix, $OldCmdlet.Noun
                    Noun = $OldCmdlet.Noun
                    Verb = $OldCmdlet.Verb
                    Parameters = $null
                }
                $cmds.Parameters = $this.GetCmdletParameters($cmds)
                return $cmds
            }
        }
        return $null
    }

    hidden [hashtable] GetCmdletParameters($Cmdlet){
        $exceptionParameterNames = @("All","SearchString")
        $commonParameterNames = @("Verbose", "Debug", "ErrorAction", "ErrorVariable", "WarningAction", "WarningVariable", "OutBuffer", "PipelineVariable", "OutVariable", "InformationAction", "InformationVariable")  
        $params = $(Get-Command -Name $Cmdlet.Old).Parameters
        $newParams = $(Get-Command -Name $Cmdlet.New).Parameters

        $paramsList = @{}
        foreach ($paramKey in $params.Keys) {
            $param = $params[$paramKey]

            if($commonParameterNames.Contains($param.Name)) {
                continue
            }

            if($this.CmdletCustomizations.Contains($Cmdlet.Old)) {
                $custom = $this.CmdletCustomizations[$Cmdlet.Old]
                if(($null -ne $custom.Parameters) -and ($custom.Parameters.contains($param.Name))){
                    $paramsList.Add($param.Name, $custom.Parameters[$param.Name])
                    continue
                }
            }

            $paramObj = [DataMap]::New($param.Name)
            if($exceptionParameterNames.Contains($param.Name)){
                $paramObj.SetException()
            }
            elseif(('ObjectId' -eq $param.Name) -or ('Id' -eq $param.Name)){
                $tempName = "$($Cmdlet.Noun)Id"
                if($newParams.Keys.Contains($tempName)){
                    $paramObj.SetTargetName($tempName)
                }
                else
                {
                    foreach ($key in $newParams.Keys) {
                        if($key.EndsWith("Id")){
                            $paramObj.SetTargetName($key)
                            break
                        }
                    }
                }
            }
            elseif('RefObjectId' -eq $param.Name) {
                $paramObj.SetTargetName('DirectoryObjectId')
            }
            else
            {
                if($newParams.Keys.Contains($param.Name)){
                    $paramObj.SetNone()                       
                }
            }
        
            $paramsList.Add($paramObj.Name,$paramObj)
        }
    
        return $paramsList        
    }
}

function Write-File{
    param (
        $FileName,
        [string]$Text
    )

    $Text | Out-File -FilePath $FileName -Append    
}