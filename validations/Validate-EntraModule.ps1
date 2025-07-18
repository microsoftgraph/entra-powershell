# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
[cmdletbinding()]
param(

    [ValidateSet("Entra", "EntraBeta")]
	[string]
	$ModuleName = "Entra"
)
. (Join-Path $psscriptroot "./Validator.ps1")

$validator = [Validator]::new($ModuleName)

$validator.ValidateScriptSubFoldersMatchDocsSubFolders()
$validator.ValidateScriptSubFolderFilesMatchDocsSubFolderFiles()

# Exit the pipeline with an error if any validation failed
$validator.ExitPipeline()