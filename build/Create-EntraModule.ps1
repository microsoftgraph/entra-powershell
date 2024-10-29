
[cmdletbinding()]
param (
    [string]$Module = "Entra"  # Default to "Entra" if no argument is provided
)

. (Join-Path $psscriptroot "/common-functions.ps1")
. (Join-Path $psscriptroot "../src/EntraModuleBuilder.ps1")

$moduleBuilder = [EntraModuleBuilder]::new()


$moduleBuilder.CreateModuleHelp($Module)
$moduleBuilder.CreateSubModuleFile($Module, ".\Typedefs.txt")
$moduleBuilder.CreateModuleManifest($Module)
