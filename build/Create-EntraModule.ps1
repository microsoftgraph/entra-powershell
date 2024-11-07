
[cmdletbinding()]
param (
    [string]$Module = "Entra"  # Default to "Entra" if no argument is provided
)

. (Join-Path $psscriptroot "/common-functions.ps1")
. (Join-Path $psscriptroot "../src/EntraModuleBuilder.ps1")

$moduleBuilder = [EntraModuleBuilder]::new()

if($Module -eq 'Entra'){
    $typeDefsPath=".\build\V1.0-Typedefs.txt"
}else{
    $typeDefsPath='.\build\Beta-TypeDefs.txt'
}

$moduleBuilder.CreateModuleHelp($Module)
$moduleBuilder.CreateSubModuleFile($Module, $typeDefsPath)
$moduleBuilder.CreateModuleManifest($Module)
