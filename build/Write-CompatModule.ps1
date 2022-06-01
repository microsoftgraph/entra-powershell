# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.
#  All Rights Reserved.
#  Licensed under the MIT License.
#  See License in the project root for license information.
# ------------------------------------------------------------------------------

Set-StrictMode -Version 5.0

$_logFileName = Join-Path $PSScriptRoot '../bin/BuildLog.txt' 
$_cmdletDataFileName = Join-Path $PSScriptRoot '../bin/CmdletData.json' 
$_headerCode = @"
# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

"@

function Write-CompatModule{
[cmdletbinding(positionalbinding=$false)]
    param(
        [string] $SourceModuleName = 'AzureAD',
        [string[]] $SourceModulePrefixs = @('AzureADMS','AzureAD'),
        [string] $NewPrefix = 'CompatAD',
        [string[]] $DestinationModuleName = @('Microsoft.Graph.Users','Microsoft.Graph.Users.Actions', 'Microsoft.Graph.Users.Functions', 'Microsoft.Graph.Groups', 'Microsoft.Graph.Identity.DirectoryManagement', 'Microsoft.Graph.Identity.Governance', 'Microsoft.Graph.Identity.SignIns','Microsoft.Graph.Applications'),
        [string[]] $DestinationPrefixs = @('Mg'),   
        [string] $OutputFolder = '../bin',   
        [string] $ModuleName = 'Microsoft.Graph.Compatibility.AzureAD',
        [switch] $ForceModuleUpdate,
        [switch] $ContinueOnError,
        [switch] $ImportModules,
        [switch] $GenerateCmdletFiles
    )

    $OutputFolder = Join-Path $PSScriptRoot $OutputFolder
    Remove-Folder -Folder $OutputFolder
    $modulesToLoad = $DestinationModuleName + $SourceModuleName     
    if($ForceModuleUpdate.IsPresent){
        Import-RequiredModules -DestinationModuleName $modulesToLoad -ForceUpdate    
    }
    elseif($ImportModules.IsPresent){
        Import-RequiredModules -DestinationModuleName $modulesToLoad 
    }

    $originalCmdlets = Get-ModuleCommands -ModuleNames $SourceModuleName -Prefix $SourceModulePrefixs -IgnoreEmptyNoun
    $targetCmdlets = Get-ModuleCommands -ModuleNames $DestinationModuleName -Prefix $DestinationPrefixs
    $newCmdletData = @()
    $cmdletsToExport = @()
    foreach ($cmdlet in $originalCmdlets.Keys) {
        $newCmdlet = Get-CmdletNoun -Cmdlet $cmdlet -CmdletList $targetCmdlets
        if($newCmdlet.Exact){
            foreach ($item in $originalCmdlets[$cmdlet]) {
                $newFunction = Get-CmdNameTranslation -OldCmdlet $item -NewCmdlets $targetCmdlets -NewPrefix $NewPrefix
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
    Write-LogFile "------------------------------------------"
    Write-LogFile "Relations found: '$($newCmdletData.Count)'"
    $total = Get-ModuleCmdletCount -ModuleNames $SourceModuleName
    $missing = $total - $newCmdletData.Count
    Write-LogFile "Relations not found: '$missing'"
    Write-CmdletsData $newCmdletData
    
    if($GenerateCmdletFiles.IsPresent) {
        #Generate one file per new command
        $cmdletOutputFolder = Join-Path  $OutputFolder 'cmdlets'       
        New-Item -Path $cmdletOutputFolder -ItemType Directory | Out-Null
        foreach ($cmdlet in $newCmdletData) {       
            $filename = Join-Path $cmdletOutputFolder "$($Cmdlet.Generate).ps1"
            New-FunctionCode -Cmdlet $cmdlet -FileName $filename
        }
    }
    
    #Generate Final PSM1 File'            
    $moduleFileName = Join-Path $OutputFolder "$($ModuleName).psm1"
    Write-File -FileName $moduleFileName -Text $_headerCode
    foreach ($cmdlet in $newCmdletData) {       
        New-FunctionCode -Cmdlet $cmdlet -FileName $moduleFileName
    }

    $aliasFunction = Get-AlisesFunction -Functions $newCmdletData
    Write-File -FileName $moduleFileName -Text $aliasFunction
    $cmdletsToExport += "Set-CompatADAlias"
    $functionsToExport = @"
Export-ModuleMember -Function @(
    '$($cmdletsToExport -Join "','")'
)
"@

    Write-File -FileName $moduleFileName -Text $functionsToExport    
    New-CompatModuleManifest -ModuleName $ModuleName -Functions $cmdletsToExport -DefaultPrefix $NewPrefix
}

function Get-AlisesFunction {
    param (
        $Functions
    )

    $aliases = ''
    foreach ($func in $Functions) {       
        $aliases += "   Set-Alias -Name $($func.Old) -Value $($func.Generate) -Scope Global -Force`n"
    }
    $aliasFunction = @"
function Set-CompatADAlias {
$($aliases)}

"@

    $aliasFunction
}

function New-CompatModuleManifest {
    param (
        $ModuleName,
        $Functions,
        $DefaultPrefix
    )

    $company = 'Microsoft'
    $manisfestPath = Join-Path $OutputFolder "$ModuleName.psd1"
    $files = @("$ModuleName.psd1", "$ModuleName.psm1")
    $PSData = @{
        Tags = 'Microsoft','Graph','PowerShell','AzureAD','GraphAPI','SDK'
        LicenseUri = 'https://aka.ms/devservicesagreement'
        ProjectUri = 'https://github.com/microsoftgraph/msgraph-sdk-powershell'
        IconUri = 'https://raw.githubusercontent.com/microsoftgraph/msgraph-sdk-powershell/master/documentation/images/graph_color256.png'
        ReleaseNotes = 'See https://aka.ms/GraphPowerShell-Release.'
    }

    $moduleSettings = @{
        Path = $manisfestPath
        ModuleVersion = "$(Get-ModuleVersion)"
        FunctionsToExport = $Functions
        Author =  $company
        CompanyName = $company
        FileList = $files
        RootModule = "$ModuleName.psm1" 
        Description = 'Microsoft Graph PowerShell AzureAD Compatibility Module.'    
        DotNetFrameworkVersion = $([System.Version]::Parse('4.7.2')) 
        PowerShellVersion = $([System.Version]::Parse('5.1'))
        CompatiblePSEditions = @('Desktop','Core')
    }

    New-ModuleManifest @moduleSettings
    Update-ModuleManifest -Path $manisfestPath -PrivateData $PSData
}

function New-FunctionCode {
    param (
        $Cmdlet,
        $FileName      
    )

    $params = ''
    $ParamterTransformations = ''
    $OutputTransformations = ''
    $function = @"
function $($Cmdlet.Generate) {
    [CmdletBinding()]
    param (
        $Params
    )
    $ParamterTransformations
    $($Cmdlet.New) @PSBoundParameters
    $OutputTransformations
}

"@

    Write-File -FileName $Filename -Text $function    
}

function Get-CmdNameTranslation {
    param (
        $OldCmdlet,
        $NewCmdlets,
        $NewPrefix
    )

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
            [PSCustomObject]@{
                Old = '{0}-{1}{2}' -f $OldCmdlet.Verb, $OldCmdlet.Prefix, $OldCmdlet.Noun
                New = '{0}-{1}{2}' -f $item.Verb, $item.Prefix, $item.Noun
                Generate = '{0}-{1}{2}' -f $OldCmdlet.Verb, $Prefix, $OldCmdlet.Noun
            }
            return
        }        
    }

    foreach ($item in $NewCmdlets[$OldCmdlet.Noun+'ByRef']) {
        if($verbsEquivalence[$OldCmdlet.Verb].Contains($item.Verb)){
            if($OldCmdlet.Prefix.contains('MS')){
                $Prefix = $NewPrefix + 'MS'
            } else {
                $prefix = $NewPrefix
            }
            [PSCustomObject]@{
                Old = '{0}-{1}{2}' -f $OldCmdlet.Verb, $OldCmdlet.Prefix, $OldCmdlet.Noun
                New = '{0}-{1}{2}' -f $item.Verb, $item.Prefix, $item.Noun
                Generate = '{0}-{1}{2}' -f $OldCmdlet.Verb, $Prefix, $OldCmdlet.Noun
            }
            return
        }        
    }
    Write-LogFile "Error for Noun:'$($OldCmdlet.Noun)' and '$($OldCmdlet.Verb)' and '$($OldCmdlet.Prefix)'" -ForegroundColor RED
}

function Get-CmdletNoun {
    param (
        $Cmdlet,
        $CmdletList
    )
    
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

    $response
}

function Get-ModuleCmdletCount {
    [cmdletbinding(positionalbinding=$false)]
    param (
        [string[]] $ModuleNames = $null
    )

    $count = 0
    foreach ($modeleName in $ModuleNames) {
        $module = Get-Module -Name $modeleName
        $count += $module.ExportedCmdlets.Keys.Count
        $count += $module.ExportedFunctions.Keys.Count
    }

    $count
}

function Get-ModuleCommands {
    [cmdletbinding(positionalbinding=$false)]
    param (
        [string[]] $ModuleNames = $null,
        [string[]] $Prefix = $null,
        [switch] $IgnoreEmptyNoun
    )
    
    $names = @()
    foreach ($modeleName in $ModuleNames) {
        Write-Verbose "Getting cmdlets and functions for '$modeleName'"
        $module = Get-Module -Name $modeleName
        $names += $module.ExportedCmdlets.Keys
        $names += $module.ExportedFunctions.Keys
    }

    $namesDic = @{}
    foreach ($name in $names) {
        $cmdComponents = Get-ParsedCmdlet -Name $name -Prefix $Prefix
        if(!$cmdComponents){
            Write-LogFile "Error Parsing '$name'"
            continue
        }
        if($IgnoreEmptyNoun.IsPresent -and !$cmdComponents.Noun) {
            continue
        }
        if($namesDic.ContainsKey($cmdComponents.Noun)) {
            $namesDic[$cmdComponents.Noun] += $cmdComponents
        } 
        else {
            $namesDic.Add($cmdComponents.Noun, @($cmdComponents))
        }
    }

    $namesDic
}

function Get-ParsedCmdlet {
    param (
        [string]$Name,
        [string[]]$Prefixs       
    )    
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
    
        [PSCustomObject] @{
            Verb = $verb
            Noun = $noun
            Prefix = $prefix
        }  
        break      
    }
}

