# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
[cmdletbinding()]
param(
	[string]
	$TargetDirectory,

	[string]
	$Module = "AzureAD",

	[switch]
	$NoClean
)

. (Join-Path $psscriptroot "/common-functions.ps1")
. (Join-Path $psscriptroot "../src/CompatibilityAdapter.ps1")

if ($NoClean) {
	Remove-BuildDirectories
}

$mapper = [CompatibilityAdapterBuilder]::new($Module)

$customizationFiles = Get-CustomizationFiles -Module $Module
foreach ($file in $customizationFiles) {
	$cmds = & $file
	if ($file -like "*Types.ps1") {
		$mapper.AddTypes($cmds)
	}
	else {
		$mapper.AddCustomization($cmds)
	}
}
$AdditionalFunctions = Get-CustomizationFiles -Directory 'AdditionalFunctions' -Module $Module
foreach ($file in $AdditionalFunctions) {
	$mapper.AddHelperCommand($file)
}

# $CustomeTypes = Get-CustomizationFiles -Directory 'Types' -Module $Module
# foreach ($file in $CustomeTypes) {
# 	$cmds = & $file
# 	$data = '';
# 	write-host("-----------------------------" +  $file)
# 	write-host("-----------------------------" +  $file -eq "*ModelEntraNewType.ps1")
# 	if ($file -like "*ModelEntraNewType.ps1") {
# 		write-host("-----------------------------" + $(Get-Content -Path $file))

# 		$data += $(Get-Content -Path $file) -join "`n"
# 	}
	
# 	$mapper.WriteTypeModuleFile($data,"Types")
# }

# hidden WriteModuleFile() {       
# 	$filePath = Join-Path $this.OutputFolder "$($this.ModuleName).psm1"
# 	#This call create the mapping used to create the final module.
# 	$data = $this.Map()

# 	$psm1FileContent = $this.GetFileHeader()
# 	foreach($cmd in $data.Commands) {
# 		$psm1FileContent += $cmd.CommandBlock
# 	}

# 	$psm1FileContent += $this.GetUnsupportedCommand()

# 	$psm1FileContent += $this.GetAlisesFunction()    

# 	# foreach($function in $this.missingCmdFromURLMap.GetEnumerator()){
# 	#     $psm1FileContent += $this.NewFunctionURLMap11($function,$this.ModuleUrlsMapping)
# 	# }

	
# 	foreach($function in $this.HelperCmdletsToExport.GetEnumerator()){
# 		$psm1FileContent += $function.Value
# 	}
# 	$psm1FileContent += $this.GetExportMemeber()        
# 	$psm1FileContent += $this.SetMissingCommands()
# 	$psm1FileContent += $this.LoadMessage
# 	$psm1FileContent += $this.GetTypesDefinitions()
# 	$psm1FileContent | Out-File -FilePath $filePath
# }

$mapper.BuildModule()