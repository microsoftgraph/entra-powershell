# Additional Functions

The module allows to create additional functions that will be included in the module along with the regular compatibility adapter commands, giving flexibility to create helper code for customers.

In order to add a functions just add the ps1 file into the folder for the functions using the same for the file and the function. The generation process will add the code to the main psm file.

Unit test will validate that the file name and the generated function are the same.

Example. You can check `Test-EntraScript` as a reference of a working function

```PowerShell
Import-Module Microsoft.Graph.Compatibility.AzureAD
Test-EntraScript ".\MyScript"
```
