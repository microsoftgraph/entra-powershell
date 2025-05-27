
[cmdletbinding()]
param (
    [string]$Module = "Entra",  # Default to "Entra" if no argument is provided
    [switch]$Root
)

. (Join-Path $psscriptroot "/common-functions.ps1")
. (Join-Path $psscriptroot "../src/EntraModuleBuilder.ps1")
. (Join-Path $psscriptroot "../src/Get-MissingCmds.ps1")

$moduleBuilder = [EntraModuleBuilder]::new()

if($Module -eq 'Entra'){

    $typeDefsPath=(Join-Path $PSScriptRoot "/V1.0-Typedefs.txt")
}else{
    $typeDefsPath=(Join-Path $PSScriptRoot "/Beta-TypeDefs.txt")
}
if($Root){
    $moduleBuilder.CreateRootModule($Module)
    $moduleBuilder.CreateRootModuleManifest($Module)
}else{
    $moduleBuilder.CreateModuleHelp($Module)
    $moduleBuilder.CreateSubModuleFile($Module, $typeDefsPath)
    $moduleBuilder.CreateModuleManifest($Module)
}



