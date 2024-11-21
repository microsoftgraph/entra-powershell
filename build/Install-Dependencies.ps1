# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
#

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

try {
    # Review: are the common functions required for this script? There does not seem to be any dependencies on them [yet?].
    . "$PSScriptRoot/common-functions.ps1"
} catch {
    Write-Error -Message "Failed to load common-functions.ps1. Error: $_" -RecommendedAction "This script should be run from the 'build' folder. Ensure 'common-functions.ps1' exists and is accessible."
}

if ($ModuleSettingsPath) {
    $SettingsPath = $ModuleSettingsPath
} else {
    $SettingsPath = "$PSScriptRoot/../module/$ModuleName/config/ModuleSettings.json"
}
$ModuleSettings = Get-Content -Path $SettingsPath | ConvertFrom-Json
$RequiredVersion = $ModuleSettings.destinationModuleVersion

if ($Force) {
    Write-Verbose 'Skipping the check for installed prerequisites. Forcing the installation of all required modules.'
} else {
    Write-Verbose 'Checking installed modules for required dependencies.'
    $InstalledModules = Get-Module -ListAvailable -Verbose:$false | Group-Object -Property Name
}

# Install the AzureAD module.
$SourceModule = $ModuleSettings.sourceModule
if (($InstalledModules.Name -contains $SourceModule) -and -not $Force) {
    Write-Verbose "The $SourceModule module is already installed."
} else {
    Write-Verbose("Installing Module: $sourceModule")
    try {
        Install-Module $sourceModule -Scope CurrentUser -Force -AllowClobber
    } catch {
        Write-Error "Failed to install the $sourceModule module. Error: $_"
    }
}

# Install the required module dependencies if missing the required version or if -Force.
foreach ($moduleName in $ModuleSettings.destinationModuleName) {
    $InstalledModuleReference = $InstalledModules.Where({ $_.Name -eq $moduleName })
    if (-not $InstalledModuleReference -or $Force) {
        Write-Verbose "Installing version $RequiredVersion of $moduleName"
        try {
            Install-Module $moduleName -Scope CurrentUser -RequiredVersion $RequiredVersion -Force -AllowClobber
        } catch {
            Write-Error "Failed to install module $moduleName ${RequiredVersion}. Error: $_"
        }
    } elseif ($InstalledModuleReference.Group.Version -contains $RequiredVersion) {
        Write-Verbose "Found version $RequiredVersion of $moduleName"
    }
}
