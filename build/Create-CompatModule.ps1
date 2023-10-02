# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
[cmdletbinding()]
param($TargetDirectory = $null, $Module = "AzureADPreview", [switch] $noclean)

. (join-path $psscriptroot "/common-functions.ps1")
. (join-path $psscriptroot "../src/CompatibilityAdapter.ps1")

if($noclean -eq $true) {
    Remove-BuildDirectories
}

$mapper = [CompatibilityAdapterBuilder]::new($Module)

$customizationFiles = Get-CustomizationFiles -Module $Module
foreach($file in $customizationFiles){
    $cmds = & $file
    if($file -like "*Types.ps1"){
        $mapper.AddTypes($cmds)
    }
    else{
        $mapper.AddCustomization($cmds)
    }
}
$AdditionalFunctions = Get-CustomizationFiles -Directory 'AdditionalFunctions'  -Module $Module
foreach($file in $AdditionalFunctions){
    $mapper.AddHelperCommand($file)
}

$mapper.BuildModule()