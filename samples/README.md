# Sample

This sample script is written using only AzureAD. It creates some users, a group and adds the users as members. You can run the sample as follows: 

```PowerShell
Connect-Graph
Import-Module Microsoft.Graph.Entra
Set-EntraAzureADAliases
.\sampleGroups.ps1 -NumberOfUsers 2 -UserPrefix 'Test456_' -GroupName 'TestGroup456'
```
