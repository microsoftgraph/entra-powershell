
param (
    [string]$Module = "Entra"  # Default to "Entra" if no argument is provided
)

. ..\src\EntraModuleBuilder.ps1

$moduleBuilder = [EntraModuleBuilder]::new()


$moduleBuilder.CreateModuleHelp($Module)
$moduleBuilder.CreateSubModuleFile($Module, ".\Typedefs.txt")
$moduleBuilder.CreateModuleManifest($Module)
