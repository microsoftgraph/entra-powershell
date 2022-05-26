# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
[cmdletbinding()]
param($targetDirectory = $null, [switch] $noclean)

. "$psscriptroot/common-functions.ps1"

$nocleanArgument = @{noclean=$noclean}
Move-ModuleFiles -OutputDirector $targetDirectory @nocleanArgument

