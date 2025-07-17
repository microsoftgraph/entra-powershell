# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
[cmdletbinding()]
param(

    [ValidateSet("Entra", "EntraBeta")]
	[string]
	$Module = "Entra"
)
. (Join-Path $psscriptroot "./Validator.ps1")

$validator = [Validator]::new($Module)

$validator.ValidateScriptSubFoldersMatchDocsSubFolders()
$validator.ValidateScriptSubFolderFilesMatchDocsSubFolderFiles()