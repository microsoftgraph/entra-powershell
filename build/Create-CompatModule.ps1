# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
[cmdletbinding()]
param($targetDirectory = $null, [switch] $noclean)

. (join-path $psscriptroot "/common-functions.ps1")
. (join-path $psscriptroot "../src/CompatibilityAdapter.ps1")

Remove-BuildDirectories
$outputFolder = join-path $psscriptroot "../bin"
$nocleanArgument = @{noclean=$noclean}
$mapper = [CompatibilityAdapterBuilder]::new($outputFolder)

$customizationFiles = Get-CustomizationFiles

foreach($file in $customizationFiles){
    $cmds = & $file
    $mapper.AddCustomization($cmds)
}

$mapper.BuildModule()
Create-ModuleFolder -OutputDirector $targetDirectory @nocleanArgument

