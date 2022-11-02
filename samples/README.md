# Sample

This sample script is written using only AzureAD, it creates some users, one group and add the users as members of that group. You can run the sample as follows: 

```PowerShell
Connect-Graph
Import-Module Microsoft.Graph.Compatibility.AzureAD
Set-CompatADAlias
.\sampleGroups.ps1 -NumberOfUsers 2 -UserPrefix 'Test456_' -GroupName 'TestGroup456'
```
