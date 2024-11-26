# ------------------------------------------------------------------------------
#  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
Set-StrictMode -Version 5

$script:_config = Import-PowerShellDataFile -Path (Join-Path -Path $PSScriptRoot -ChildPath "build.config.psd1")

function Get-ConfigValue {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[ArgumentCompleter({ (Import-PowerShellDataFile -Path (Join-Path -Path $PSScriptRoot -ChildPath "build.config.psd1")).Keys })]
		[string]
		$Name
	)

	$script:_config[$Name]
}

function Get-ModuleManifestFile {
	Get-ChildItem (Get-ModuleBasePath) -Filter '*.psd1'
}

function Get-ModuleName {
	Get-ChildItem (Get-ModuleBasePath) -Filter '*.psd1' | Select-Object -ExpandProperty basename
}

function Get-ModuleBasePath {
	Join-Path (Split-Path -Parent $PSScriptRoot) (Get-ConfigValue -Name OutputPath)
}

function Get-ModuleVersion {
    (Get-ModuleManifestFile).FullName | Test-ModuleManifest | Select-Object -ExpandProperty Version
}

function Get-ModuleFiles {
    (Get-ModuleManifestFile).FullName | Test-ModuleManifest | Select-Object -ExpandProperty FileList
}

function Get-PSGalleryRepoName {
	Get-ConfigValue -Name PSGalleryRepoName
}

function Get-LocalPSRepoName {
	Get-ConfigValue -Name LocalGalleryRepoName
}

function Get-SourceRootDirectory {
    (Get-Item (Split-Path -Parent $PSScriptRoot)).FullName
}

function Get-OutputDirectory {
	Join-Path (Get-SourceRootDirectory) (Get-ConfigValue -Name OutputPath)
}

function Get-DevRepoDirectory {
	Join-Path (Get-SourceRootDirectory) '.psrepo'
}

function Remove-BuildDirectories {
	$binPath = Get-OutputDirectory
	if (Test-Path $binPath) {
		Remove-Item -Recurse -Force -Path $binPath
	}

	$devRepoLocation = Get-DevRepoDirectory
	if (Test-Path $devRepoLocation) {
		Remove-Item -Recurse -Force -Path $devRepoLocation
	}
}

function Register-LocalGallery {
	param (
		$Path
	)

	$repoPath = Get-DevRepoDirectory
	if ($Path) {
		$repoPath = $Path
	}
	if (-not (Test-Path $repoPath)) {
		New-Item -Path $repoPath -ItemType Directory | Out-Null
	}

	Register-PSRepository -Name (Get-LocalPSRepoName) -SourceLocation $repoPath -ScriptSourceLocation $repoPath -InstallationPolicy Trusted | Out-Null
}

function Unregister-LocalGallery {
	Unregister-PSRepository -Name (Get-LocalPSRepoName) | Out-Null
}

function Update-ModuleVersion {
	[CmdletBinding()]
	param(
		[switch] $Minor,
		[switch] $Major,
		[switch] $Build
	)

	$version = Get-ModuleVersion
	$v = @{
		Major = $version.Major
		Minor = $version.Minor
		Build = $version.Build
	}

	if ($Build.IsPresent) {
		$v.Build++
	}

	if ($Minor.IsPresent) {
		$v.Minor++
	}

	if ($Major.IsPresent) {
		$v.Major++
	}

	$ver = "$($v.Major).$($v.Minor).$($v.Build)"
	Update-ModuleManifest -Path (Get-ModuleManifestFile).FullName -ModuleVersion $ver
}

function Create-ModuleFolder {
	[CmdletBinding()]
	param(
		[string] $OutputDirectory,
		[switch] $NoClean
	)

	if (-not $OutputDirectory) {
		$OutputDirectory = Join-Path (Split-Path -Parent $PSScriptRoot) (Get-ConfigValue -Name OutputPath)
	}

	$modulesDirectory = Join-Path $OutputDirectory (Get-ConfigValue -Name ModuleOutputSubdirectoryName)

	if ((Test-Path $modulesDirectory) -and -not $NoClean.IsPresent) {
		Remove-Item -Recurse -Force -Path $modulesDirectory
	}

	$thisModuleDirectory = Join-Path $modulesDirectory (Get-ModuleName)
	$targetDirectory = Join-Path $thisModuleDirectory (Get-ModuleVersion).ToString()

	New-Item -Path $targetDirectory -ItemType Directory | Out-Null

	$ignorableSegmentCount = ((Get-ModuleBasePath).Replace("\", '/') -split '/').Count
	$sourceFileList = @()
	$destinationFileList = @()
	Get-ModuleFiles | ForEach-Object {
		$normalizedFile = $_.Replace("\", '/')
		$segments = $normalizedFile -split '/'
		$relativeSegments = $segments[$ignorableSegmentCount..($segments.Length - 1)]
		$relativePath = $relativeSegments -join '/'

		$sourceFileList += Join-Path (Get-ModuleBasePath) $relativePath
		$destinationFileList += Join-Path $targetDirectory $relativePath
	}

	0..($sourceFileList.Length - 1) | ForEach-Object {
		$parent = Split-Path -Parent $destinationFileList[$_]
		if (-not (Test-Path $parent)) {
			New-Item -Path $parent -ItemType Directory | Out-Null
		}

		$destinationName = Split-Path -Leaf $destinationFileList[$_]
		$syntaxOnlySourceName = Split-Path -Leaf $sourceFileList[$_]
		$sourceActualName = (Get-ChildItem (Split-Path -Parent $sourceFileList[$_]) -Filter $syntaxOnlySourceName).Name

		if ($destinationName -cne $sourceActualName) {
			throw "The case-sensitive name of the file at source path '$($sourceFileList[$_])' is actually '$sourceActualName' and it does not match the case of the last element of destination path '$($destinationFileList[$_])' -- the case of the file names must match exactly in order to support environments with case-sensitive file systems. This can be corrected in the module manifest by specifying the case of the file exactly as it exists in the module source code directory"
		}

		Copy-Item -Path $sourceFileList[$_] -Destination $destinationFileList[$_]
	}
}

function Get-CustomizationFiles {
	[CmdletBinding()]
	param(
		[string] $Module = "Entra",
		[string] $Directory
	)

	$path = Split-Path -Parent $PSScriptRoot

	if (-not $Directory) {
		$path = Join-Path $path 'module'
		$path = Join-Path $path $Module
		$path = Join-Path $path (Get-ConfigValue -Name CustomizationPath)
	}
 else {
		$path = Join-Path $path 'module'
		$path = Join-Path $path $Module
		$path = Join-Path $path $Directory
	}

	$customizationFileList = @()
	$files = Get-ChildItem -Path $path -Filter '*.ps1'
	foreach ($file in $files) {
		$customizationFileList += $file.FullName
	}

	$customizationFileList
}

function Create-ModuleHelp {
	param (
		[string] $Module = "Entra"
	)

	$binPath = Join-Path (Split-Path -Parent $PSScriptRoot) (Get-ConfigValue -Name OutputPath)
	if (-not (Test-Path $binPath)) {
		New-Item -ItemType Directory -Path $binPath | Out-Null
	}
	$moduleDocsPath = Join-Path (Split-Path -Parent $PSScriptRoot) (Get-ConfigValue -Name ModuleSubdirectoryName)
	$moduleDocsPath = Join-Path $moduleDocsPath (Get-ConfigValue -Name docsPath)
	$moduleDocsPath = Join-Path $moduleDocsPath (Get-ConfigValue -Name ($Module + "Path"))
	New-ExternalHelp -Path $moduleDocsPath -OutputPath $binPath -Force
}