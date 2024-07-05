# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

[CmdletBinding()]
param(
    # The name of the module to install dependencies for. The module name should match the folder name in the module folder. If not provided, the script will default to 'Entra'.
    [ArgumentCompleter({ (Get-ChildItem -Path "$PSScriptRoot\..\module").Name })]
    [string]
    $ModuleName = 'Entra',

    # Path to the ModuleSettings.json file. If not provided, the script will look for the file in the module folder.
    [ValidateScript({ Test-Path $_ })]
    [string]
    $ModuleSettingsPath,

    # Force installation of the required modules, even if they are already installed.
    [switch]
    $Force
)

# Get module settings from the relevant ModuleSettings.json file or a file that is manually specified.
if ($ModuleSettingsPath) {
    $SettingsPath = $ModuleSettingsPath
} else {
    $SettingsPath = "$PSScriptRoot/../module/$ModuleName/config/ModuleSettings.json"
}

Write-Host "Getting module settings from: '$SettingsPath'" -ForegroundColor Cyan
$ModuleSettings = Get-Content -Path $SettingsPath | ConvertFrom-Json
$SourceModule = $ModuleSettings.sourceModule
$DependencyRequiredVersion = $ModuleSettings.destinationModuleVersion

# Get the names of the source and destination modules from the ModuleSettings.json file.
[string[]]$ModuleNames = (($ModuleSettings.destinationModuleName) + $SourceModule).Split()

Write-Host 'Checking for installed source and dependency modules...' -ForegroundColor Cyan
$InstalledModules = foreach ( $Module in $ModuleNames ) {
    Get-Module -Name $Module -ListAvailable -Verbose:$false | Sort-Object Name
}

# Check if the source module is installed and then install it or update it.
$IsSourceInstalled = $InstalledModules.Name -contains $SourceModule
if (
    (-not $IsSourceInstalled) -or
    ($IsSourceInstalled -and $Force.IsPresent)
) {
    Write-Host "Installing Module: '$SourceModule'" -ForegroundColor Green
    try {
        Install-Module $SourceModule -Scope CurrentUser -Force -AllowClobber
    } catch {
        Write-Error "Failed to install the '$SourceModule' module. Error: $_"
    }
}

# Install or update the destination modules specified in the ModuleSettings.json file.
foreach ($DestinationModuleName in $ModuleSettings.destinationModuleName) {
    $IsDependencyInstalled = $InstalledModules.Name -contains $DestinationModuleName
    if (
        # Force installation if the module is not installed or if the Force switch is present.
        (-not $IsDependencyInstalled) -or ($IsDependencyInstalled -and $Force.IsPresent)
    ) {
        Write-Host "Installing Module: '$DestinationModuleName'" -ForegroundColor Green
        try {
            Install-Module $DestinationModuleName -RequiredVersion $DependencyRequiredVersion -Scope CurrentUser -Force -AllowClobber
        } catch {
            Write-Error "Failed to install the '$DestinationModuleName' module. Error: $_"
        }
    } else {
        Write-Host "Updating Module: '$DestinationModuleName'" -ForegroundColor Green
        try {
            Update-Module -Name $DestinationModuleName -RequiredVersion $DependencyRequiredVersion -ErrorAction SilentlyContinue
        } catch {
            Write-Warning "Failed to update module '$DestinationModuleName' to version ${RequiredVersion}. Error: $_"
        }
    }
}
