# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

# This class builds the submodules i.e. generate the .psm1 file, help-xml and .psd1 file
class EntraModuleBuilder {
    [string]$headerText
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

    
    $this.OutputDirectory = (Join-Path $PSScriptRoot '../bin/')
    $this.TypeDefsDirectory=(Join-Path $PSScriptRoot "../build/TypeDefs.txt")
    $this.BaseDocsPath=(Join-Path $PSScriptRoot '../moduleVNext/docs/')
   
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

    Log-Message "[EntraModuleBuilder] ProcessSubDirectory: Appending content from Typedefs.txt" -ForegroundColor Cyan
    $typedefsContent = Get-Content -Path $typedefsFilePath -Raw
    $psm1Content += "`n# Typedefs`n" + $typedefsContent

    Log-Message "[EntraModuleBuilder] Writing .psm1 file to disk: $psm1FilePath"
    Set-Content -Path $psm1FilePath -Value $psm1Content

    Log-Message "[EntraModuleBuilder] Module file created: $psm1FilePath" -Level 'SUCCESS'
}


    [void] CreateSubModuleFile([string]$Module, [string]$typedefsFilePath=$this.TypeDefsDirectory) {
        # Determine the output path based on the module
        $startDirectory = if ($Module -eq "Entra") {
            (Join-Path $PSScriptRoot "..\moduleVNext\Entra\Microsoft.Graph.Entra")
        } else {
            (Join-Path $PSScriptRoot "..\moduleVNext\EntraBeta\Microsoft.Graph.Entra.Beta")
        }
        Log-Message "[EntraModuleBuilder] Starting CreateSubModuleFile script..."

        $resolvedStartDirectory = $this.ResolveStartDirectory($startDirectory)

        if (-not ($this.CheckTypedefsFile($typedefsFilePath))) {
            Log-Message "[EntraModuleBuilder] $typedefsFilePath not found" -Level 'ERROR'
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

        $destDirectory = $this.OutputDirectory
        $this.EnsureDestinationDirectory($destDirectory)

        foreach ($subDir in $subDirectories) {
            # Skip the 'Migration' sub-directory
            if ($subDir.Name -eq 'Migration' -or $subDir.Name -eq 'Invitations') {
                Log-Message "[EntraModuleBuilder]: Skipping 'Migration' directory." -Level 'INFO'
                continue
            }
            $this.ProcessSubDirectory($subDir.FullName, $subDir.Name, $parentDirName, $destDirectory, $typedefsFilePath)
        }

        #Create the RootModule .psm1 file
        $this.CreateRootModule($Module)

        Log-Message "[EntraModuleBuilder] CreateSubModuleFile script completed." -Level 'SUCCESS'
    }
 [string[]] GetSubModuleFiles([string] $Module, [string]$DirectoryPath) {
        # Check if the directory exists
        # Define the pattern for matching submodule files
        $pattern = if ($module -like "Microsoft.Graph.Entra.Beta.*") {
            "Microsoft.Graph.Entra.Beta.*.psm1"
        } else {
            "Microsoft.Graph.Entra.*.psm1"
        }

        if (-Not (Test-Path -Path $DirectoryPath)) {
            Log-Message "[EntraModuleBuilder]: Directory does not exist: $directoryPath" -ForegroundColor Red
            return $null # Return null if directory does not exist
        }

        # Get all .psm1 files in the specified directory
        $subModules = Get-ChildItem -Path $DirectoryPath -Filter $pattern -File

        # Check if any .psm1 files were found
        if ($subModules.Count -eq 0) {
            Log-Message "[EntraModuleBuilder]: No .psm1 files found in the directory: $directoryPath" -Level 'INFO'
            return @() # Return an empty array if no files are found
        } else {
            # Return the names of the .psm1 files
            return $subModules.Name
        }
    }
  [string[]] GetSubModuleMaifestFiles([string] $Module, [string]$DirectoryPath) {
        # Check if the directory exists
        # Define the pattern for matching submodule files
        $pattern = if ($module -like "Microsoft.Graph.Entra.Beta.*") {
            "Microsoft.Graph.Entra.Beta.*.psd1"
        } else {
            "Microsoft.Graph.Entra.*.psd1"
        }

        if (-Not (Test-Path -Path $DirectoryPath)) {
            Log-Message "[EntraModuleBuilder]: Directory does not exist: $directoryPath" -ForegroundColor Red
            return $null # Return null if directory does not exist
        }

        # Get all .psm1 files in the specified directory
        $subModules = Get-ChildItem -Path $DirectoryPath -Filter $pattern -File

        # Check if any .psm1 files were found
        if ($subModules.Count -eq 0) {
            Log-Message "[EntraModuleBuilder]: No .psd1 files found in the directory: $directoryPath" -Level 'INFO'
            return @() # Return an empty array if no files are found
        } else {
            # Return the names of the .psm1 files
            return $subModules.Name
        }
    }
# Main function to create the root module
[void] CreateRootModule([string] $Module) {
    # Determine the root module name based on the module type
    $rootModuleName = if ($Module -eq 'Entra') {
        'Microsoft.Graph.Entra.psm1'
    } else {
        'Microsoft.Graph.Entra.Beta.psm1'
    }

    # Get the list of submodules and exclude the root module
    $subModuleFiles = $this.GetSubModuleFiles($Module, $this.OutputDirectory)
    $subModules = @()
    
    # Prevents the old root module from being added to avoid cyclic dependencies
    foreach ($module in $subModuleFiles) {
        if ($module -ne $rootModuleName) {
            $subModules += $module
        }
    }

    # Build the code snippet using the GetCodeSnippet function
    $codeSnippet = $this.GetCodeSnippet($subModules)

    # Combine the header text and the code snippet for the root module
    $rootModuleContent = $this.headerText + "`n" + $codeSnippet

    # Define the file paths
    $rootModulePath = Join-Path -Path $this.OutputDirectory -ChildPath $rootModuleName

    # Write the root module content (psm1)
    $rootModuleContent | Out-File -FilePath $rootModulePath -Encoding utf8

    Log-Message "[EntraModuleBuilder]: Root Module successfully created" -Level 'SUCCESS'
}

[string] GetCodeSnippet([Array] $subModules) {
    $codeSnippet = @"
# Set execution policy to ensure scripts can be executed
Set-ExecutionPolicy RemoteSigned -Scope Process -Force

# Import all sub-modules dynamically
`$subModules = @(
"@

    for ($i = 0; $i -lt $subModules.Count; $i++) {
        $codeSnippet += "    '$($subModules[$i])'"
        if ($i -lt $subModules.Count - 1) {
            $codeSnippet += ",`n"  # Add a comma except for the last item
        } else {
            $codeSnippet += "`n"  # Just a newline for the last item
        }
    }

    # Close the array and the loop
    $codeSnippet += @"
)
`$moduleBasePath = Split-Path -Parent `$MyInvocation.MyCommand.Definition
foreach (`$subModule in `$subModules) {
    `$subModulePath = Join-Path `$moduleBasePath -ChildPath `$subModule
    Import-Module -Name `$subModulePath -Global
}
"@

    return $codeSnippet
}

  [void] CreateRootModuleManifest([string] $Module) {
	 
	    # Update paths specific to this sub-directory
        $rootPath=if ($Module -eq "Entra") {
           (Join-Path $PSScriptRoot "../moduleVNext/Entra")
        } else {
            (Join-Path $PSScriptRoot "../moduleVNext/EntraBeta")
        }
      	
		$moduleName=if($Module  -eq 'Entra'){
			'Microsoft.Graph.Entra'
		}else{
			'Microsoft.Graph.Entra.Beta'
		}
		
        $settingPath = Join-Path $rootPath -ChildPath "/config/ModuleMetadata.json" 
		
		#We do not need to create a help file for the root module, since once the nested modules are loaded, their help will be available
        $files = @("$($moduleName).psd1", "$($moduleName).psm1")
        $content = Get-Content -Path $settingPath | ConvertFrom-Json
        $PSData = @{
            Tags = $($content.tags)
            LicenseUri = $($content.licenseUri)
            ProjectUri = $($content.projectUri)
            IconUri = $($content.iconUri)
            ReleaseNotes = $($content.releaseNotes)
            Prerelease = $null
        }
        $manifestPath = Join-Path $this.OutputDirectory -ChildPath "$($moduleName).psd1"
		
        $subModules=$this.GetSubModuleManifestFiles($Module,$this.OutputDirectory)
        $requiredModules=@()
        $nestedModules=@()
        foreach($module in $subModules){
            if($module -ne $moduleName){
                Log-Message "Adding $module to Root Module Nested Modules" -Level 'INFO'
               $requiredModules += @{ ModuleName = $module; RequiredVersion = $content.version }
               $nestedModules+=$module

            }	
        }
        $moduleSettings = @{
            Path = $manifestPath
            GUID = $($content.guid)
            ModuleVersion = "$($content.version)"
            FunctionsToExport =@()
            CmdletsToExport=@()
            AliasesToExport=@()
            Author =  $($content.authors)
            CompanyName = $($content.owners)
            FileList = $files
            RootModule = "$($moduleName).psm1" 
            Description = 'Microsoft Graph Entra PowerShell.'    
            DotNetFrameworkVersion = $([System.Version]::Parse('4.7.2')) 
            PowerShellVersion = $([System.Version]::Parse('5.1'))
            CompatiblePSEditions = @('Desktop','Core')
            RequiredModules=$requiredModules
            NestedModules = $nestedModules
        }
        
        if($null -ne $content.Prerelease){
            $PSData.Prerelease = $content.Prerelease
        }

        Log-Message "[EntraModuleBuilder]: Starting Root Module Manifest generation" -Level 'INFO'
        
        New-ModuleManifest @moduleSettings
        Update-ModuleManifest -Path $manifestPath -PrivateData $PSData

        # Validate the module manifest
         $manifestValidationResult = Test-ModuleManifest -Path $manifestPath

        # Check if the validation was successful
         if ($manifestValidationResult) {
            Log-Message "Root Module manifest is valid." -Level 'INFO'
        } else {
            Log-Message "Root Module manifest is invalid." -Level 'ERROR'
        }
		
		Log-Message "[EntraModuleBuilder]: Root Module Manifest successfully created" -Level 'INFO'
 }

 [void] CreateModuleManifest($module) {
    # Update paths specific to this sub-directory
        $rootPath=if ($Module -eq "Entra") {
           (Join-Path $PSScriptRoot "../moduleVNext/Entra")
        } else {
            (Join-Path $PSScriptRoot "../moduleVNext/EntraBeta")
        }
    $moduleBasePath =if ($Module -eq "Entra") {
            (Join-Path $rootPath "/Microsoft.Graph.Entra")
        } else {
            (Join-Path $rootPath "/Microsoft.Graph.Entra.Beta")
    }

    $subDirectories = Get-ChildItem -Path $moduleBasePath -Directory

		
    $settingPath = Join-Path $rootPath -ChildPath "/config/ModuleMetadata.json" 
    $dependencyMappingPath = Join-Path $rootPath -ChildPath "/config/dependencyMapping.json"

    # Load the module metadata
    $content = Get-Content -Path $settingPath | ConvertFrom-Json

    # Create Manifest for each SubModule
    
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
        Log-Message "[EntraModuleBuilder]: Processing module: $moduleFileName"

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
        Log-Message "[EntraModuleBuilder]: The specified directory does not exist: $subDir" -Level 'ERROR'
        exit
       }

       # Get all files in the specified directory and its subdirectories, without extensions
        $allFunctions = Get-ChildItem -Path $subDir -Recurse -File | ForEach-Object { $_.BaseName }

        $functions = $allFunctions + "Enable-EntraAzureADAlias" + "Get-EntraUnsupportedCommand"

        # Collect required modules from dependency mapping
        $requiredModules = @()
        if (Test-Path $dependencyMappingPath) {
            $jsonContent = Get-Content -Path $dependencyMappingPath -Raw | ConvertFrom-Json
           
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
        Log-Message "[EntraModuleBuilder]: Creating manifest for $moduleName at $manifestPath"
        try{
             New-ModuleManifest @moduleSettings
            Update-ModuleManifest -Path $manifestPath -PrivateData $PSData
             # Validate the module manifest
            $manifestValidationResult = Test-ModuleManifest -Path $manifestPath

            # Check if the validation was successful
            if ($manifestValidationResult) {
                Log-Message "$manifestFileName Module manifest is valid." -Level 'INFO'
            } else {
                Log-Message "$manifestFileName Module manifest is invalid." -Level 'ERROR'
            }

        # Log completion for this module
        Log-Message "[EntraModuleBuilder]: Manifest for $moduleName created successfully" -Level 'SUCCESS'

        }catch{
            Log-Message $_.Exception.Message -Level 'ERROR'
        }
       
    }

}


