
param (
    [string]$Module = "Entra"  # Default to "Entra" if no argument is provided
)

. ..\src\EntraModuleBuilder.ps1

# Determine the output path based on the module
$startPath = if ($Module -eq "Entra") {
    "..\module\Entra\Microsoft.Graph.Entra\"
} else {
    "..\module\EntraBeta\Microsoft.Graph.Entra.Beta\"
}
$moduleBuilder = [EntraModuleBuilder]::new()

$moduleBuilder.CreateModuleHelp($Module)
$moduleBuilder.CreateSubModuleFile($startPath, ".\Typedefs.txt")
$moduleBuilder.CreateModuleManifest($Module)
