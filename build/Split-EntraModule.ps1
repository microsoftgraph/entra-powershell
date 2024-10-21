. ..\src\EntraModuleSplitter.ps1
. ..\src\EntraModuleBuilder.ps1

$entraModuleSplitter = [EntraModuleSplitter]::new()
$entraModuleSplitter.SplitEntraModule('Entra')  # or 'EntraBeta'
$entraModuleSplitter.ProcessEntraAzureADAliases('Entra')
$moduleBuilder = [EntraModuleBuilder]::new()
$moduleBuilder.CreateSubModuleFile("..\module\Entra\Microsoft.Graph.Entra\", ".\Typedefs.txt")