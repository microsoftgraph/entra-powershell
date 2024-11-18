
# [cmdletbinding()]
# param (
#     [string]$Module = "Entra"
# )

. "$psscriptroot/common-functions.ps1"

$moduleNames = Get-ModuleName

foreach($moduleName in $moduleNames){
    $modulePath = Join-Path (Get-ModuleBasePath) $moduleName
    $modulePsd1 = $modulePath + ".psd1"
    ($modulePsd1 | Get-AuthenticodeSignature).Status | Should -Be "Valid"
    
    if(($moduleName -eq 'Microsoft.Graph.Entra') -or ($moduleName -eq 'Microsoft.Graph.Entra.Beta')){
		continue
	}
    $modulePsm1 = $modulePath + ".psm1"
    ($modulePsm1 | Get-AuthenticodeSignature).Status | Should -Be "Valid"    
}