function Import-RequiredModules{
[cmdletbinding(positionalbinding=$false)]
    param(
        [string[]] $DestinationModuleNames = @('AzureAD','Microsoft.Graph.Users','Microsoft.Graph.Users.Actions', 'Microsoft.Graph.Users.Functions', 'Microsoft.Graph.Groups', 'Microsoft.Graph.Identity.DirectoryManagement', 'Microsoft.Graph.Identity.Governance', 'Microsoft.Graph.Identity.SignIns'),
        [switch] $ForceUpdate
    )

    foreach ( $moduleName in $DestinationModuleNames ) {
        $existingModule = Get-Module -listavailable $moduleName | Sort-Object Version |Select-Object -last 1
        if ( $existingModule ) {
            if($ForceUpdate.IsPresent)
            {
                Write-Verbose "Installing Module '$moduleName'"
                Install-Module $moduleName -AllowClobber
            }
            Write-Verbose "Importing Module '$moduleName'"
            Import-Module $moduleName -Force          
        }
        else {
            Write-Verbose "Installing Module '$moduleName'"
            Install-Module $moduleName
            Write-Verbose "Importing Module '$moduleName'"
            Import-Module $moduleName -Force        
        }   
    }
}

function Write-CmdletsData {
    param (
        $Data
    )
    $Data | ConvertTo-Json | Out-File -FilePath $global:_cmdletDataFileName
}

function Write-LogFile {
    param (
        $InputMessage
    )
    Write-Verbose $InputMessage
    $InputMessage | Out-File -FilePath $global:_logFileName -Append    
}

function Write-File{
    param (
        $FileName,
        [string]$Text
    )

    $Text | Out-File -FilePath $FileName -Append    
}

function Remove-Folder {
    param(
        $Folder    
    )

    if(Test-Path $Folder) {
        Remove-Item -Recurse -Force $Folder   
    }
    New-Item -ItemType Directory -Path $Folder | Out-Null
}

function Get-ModuleVersion {
    param (        
    )
    
    '0.1.0'
}