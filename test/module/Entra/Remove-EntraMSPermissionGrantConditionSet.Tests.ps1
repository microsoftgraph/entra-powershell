BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName Remove-MgPolicyPermissionGrantPolicyInclude -MockWith {} -ModuleName Microsoft.Graph.Entra

    Mock -CommandName Remove-MgPolicyPermissionGrantPolicyExclude -MockWith {} -ModuleName Microsoft.Graph.Entra
}