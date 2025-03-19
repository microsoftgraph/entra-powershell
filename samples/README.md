# Sample

This sample script is written using only AzureAD. It creates some users, a group and adds the users as members. You can run the sample as follows: 

```PowerShell
Connect-Entra
Import-Module Microsoft.Entra.Users
Import-Module Microsoft.Entra.Groups
Enable-EntraAzureADAlias
.\sampleGroups.ps1 -NumberOfUsers 2 -UserPrefix 'Test456_' -GroupName 'TestGroup456'
```
