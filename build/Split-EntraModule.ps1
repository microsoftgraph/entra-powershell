. ..\src\EntraModuleSplitter.ps1
. ..\src\EntraModuleBuilder.ps1

# Split the module and take into account the AzureADAliases as well
$entraModuleSplitter = [EntraModuleSplitter]::new()
$entraModuleSplitter.SplitEntraModule('Entra')  # or 'EntraBeta'
$entraModuleSplitter.ProcessEntraAzureADAliases('Entra')

#Build the .psm1 file, 
#TODO: Generate help-xml
#TODO: Generate the .psd1
$moduleBuilder = [EntraModuleBuilder]::new()
$moduleBuilder.CreateSubModuleFile("..\module\Entra\Microsoft.Graph.Entra\", ".\Typedefs.txt")