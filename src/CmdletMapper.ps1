# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

class CmdletMapper {
    [string] $SourceModuleName = 'AzureAD'
    [string[]] $SourceModulePrefixs = @('AzureADMS','AzureAD')
    [string] $NewPrefix = 'CompatAD'
    [string[]] $DestinationModuleName = @('Microsoft.Graph.Users','Microsoft.Graph.Users.Actions', 'Microsoft.Graph.Users.Functions', 'Microsoft.Graph.Groups', 'Microsoft.Graph.Identity.DirectoryManagement', 'Microsoft.Graph.Identity.Governance', 'Microsoft.Graph.Identity.SignIns','Microsoft.Graph.Applications')
    [string[]] $DestinationPrefixs = @('Mg') 
    [string] $ModuleName = 'Microsoft.Graph.Compatibility.AzureAD'
    [CmdletMap[]] $CommandsToMap = $null
    [CmdletMap[]] $MissingCommandsToMap = $null
    [string] $OutputFolder = './bin'
    [bool] $LogInfomation
    hidden [ModuleMap] $ModuleMap = $null
    hidden [bool] $GenerateCommandsToMapData

    CmdletMapper(){
        $modules = Get-Module
        if(!$modules.Name.Contains($this.SourceModuleName)){
            Import-Module $this.SourceModuleName | Out-Null
        }

        foreach ($moduleName in $this.DestinationModuleName){
            if(!$modules.Name.Contains($moduleName)){
                Import-Module $moduleName | Out-Null
            }
        }
    }

    [ModuleMap] Map(){
        $this.ModuleMap = [ModuleMap]::new($this.ModuleName)
        $originalCmdlets = $this.GetModuleCommands($this.SourceModuleName, $this.SourceModulePrefixs, $true)
        $targetCmdlets = $this.GetModuleCommands($this.DestinationModuleName, $this.DestinationPrefixs, $true)
        $newCmdletData = @()
        $cmdletsToExport = @()
        foreach ($cmdlet in $originalCmdlets.Keys){
            $newCmdlet = $this.GetCmdletNoun($cmdlet, $targetCmdlets)
            if($newCmdlet.Exact){
                foreach ($item in $originalCmdlets[$cmdlet]) {
                    $newFunction = $this.GetCmdNameTranslation($item, $targetCmdlets, $this.NewPrefix)
                    if($newFunction){
                        $newCmdletData += $newFunction
                        $cmdletsToExport += $newFunction.Generate                   
                    }                   
                }
            }
            else{            
                Write-LogFile "----- Noun: '$cmdlet'  Similar nouns found:'$($newCmdlet.SimilarNames.Count)' Nouns: '$($newCmdlet.SimilarNames)'"   
            } 
        }
      
        $this.ModuleMap.CmdletsList = $cmdletsToExport
        $this.ModuleMap.Cmdlets = $this.NewModuleMap($newCmdletData)

        return $this.ModuleMap
    }

