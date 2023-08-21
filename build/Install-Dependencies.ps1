# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

[cmdletbinding()]
param(
    $ModuleSettingsPath = "../config/ModuleSettings.json"
)

. "$psscriptroot/common-functions.ps1"

$settingPath = Join-Path $PSScriptRoot $ModuleSettingsPath
$content = Get-Content -Path $settingPath | ConvertFrom-Json
Write-Verbose("Installing Module $($content.sourceModule)")
Install-Module $content.sourceModule -scope currentuser -Force -AllowClobber

foreach ($moduleName in $content.destinationModuleName){
    Write-Verbose("Installing Module $($moduleName)")
    Install-Module $moduleName -scope currentuser -RequiredVersion $content.destinationModuleVersion -Force -AllowClobber
}