[void] CreateModuleHelp([string] $Module) {

    Log-Message "[EntraModuleBuilder] CreateModuleHelp: Starting the creation of Module help.."
   
    if (!(Test-Path $this.OutputDirectory)) {
        New-Item -ItemType Directory -Path $this.OutputDirectory | Out-Null
    }

    Log-Message "[EntraModuleBuilder] CreateModuleHelp: Output Directory $this.OutputDirectory verified..."
    # Determine the base docs path based on the specified module
    $docsPath = $this.BaseDocsPath
    if ($Module -eq "Entra") {
        $docsPath = Join-Path -Path $this.BaseDocsPath -ChildPath "entra-powershell-v1.0"
    } elseif ($Module -eq "EntraBeta") {
        $docsPath = Join-Path -Path $this.BaseDocsPath -ChildPath "entra-powershell-beta"
    } else {
       Log-Message "[EntraModuleBuilder] CreateModuleHelp:Invalid module specified: $Module" -Level 'ERROR'
        return
    }

    # Check if the base docs path exists
    if (!(Test-Path $docsPath)) {
        Log-Message "[EntraModuleBuilder] CreateModuleHelp: The specified base documentation path does not exist: $docsPath" -Level 'ERROR'
        return
    }

    Log-Message "[EntraModuleBuilder] CreateModuleHelp: Docs files directory &docsPath verified..."

    # Get all subdirectories within the base docs path
    $subDirectories = Get-ChildItem -Path $docsPath -Directory
    foreach ($subDirectory in $subDirectories) {
        # Skip the 'Migration' sub-directory
        if ($subDirectory.Name -eq 'Migration' -or $subDirectory.Name -eq 'Invitations') {
            Log-Message "[EntraModuleBuilder] CreateModuleHelp:Skipping 'Migration' directory." -Level 'INFO'
            continue
        }

       Log-Message "[EntraModuleBuilder] CreateModuleHelp:Creating help file for $subDirectory.."

        # Get all markdown files in the current subdirectory
        $markDownFiles = Get-ChildItem -Path $subDirectory.FullName -Filter "*.md"
       
        # Check if markdown files are found
        if (-not($markDownFiles)) {
            Log-Message "[EntraModuleBuilder] CreateModuleHelp:No markdown files found in $($subDirectory.FullName)." -Level 'ERROR'
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

        $moduleDocsPath = $subDirectory
		
		try {
            # Create the help file using PlatyPS
            New-ExternalHelp -Path $moduleDocsPath -OutputPath $helpOutputFilePath -Force

            Log-Message "[EntraModuleBuilder] CreateModuleHelp help file generated: $helpOutputFilePath" -Level 'SUCCESS'
			
		} catch {			
            Log-Message "[EntraModuleBuilder] CreateModuleHelp: $_.Exception.Message" -Level 'ERROR'
		}
    }

    Log-Message "[EntraModuleBuilder] Help files generated successfully for module: $Module" -Level 'SUCCESS'
}


}