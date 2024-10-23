

. ..\src\EntraModuleBuilder.ps1
# Build Entra Module
$moduleBuilder = [EntraModuleBuilder]::new()

# Determine the output path based on the module
$startPath = if ($Module -eq "Entra") {
    "..\module\Entra\Microsoft.Graph.Entra\"
} else {
    "..\module\EntraBeta\Microsoft.Graph.Entra.Beta\"
}

$moduleBuilder.CreateModuleHelp($Module)
$moduleBuilder.CreateSubModuleFile($startPath, ".\Typedefs.txt")
$moduleBuilder.CreateModuleManifest($Module)
