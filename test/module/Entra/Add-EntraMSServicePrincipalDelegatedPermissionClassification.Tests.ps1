BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking New-MgServicePrincipalDelegatedPermissionClassification with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "Classification"                = "low"
              "Id"                            = "asMQ-fDWnkytQCxro4WHaQE"
              "PermissionId"                  = "f910c36a-d6f0-4c9e-ad40-2c6ba3858769"
              "PermissionName"                = "access_microsoftstream_embed"
              "ServicePrincipalId"            = "0b3b463d-6022-4b4e-9db5-65339061916f"
              "Parameters"                    = $args
            }
        )
    }

    Mock -CommandName New-MgServicePrincipalDelegatedPermissionClassification -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
Describe "Add-EntraMSServicePrincipalDelegatedPermissionClassification "{
    Context "Test for Add-EntraMSServicePrincipalDelegatedPermissionClassification" {
        It "Should Add a classification for a delegated permission."{
            $result = Add-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "0b3b463d-6022-4b4e-9db5-65339061916f" -PermissionId "f910c36a-d6f0-4c9e-ad40-2c6ba3858769" -Classification "low" -PermissionName "access_microsoftstream_embed"
            $result | Should -Not -BeNullOrEmpty
            $result.ServicePrincipalId | should -Be "0b3b463d-6022-4b4e-9db5-65339061916f"
            $result.PermissionId | should -Be "f910c36a-d6f0-4c9e-ad40-2c6ba3858769"
            $result.Classification | should -Be "low"
            $result.PermissionName | should -Be "access_microsoftstream_embed" 

            Should -Invoke -CommandName New-MgServicePrincipalDelegatedPermissionClassification -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All parameter is empty" {
            { Add-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId  -PermissionId  -Classification  -PermissionName  } | Should -Throw "Missing an argument for parameter*"
        }
        It "Should fail when All parameter is invalid" {
            { Add-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "" -PermissionId "" -Classification "" -PermissionName "" } | Should -Throw "Cannot bind argument to parameter*"
        }
        It "Result should Contain ObjectId" {
            $result = Add-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "0b3b463d-6022-4b4e-9db5-65339061916f" -PermissionId "f910c36a-d6f0-4c9e-ad40-2c6ba3858769" -Classification "low" -PermissionName "access_microsoftstream_embed"
            $result.ObjectId | should -Be "asMQ-fDWnkytQCxro4WHaQE"
        }   
        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgServicePrincipalDelegatedPermissionClassification -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraMSServicePrincipalDelegatedPermissionClassification"
            $result = Add-EntraMSServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "0b3b463d-6022-4b4e-9db5-65339061916f" -PermissionId "f910c36a-d6f0-4c9e-ad40-2c6ba3858769" -Classification "low" -PermissionName "access_microsoftstream_embed"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }   
    }
}