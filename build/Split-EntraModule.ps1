# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------

param (
    [string]$Module = "Entra"  # Default to "Entra" if no argument is provided
)

# Import the necessary scripts
. (Join-Path $psscriptroot "/common-functions.ps1")
. (Join-Path $psscriptroot "../src/EntraModuleSplitter.ps1")
.(Join-Path $psscriptroot "/Split-Docs.ps1")





# Split the module and take into account the AzureADAliases as well
$entraModuleSplitter = [EntraModuleSplitter]::new()
$entraModuleSplitter.SplitEntraModule($Module)  # Pass the module argument
$entraModuleSplitter.ProcessEntraAzureADAliases($Module)

