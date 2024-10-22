# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
. ../build/common-functions.ps1
# This class builds the submodules i.e. generate the .psm1 file, help-xml and .psd1 file
class EntraModuleBuilder {
    [string]$headerText
    [string]$BasePath
    [string]$OutputDirectory
    [string]$TypeDefsDirectory
    [string]$BaseDocsPath

    EntraModuleBuilder() {
        $this.headerText = @"
# ------------------------------------------------------------------------------ 
#  Copyright (c) Microsoft Corporation.  All Rights Reserved. 
#  Licensed under the MIT License.  See License in the project root for license information. 
# ------------------------------------------------------------------------------ 
Set-StrictMode -Version 5 
"@

    $this.BasePath = (join-path $PSScriptRoot '../module/Entra/') 
    $this.OutputDirectory = (join-path $PSScriptRoot '../bin/') 
    $this.TypeDefsDirectory="./Typedefs.txt"
    $this.BaseDocsPath='../docs/'
    }

    [string] ResolveStartDirectory([string]$directory) {
        return Resolve-Path -Path $directory
    }

    [bool] CheckTypedefsFile([string]$typedefsFilePath) {
        if (-not (Test-Path -Path $typedefsFilePath)) {
            Log-Message "[EntraModuleBuilder] Error: Typedefs.txt file not found at $typedefsFilePath" -Level 'ERROR'
            return $false
        } else {
            Log-Message "[EntraModuleBuilder] Typedefs.txt found at $typedefsFilePath" -Level 'INFO'
            return $true
        }
    }

    [void] EnsureDestinationDirectory([string]$destDirectory) {
        if (-not (Test-Path -Path $destDirectory)) {
            New-Item -ItemType Directory -Path $destDirectory | Out-Null
            Log-Message "[EntraModuleBuilder] Created destination directory: $destDirectory"
        }
    }

    [string[]] RemoveHeader([string[]]$content) {
        $inHeader = $false
        $filteredContent = @()

        foreach ($line in $content) {
            $trimmedLine = $line.Trim()

            if ($trimmedLine -eq '# ------------------------------------------------------------------------------') {
                $inHeader = -not $inHeader
                continue
            }

            if (-not $inHeader) {
                $filteredContent += $line
            }
        }

        return $filteredContent
    }

    [void] ProcessSubDirectory([string]$currentDirPath, [string]$currentDirName, [string]$parentDirName, [string]$destDirectory, [string]$typedefsFilePath) {
    Log-Message "[EntraModuleBuilder] Processing directory: $currentDirPath"

    $psm1FileName = "$parentDirName.$currentDirName.psm1"
    $psm1FilePath = Join-Path -Path $destDirectory -ChildPath $psm1FileName

    Log-Message "[EntraModuleBuilder] Creating .psm1 file: $psm1FilePath"

    $psm1Content = $this.headerText + "`n"  # Add a newline after the header
    $ps1Files = Get-ChildItem -Path $currentDirPath -Filter "*.ps1"

    if ($ps1Files.Count -eq 0) {
        Log-Message "[EntraModuleBuilder] Warning: No .ps1 files found in directory $currentDirPath" -Level 'ERROR'
    }

    $enableEntraFiles = @()
    $otherFiles = @()

    foreach ($ps1File in $ps1Files) {
        if ($ps1File.Name -like "Enable-Entra*") {
            $enableEntraFiles += $ps1File
        } else {
            $otherFiles += $ps1File
        }
    }

    foreach ($ps1File in $otherFiles) {
        Log-Message "[EntraModuleBuilder] Appending content from file: $($ps1File.Name)"
        $fileContent = Get-Content -Path $ps1File.FullName
        $cleanedContent = $this.RemoveHeader($fileContent)
        $psm1Content += $cleanedContent -join "`n"
    }

    foreach ($ps1File in $enableEntraFiles) {
        Log-Message "[EntraModuleBuilder] Appending content from file: $($ps1File.Name)" -ForegroundColor Cyan
        $fileContent = Get-Content -Path $ps1File.FullName
        $cleanedContent = $this.RemoveHeader($fileContent)
        $psm1Content += $cleanedContent -join "`n"
    }

    # Add the Export-ModuleMember line to export functions
    $functionsToExport = ($otherFiles + $enableEntraFiles | ForEach-Object { $_.BaseName }) -join "', '"
    $psm1Content += "`nExport-ModuleMember -Function @('$functionsToExport')`n"

    Write-Host "[EntraModuleBuilder] Appending content from Typedefs.txt" -ForegroundColor Cyan
    $typedefsContent = Get-Content -Path $typedefsFilePath -Raw
    $psm1Content += "`n# Typedefs`n" + $typedefsContent

    Log-Message "[EntraModuleBuilder] Writing .psm1 file to disk: $psm1FilePath"
    Set-Content -Path $psm1FilePath -Value $psm1Content

    Log-Message "[EntraModuleBuilder] Module file created: $psm1FilePath" -Level 'SUCCESS'
}


