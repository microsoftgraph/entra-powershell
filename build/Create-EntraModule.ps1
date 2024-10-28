
param (
    [string]$Module = "Entra"  # Default to "Entra" if no argument is provided
)

. ..\src\EntraModuleBuilder.ps1
. .\Split-Docs 

$moduleBuilder = [EntraModuleBuilder]::new()

# Split the docs first
Split-Docs -Source $Module
$moduleBuilder.CreateModuleHelp($Module)
$moduleBuilder.CreateSubModuleFile($Module, ".\Typedefs.txt")
$moduleBuilder.CreateModuleManifest($Module)
