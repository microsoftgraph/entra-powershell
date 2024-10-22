# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

param (
    [string]$Module = "Entra"  # Default to "Entra" if no argument is provided
)

# Import the necessary scripts
. ..\src\EntraModuleSplitter.ps1



# Split the module and take into account the AzureADAliases as well
$entraModuleSplitter = [EntraModuleSplitter]::new()
$entraModuleSplitter.SplitEntraModule($Module)  # Pass the module argument
$entraModuleSplitter.ProcessEntraAzureADAliases($Module)

. ..\src\EntraModuleBuilder.ps1
# Build Entra Module
$moduleBuilder = [EntraModuleBuilder]::new()

# Determine the output path based on the module
$outputPath = if ($Module -eq "Entra") {
    "..\module\Entra\Microsoft.Graph.Entra\"
} else {
    "..\module\EntraBeta\Microsoft.Graph.Entra.Beta\"
}

$moduleBuilder.CreateHelpFile($Module)
$moduleBuilder.CreateSubModuleFile($outputPath, ".\Typedefs.txt")
$moduleBuilder.CreateModuleManifest($Module)