    [void] CreateSubModuleFile([string]$startDirectory, [string]$typedefsFilePath=$this.TypeDefsDirectory) {
        Log-Message "[EntraModuleBuilder] Starting CreateSubModuleFile script..."

        $resolvedStartDirectory = $this.ResolveStartDirectory($startDirectory)

        if (-not ($this.CheckTypedefsFile($typedefsFilePath))) {
            return
        }

        if (-not (Test-Path -Path $resolvedStartDirectory)) {
            Log-Message "[EntraModuleBuilder] Error: Start directory not found: $resolvedStartDirectory" -Level 'ERROR'
            return
        } else {
            Log-Message "[EntraModuleBuilder] Processing directories inside: $resolvedStartDirectory"
        }

        $subDirectories = Get-ChildItem -Path $resolvedStartDirectory -Directory

        $parentDirPath = Get-Item $resolvedStartDirectory
        $parentDirName = $parentDirPath.Name

        $destDirectory = Join-Path -Path (Get-Location) -ChildPath $this.OutputDirectory
        $this.EnsureDestinationDirectory($destDirectory)

        foreach ($subDir in $subDirectories) {
            $this.ProcessSubDirectory($subDir.FullName, $subDir.Name, $parentDirName, $destDirectory, $typedefsFilePath)
        }

        Log-Message "[EntraModuleBuilder] CreateSubModuleFile script completed." -Level 'SUCCESS'
    }

 [void] CreateRootModule([string] $Module){
     
 }

