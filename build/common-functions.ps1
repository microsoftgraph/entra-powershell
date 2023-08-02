# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

$moduleOutputSubdirectory = 'modules'
$outputPath = 'bin'
$customizationPath = 'customizations'

function Get-ModuleManifestFile {
    Get-Childitem (Get-ModuleBasePath) -filter '*.psd1'
}
function Get-ModuleName {
    Get-Childitem (Get-ModuleBasePath) -filter '*.psd1' | Select-Object -expandproperty basename
}

function Get-ModuleBasePath {
    Join-Path (Split-Path -parent $psscriptroot) $outputPath
}

function Get-ModuleVersion {
    (Get-ModuleManifestFile).FullName | Test-ModuleManifest | Select-Object -ExpandProperty Version
}

function Get-ModuleFiles {
    (Get-ModuleManifestFile).FullName | Test-ModuleManifest | Select-Object -ExpandProperty FileList
}


function Get-PSGalleryRepoName {
    'PSGallery'
}

function Get-LocalPSRepoName {
    '__LocalGallery__'
}

function Get-SourceRootDirectory {
    (Get-Item (Split-Path -parent $psscriptroot)).fullname
}

function Get-OutputDirectory {
    Join-Path (Get-SourceRootDirectory) $outputPath
}

function Get-DevRepoDirectory {
    Join-Path (Get-SourceRootDirectory) '.psrepo'
}

function Remove-BuildDirectories {

    $binPath = Get-OutputDirectory
    if ( Test-Path $binPath ) {
        $binPath | Remove-Item -r -force 
    }

    $devRepoLocation = Get-DevRepoDirectory
    if (Test-Path $devRepoLocation) {
        $devRepoLocation | Remove-Item -r -force
    }
}

function Register-LocalGallery($Path) {
    $repoPath = Get-DevRepoDirectory
    if($Path){
        $repoPath = $Path
    }    
    if(!(Test-Path $repoPath)) {
        New-Item -Path $repoPath -ItemType Directory  | out-null
    }

    Register-PSRepository -Name (Get-LocalPSRepoName) -SourceLocation ($repoPath) -ScriptSourceLocation ($repoPath) -InstallationPolicy Trusted | out-null
}

function Unregister-LocalGallery {    
    Unregister-PSRepository (Get-LocalPSRepoName) | out-null
}

function Update-ModuleVersion {
    [cmdletbinding()]
    param(
        [switch] $Minor,
        [switch] $Mayor,
        [switch] $Build
    )

    $version = Get-ModuleVersion
    $v = @{        
        Major = $version.Major
        Minor = $version.Minor
        Build = $version.Build            
    }
 
    if($Build.IsPresent)
    {
        $v.Build++
    }

    if($Minor.IsPresent)
    {
        $v.Minor++
    }

    if($Mayor.IsPresent)
    {
        $v.Major++
    }

    $ver = $v.Major, $v.Minor, $v.Build -Join "."
    Update-ModuleManifest -Path $(Get-ModuleManifestFile).FullName -ModuleVersion $ver
}

function Create-ModuleFolder {
    [cmdletbinding()]
    param(
        [string]$OutputDirectory = $null,
        [switch]$NoClean
    )

    if( !$OutputDirectory ) {
        $OutputDirectory = Join-Path $(Split-Path -parent $psscriptroot) $outputPath        
    }

    $modulesDirectory = Join-Path $OutputDirectory $moduleOutputSubdirectory

    if ( (test-path $modulesDirectory) -and ! $noclean.ispresent ) {
        Remove-Item -r -force $modulesDirectory | Out-Null
    }

    $thisModuleDirectory = Join-Path $modulesDirectory $(Get-ModuleName)
    $targetDirectory = Join-Path $thisModuleDirectory $(Get-ModuleVersion).tostring()


    New-Item -Path $targetDirectory -ItemType Directory | Out-Null

    $ignorableSegmentCount = ($(Get-ModuleBasePath).replace("`\", '/') -split '/').count
    $sourceFileList = @()
    $destinationFileList = @()
    Get-ModuleFiles | ForEach-Object {
        $normalizedFile = $_.replace("`\", '/')
        $segments = $normalizedFile -split '/'
        $relativeSegments = @()
        $ignorableSegmentCount..($segments.length - 1) | ForEach-Object {
            $relativeSegments += $segments[$_]
        }

        $relativePath = $relativeSegments -join '/'

        $sourceFileList += Join-Path $(Get-ModuleBasePath) $relativePath
        $destinationFileList += Join-Path $targetDirectory $relativePath
    }

    0..($sourceFileList.length - 1) | ForEach-Object {
         $parent = split-path -parent $destinationFileList[ $_ ]
         if ( ! (test-path $parent) ) {
            New-Item -Path $parent -ItemType Directory | out-null
         }

         $destinationName = split-path -leaf $destinationFileList[ $_ ]
         $syntaxOnlySourceName = split-path -leaf $sourceFileList[ $_ ]
         $sourceActualName = (get-childitem (split-path -parent $sourceFileList[ $_ ]) -filter $syntaxOnlySourceName).name

         if ( $destinationName -cne $sourceActualName ) {
             throw "The case-sensitive name of the file at source path '$($sourceFileList[$_])' is actually '$sourceActualName' and it does not match the case of the last element of destination path '$($destinationFileList[$_])' -- the case of the file names must match exactly in order to support environments with case-sensitive file systems. This can be corrected in the module manifest by specifying the case of the file exactly as it exists in the module source code directory"
         }

         copy-item $sourceFileList[ $_ ] $destinationFileList[ $_ ]
     }
}

function Get-CustomizationFiles {
    [cmdletbinding()]
    param(
        $Module = "AzureAD",
        [string]$Directory = $null
    )

    $Path = $(Split-Path -parent $psscriptroot)

    if( !$Directory ) {
        $Path = Join-Path $Path 'module'
        $Path = Join-Path $Path $Module
        $Path = Join-Path $Path $customizationPath
    }
    else {
        $Path = Join-Path $Path 'module'      
        $Path = Join-Path $Path $Module
        $Path = Join-Path $Path $Directory
    }
    $customizationFileList = @()
    $files = Get-ChildItem -Path $Path -Filter '*.ps1'
    foreach($file in $files){
        $customizationFileList += $file.FullName        
    }
    
    $customizationFileList
}