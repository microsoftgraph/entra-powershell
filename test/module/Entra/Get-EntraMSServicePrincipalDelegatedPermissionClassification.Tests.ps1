BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"              = "T2qU_E28O0GgkLLIYRPsTwE"
                "Classification" = "low"
                "PermissionId"     = "fc946a4f-bc4d-413b-a090-b2c86113ec4f"
                "PermissionName"     = "LicenseManager.AccessAsUser"
                "Parameters"      = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalDelegatedPermissionClassification -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraMSServicePrincipalDelegatedPermissionClassification" {
    Context "Test for Get-EntraMSServicePrincipalDelegatedPermissionClassification" {
        It "Should return specific ServicePrincipalDelegatedPermissionClassification" {
            $result = Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId 0008861a-d455-4671-bd24-ce9b3bfce288
            $result | Should -Not -BeNullOrEmpty
            Write-Host ($result | convertto-json) 
            $result.Id | should -Be "T2qU_E28O0GgkLLIYRPsTwE"

            Should -Invoke -CommandName Get-MgServicePrincipalDelegatedPermissionClassification -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ServicePrincipalId is invalid" {
            { Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "" } | Should -Throw "Cannot bind argument to parameter 'ServicePrincipalId' because it is an empty string.*"
        }
        It "Should fail when ServicePrincipalId is empty" {
            { Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'.*"
        }
        It "Should return specific ServicePrincipalDelegatedPermissionClassification when Id passed to it" {
            $result = Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId 0008861a-d455-4671-bd24-ce9b3bfce288 -Id T2qU_E28O0GgkLLIYRPsTwE
            $params = Get-Parameters -data $result.Parameters 
            $params.DelegatedPermissionClassificationId | should -Be "T2qU_E28O0GgkLLIYRPsTwE"
        } 
        It "Should fail when Id is invalid" {
            { Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId 0008861a-d455-4671-bd24-ce9b3bfce288 -Id "" } | Should -Throw "Cannot bind argument to parameter 'Id' because it is an empty string.*"
        }  
        It "Should fail when Id is empty" {
            { Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId 0008861a-d455-4671-bd24-ce9b3bfce288 -Id } | Should -Throw "Missing an argument for parameter 'Id'.*"
        } 
        It "Should return specific ServicePrincipalDelegatedPermissionClassification when applied filter to it" {
            $result = Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId 0008861a-d455-4671-bd24-ce9b3bfce288 -Filter "PermissionName eq 'LicenseManager.AccessAsUser'"
            $result.PermissionName | should -Be "LicenseManager.AccessAsUser"
            $result.ObjectId | should -Be "T2qU_E28O0GgkLLIYRPsTwE"
        }  
        It "Should fail when Filter is empty" {
            { Get-AzureADMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId 0008861a-d455-4671-bd24-ce9b3bfce288 -Filter } | Should -Throw "Missing an argument for parameter 'Filter'.*"
        }   
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSServicePrincipalDelegatedPermissionClassification"

            $result = Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId 0008861a-d455-4671-bd24-ce9b3bfce288
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}