 [void] CreateModuleManifest($module) {
  

    $subDirectories = Get-ChildItem -Path $this.BasePath -Directory

    # Update paths specific to this sub-directory
    $settingPath = Join-Path $this.BasePath "./config/ModuleMetadata.json" 
    $dependencyMappingPath = Join-Path $this.BasePath "./config/dependencyMapping.json"

    # Load the module metadata
    $content = Get-Content -Path $settingPath | ConvertFrom-Json

    # Load dependency mapping from JSON
    # Check if the dependency mapping file exists and load it
    if (Test-Path $dependencyMappingPath) {
        # Read the JSON content
        $jsonContent = Get-Content -Path $dependencyMappingPath -Raw
        
        # Check if the JSON content is not null or empty
        if (-not [string]::IsNullOrEmpty($jsonContent)) {
            # Convert JSON to Hashtable
            $dependencyMapping = @{}
            $parsedContent = $jsonContent | ConvertFrom-Json
            foreach ($key in $parsedContent.PSObject.Properties.Name) {
                $dependencyMapping[$key] = $parsedContent.$key
            }
        } else {
           Log-Message "[EntraModuleBuilder] Warning: dependencyMapping.json is empty." -Level 'ERROR'
        }
    } else {
        Log-Message "[EntraModuleBuilder] Warning: dependencyMapping.json not found at $dependencyMappingPath." -Level 'ERROR'
    }

    
    foreach ($subDir in $subDirectories) {
        # Define module name based on sub-directory name
        $moduleName = $subDir.Name

        $helpFileName = if ($Module -eq "Entra") {
            "Microsoft.Graph.Entra.$moduleName-Help.xml"
        } else {
            "Microsoft.Graph.Entra.Beta.$moduleName-Help.xml"
        }
		
		
        $manifestFileName = if ($Module -eq "Entra") {
            "Microsoft.Graph.Entra.$moduleName.psd1"
        } else {
            "Microsoft.Graph.Entra.Beta.$moduleName.psd1"
        }

       
        $moduleFileName = if ($Module -eq "Entra") {
            "Microsoft.Graph.Entra.$moduleName.psm1"
        } else {
            "Microsoft.Graph.Entra.Beta.$moduleName.psm1"
        }

        # Log the start of processing for this module
        Log-Message "[EntraModuleBuilder] Processing module: $moduleFileName"

        # Define PSData block based on the contents of the ModuleMetadata.json file
        $PSData = @{
            Tags = $($content.tags)
            LicenseUri = $($content.licenseUri)
            ProjectUri = $($content.projectUri)
            IconUri = $($content.iconUri)
            ReleaseNotes = $($content.releaseNotes)
            Prerelease = $null
        }


        # Set the manifest path and functions to export
        $manifestPath = Join-Path $this.OutputDirectory "$manifestFileName"

        # Check if the specified directory exists
       if (-Not (Test-Path -Path $subDir)) {
        Log-Message "The specified directory does not exist: $subDir" -Level 'ERROR'
        exit
       }

       # Get all files in the specified directory and its subdirectories, without extensions
        $allFunctions = Get-ChildItem -Path $subDir -Recurse -File | ForEach-Object { $_.BaseName }

        $functions = $allFunctions + "Enable-EntraAzureADAlias" + "Get-EntraUnsupportedCommand"

        # Collect required modules from dependency mapping
        $requiredModules = @()
        if (Test-Path $dependencyMappingPath) {
            $jsonContent = Get-Content -Path $dependencyMappingPath -Raw | ConvertFrom-Json
            Write-Host "Dependency Mapping: $jsonContent" -ForegroundColor Green
            # Convert JSON to Hashtable
            $dependencyMapping = @{}
            foreach ($key in $jsonContent.PSObject.Properties.Name) {
                $dependencyMapping[$key] = $jsonContent.$key
            }
            
            $keyModuleName= [System.IO.Path]::GetFileNameWithoutExtension($moduleFileName)
            
            if ($dependencyMapping.ContainsKey($keyModuleName)) {
                foreach ($dependency in $dependencyMapping[$keyModuleName]) {
                    $requiredModules += @{ ModuleName = $dependency; RequiredVersion = $content.requiredModulesVersion }
                }
            }
        }

        # Module manifest settings
        $moduleSettings = @{
            Path = $manifestPath
            GUID = $($content.guid)
            ModuleVersion = "$($content.version)"
            FunctionsToExport = $functions
            CmdletsToExport = @()
            AliasesToExport = @()
            Author = $($content.authors)
            CompanyName = $($content.owners)
            FileList = @("$manifestFileName", "$moduleFileName", "$helpFileName")
            RootModule = "$moduleFileName"
            Description = 'Microsoft Graph Entra PowerShell.'
            DotNetFrameworkVersion = $([System.Version]::Parse('4.7.2'))
            PowerShellVersion = $([System.Version]::Parse('5.1'))
            CompatiblePSEditions = @('Desktop', 'Core')
            RequiredModules = $requiredModules
            NestedModules = @()
        }
		

        # Add prerelease info if it exists
        if ($null -ne $content.Prerelease) {
            $PSData.Prerelease = $content.Prerelease
        }

        

        # Create and update the module manifest
        Log-Message "[EntraModuleBuilder] Creating manifest for $moduleName at $manifestPath"
        New-ModuleManifest @moduleSettings
        Update-ModuleManifest -Path $manifestPath -PrivateData $PSData

        # Log completion for this module
        Log-Message "[EntraModuleBuilder] Manifest for $moduleName created successfully" -Level 'SUCCESS'
    }
}



[void] CreateModuleHelp([string] $Module) {
   
    if (!(Test-Path $this.OutputDirectory)) {
        New-Item -ItemType Directory -Path $this.OutputDurectory | Out-Null
    }

    # Determine the base docs path based on the specified module
    $docsPath=$this.BaseDocsPath
    if ($Module -eq "Entra") {
        $docsPath = Join-Path -Path $this.BaseDocsPath -ChildPath "entra-powershell-v1.0/Microsoft.Graph.Entra"
    } elseif ($Module -eq "EntraBeta") {
        $docsPath = Join-Path -Path $this.BaseDocsPath -ChildPath "entra-powershell-beta/Microsoft.Graph.Entra.Beta"
    } else {
        Log-Message "Invalid module specified: $Module" -Level 'ERROR'
        return
    }

    # Check if the base docs path exists
    if (!(Test-Path $docsPath)) {
        Log-Message "The specified base documentation path does not exist: $docsPath" -Level 'ERROR'
        return
    }

    # Get all subdirectories within the base docs path
    $subDirectories = Get-ChildItem -Path $docsPath -Directory
	Write-Host "SubDirs: $subDirectories" -ForegroundColor Blue
    foreach ($subDirectory in $subDirectories) {
        # Get all markdown files in the current subdirectory
        $markdownFiles = Get-ChildItem -Path $subDirectory.FullName -Filter "*.md"

        if ($markdownFiles.Count -eq 0) {
            Log-Message "No markdown files found in $($subDirectory.FullName)." -Level 'ERROR'
            continue
        }

        # Generate the help file name based on the module and sub-directory
        $subDirectoryName = [System.IO.Path]::GetFileName($subDirectory.FullName)

        $helpFileName = if ($Module -eq "Entra") {
            "Microsoft.Graph.Entra.$subDirectoryName-Help.xml"
        } else {
            "Microsoft.Graph.Entra.Beta.$subDirectoryName-Help.xml"
        }
 
        $helpOutputFilePath = Join-Path -Path $this.OutputDirectory -ChildPath $helpFileName

        $moduleDocsPath=$subDirectory
		
		try{
		  # Create the help file using PlatyPS
	    New-ExternalHelp -Path $moduleDocsPath -OutputPath $helpOutputFilePath -Force

        Log-Message "[EntraModuleBuilder] Help file generated: $helpOutputFilePath" -Level 'SUCCESS'
			
		}catch{			
		    Log-Message "[EntraModuleBuilder] CreateModuleHelp:  $_.Exception.Message" -Level 'ERROR'
		}

      
    }

    Log-Message "[EntraModuleBuilder] Help files generated successfully for module: $Module" -Level 'SUCCESS'
}

}