    [scriptblock] GetAlisesFunction() {
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

    [scriptblock] GetExportMemeber() {
        $cmdletsToExport = $this.ModuleMap.CmdletsList
        $cmdletsToExport += "Set-CompatADAlias"
        $functionsToExport = @"
Export-ModuleMember -Function @(
    '$($cmdletsToExport -Join "','")'
)
"@
        return [Scriptblock]::Create($functionsToExport)
    }

    hidden [CmdletTranslation[]] NewModuleMap([PSCustomObject[]] $Cmdlets) {
        [CmdletTranslation[]] $translations = @()
        foreach($Cmdlet in $Cmdlets){
            $translations += $this.NewFunctionMap($Cmdlet)
        }
        return $translations
    }

    GenerateModuleFiles() {
        $this.WriteModuleFile()
        $this.WriteModuleManifest()
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

    hidden [CmdletTranslation] NewFunctionMap([PSCustomObject] $Cmdlet){

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
        return [CmdletTranslation]::New($Cmdlet.Generate,$Cmdlet.Old,$codeBlock)
    }

    hidden [string] GetParametersDefinitions([PSCustomObject] $Cmdlet) {
        $params = $(Get-Command -Name $Cmdlet.Old).Parameters
        $paramsList = @()
        foreach ($paramKey in $Cmdlet.Parameters) {
            $param = $params[$paramKey.Old]
            $paramBlock = @"
    [$($param.ParameterType.ToString())] `$$($param.Name)
"@
            $paramsList += $paramBlock
        }

        return $paramsList -Join ",`n"
    }


    hidden [string] GetParametersTransformations([PSCustomObject] $Cmdlet) {
        $paramsList = ""

        foreach ($paramKey in $Cmdlet.Parameters) {        
            if(($null -ne $paramKey.New) -and ($false -eq $paramKey.Exception)){
            $paramBlock = @"
    if(`$PSBoundParameters["$($paramKey.Old)"] -ne `$null)
    {
        `$params["$($paramKey.New)"] =  `$PSBoundParameters["$($paramKey.Old)"]
    }
        
"@                
            $paramsList += $paramBlock
            }
        }
            
        return $paramsList
    }

    
    hidden [string] GetOutputTransformations([PSCustomObject] $Cmdlet) {
        $responseVerbs = @("Get","Add","New")
        $output = ""
    
        if($responseVerbs.Contains($Cmdlet.Verb)) {
        $output += @"
    if((`$response -ne `$null) -and ((`$response.Id -ne `$null) -or (`$response[0].Id -ne `$null))){            
        `$response | Add-Member -MemberType AliasProperty -Name ObjectId -Value Id    
    }
"@
        }
        return $output
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
                Write-LogFile "Error Parsing '$name'"
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

    hidden [PSCustomObject] GetCmdletNoun([PSCustomObject] $Cmdlet, [hashtable]$CmdletList ) {
        $response = [PSCustomObject]@{
            Exact = $false
            Name = ''
            SimilarNames = @()
        }
        if($CmdletList.Contains($Cmdlet)) {
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

    hidden [PSCustomObject] GetCmdNameTranslation($OldCmdlet, $NewCmdlets, $NewPrefix){
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
    
        foreach ($item in $NewCmdlets[$OldCmdlet.Noun]) {
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

        foreach ($item in $NewCmdlets[$OldCmdlet.Noun+'ByRef']) {
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

        Write-LogFile "Non found for Noun:'$($OldCmdlet.Noun)', verb: '$($OldCmdlet.Verb)' and module '$($OldCmdlet.Prefix)'"
        return $null
    }    

    hidden [PSCustomObject[]] GetCmdletParameters($Cmdlet){
        $exceptionParameterNames = @("ObjectId","All","SearchString","Filter")
        $commonParameterNames = @("Verbose", "Debug", "ErrorAction", "ErrorVariable", "WarningAction", "WarningVariable", "OutBuffer", "PipelineVariable", "OutVariable", "InformationAction", "InformationVariable")  
        $params = $(Get-Command -Name $Cmdlet.Old).Parameters
        $newParams = $(Get-Command -Name $Cmdlet.New).Parameters

        $paramsList = @()
        foreach ($paramKey in $params.Keys) {
            $param = $params[$paramKey]
            if($commonParameterNames.Contains($param.Name)) {
                continue
            }

            $paramObj = [PSCustomObject]@{
                Old = $param.Name
                New = $null
                Exception = $false
            }
            if('ObjectId' -eq $param.Name){
                $tempName = "$($Cmdlet.Noun)Id"
                if($newParams.Keys.Contains($tempName)){
                    $paramObj.New = $tempName
                }
                else
                {
                    foreach ($key in $newParams.Keys) {
                        if($key.EndsWith("Id")){
                            $paramObj.New = $key
                            break
                        }
                    }
                }
            }
            elseif('RefObjectId' -eq $param.Name) {
                $paramObj.New = 'DirectoryObjectId'
            }
            else
            {
                if($newParams.Keys.Contains($param.Name)){
                    $paramObj.New = $param.Name
                    if($exceptionParameterNames.Contains($param.Name)){
                        $paramObj.Exception = $true
                    }
                }
            }
        
            $paramsList += $paramObj
        }
    
        return $paramsList        
    }
}

function Write-LogFile {
    param (
        $InputMessage
    )
    Write-Verbose $InputMessage
    $file = Join-Path $PSScriptRoot '../bin/BuildLog.txt'
    $InputMessage | Out-File -FilePath $file -Append    
}

function Write-File{
    param (
        $FileName,
        [string]$Text
    )

    $Text | Out-File -FilePath $FileName -Append    
}

function Write-CmdletsData {
    param (
        $Data,
        $Filename
    )
    $Data | ConvertTo-Json | Out-File -FilePath $Filename
}