BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"              = "microsoft-all-application-permissions"
                "DeletedDateTime" = "2/8/2024 6:39:16 AM"
                "Description"     = "Includes all application permissions (app roles), for all APIs, for any client application."
                "DisplayName"     = "All application permissions, for any client app"
                "Excludes"        = @{}
                "Includes"        = @("bddda1ec-0174-44d5-84e2-47fb0ac01595")
                "Parameters"      = $args
            }
        )
    }

    Mock -CommandName Get-MgPolicyPermissionGrantPolicy -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraMSPermissionGrantPolicy" {
    Context "Test for Get-EntraMSPermissionGrantPolicy" {
        It "Should return specific PermissionGrantPolicy" {
            $result = Get-EntraMSPermissionGrantPolicy -Id "microsoft-all-application-permissions"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "microsoft-all-application-permissions"

            Should -Invoke -CommandName Get-MgPolicyPermissionGrantPolicy  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Id is empty" {
            { Get-EntraMSPermissionGrantPolicy -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string."
        }
        It "Should fail when Id is empty" {
            { Get-EntraMSPermissionGrantPolicy -Id } | Should -Throw "Missing an argument for parameter 'Id'. Specify a parameter of type 'System.String' and try again."
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraMSPermissionGrantPolicy -Id "microsoft-all-application-permissions"
            $result.ObjectId | should -Be "microsoft-all-application-permissions"
        }     
        It "Should contain PermissionGrantPolicyId in parameters when passed ObjectId to it" {              
            $result = Get-EntraMSPermissionGrantPolicy -Id "microsoft-all-application-permissions"
            $params = Get-Parameters -data $result.Parameters
            $params.PermissionGrantPolicyId | Should -Be "microsoft-all-application-permissions"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSPermissionGrantPolicy"

            $result = Get-EntraMSPermissionGrantPolicy -Id "microsoft-all-application-permissions"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}