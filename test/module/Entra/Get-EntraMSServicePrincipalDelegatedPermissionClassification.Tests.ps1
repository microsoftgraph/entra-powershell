BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                   = "5XBeIKarUkypdm0tRsSAQwE"
                "Classification"       = "low"
                "PermissionId"         = "205e70e5-aba6-4c52-a976-6d2d46c48043"
                "PermissionName"       = "Sites.Read.All"
                "Parameters"           = $args
            }
        )
    }

    Mock -CommandName Get-MgServicePrincipalDelegatedPermissionClassification -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Get-EntraMSServicePrincipalDelegatedPermissionClassification"{
    It "Should fail when ServicePrincipalId is empty" {
        { Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "" } | Should -Throw "Cannot bind argument to parameter 'ServicePrincipalId' because it is an empty string."
    }
    It "Result should Contain ObjectId when ServicePrincipalId is passed" {
        $result = Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "fd560167-ff1f-471a-8d74-3b0070abcea1"
        $result.ObjectId | should -Be "5XBeIKarUkypdm0tRsSAQwE"
    }
    It "Result should Contain ObjectId when Id is passed" {
        $result = Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Id "5XBeIKarUkypdm0tRsSAQwE"
        $result.ObjectId | should -Be "5XBeIKarUkypdm0tRsSAQwE"
    }
    It "Should return specific application by filter" {
        $result = Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Filter "PermissionName eq 'Sites.Read.All'"
        $result | Should -Not -BeNullOrEmpty
        $result.Id | should -Be '5XBeIKarUkypdm0tRsSAQwE'
        Should -Invoke -CommandName Get-MgServicePrincipalDelegatedPermissionClassification  -ModuleName Microsoft.Graph.Entra -Times 1
    }  
    It "Should contain DelegatedPermissionClassificationId in parameters when passed Id to it" {              
        $result = Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "fd560167-ff1f-471a-8d74-3b0070abcea1" -Id "5XBeIKarUkypdm0tRsSAQwE"
        $params = Get-Parameters -data $result.Parameters
        $params.DelegatedPermissionClassificationId | Should -Be "5XBeIKarUkypdm0tRsSAQwE"
    }
    It "Should contain 'User-Agent' header" {
        $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraMSServicePrincipalDelegatedPermissionClassification"
        $result = Get-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "fd560167-ff1f-471a-8d74-3b0070abcea1"
        $params = Get-Parameters -data $result.Parameters
        $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
    }
}