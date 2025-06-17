# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.Applications) -eq $null){
        Import-Module Microsoft.Entra.Applications    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking New-MgServicePrincipalDelegatedPermissionClassification with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "Classification"                = "low"
              "Id"                            = "00001111-aaaa-2222-bbbb-3333cccc4444"
              "PermissionId"                  = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
              "PermissionName"                = "access_microsoftstream_embed"
              "ServicePrincipalId"            = "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
              "Parameters"                    = $args
            }
        )
    }

    Mock -CommandName New-MgServicePrincipalDelegatedPermissionClassification -MockWith $scriptblock -ModuleName Microsoft.Entra.Applications
    Mock -CommandName Get-EntraContext -MockWith { @{Scopes = @("Policy.ReadWrite.PermissionGrant") } } -ModuleName Microsoft.Entra.Applications
}
Describe "Add-EntraServicePrincipalDelegatedPermissionClassification"{
    Context "Test for Add-EntraServicePrincipalDelegatedPermissionClassification" {
        It "Should Add a classification for a delegated permission."{
            $result = Add-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PermissionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Classification "low" -PermissionName "access_microsoftstream_embed"
            $result | Should -Not -BeNullOrEmpty
            $result.ServicePrincipalId | should -Be "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
            $result.PermissionId | should -Be "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
            $result.Classification | should -Be "low"
            $result.PermissionName | should -Be "access_microsoftstream_embed" 

            Should -Invoke -CommandName New-MgServicePrincipalDelegatedPermissionClassification -ModuleName Microsoft.Entra.Applications -Times 1
        }
        It "Result should Contain ObjectId" {
            $result = Add-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PermissionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Classification "low" -PermissionName "access_microsoftstream_embed"
            $result.ObjectId | should -Be "00001111-aaaa-2222-bbbb-3333cccc4444"
        }   
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraServicePrincipalDelegatedPermissionClassification"

            $result = Add-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PermissionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Classification "low" -PermissionName "access_microsoftstream_embed"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraServicePrincipalDelegatedPermissionClassification"

            Should -Invoke -CommandName New-MgServicePrincipalDelegatedPermissionClassification -ModuleName Microsoft.Entra.Applications -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
        It "Should execute successfully without throwing an error " {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                { Add-EntraServicePrincipalDelegatedPermissionClassification -ServicePrincipalId "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" -PermissionId "00aa00aa-bb11-cc22-dd33-44ee44ee44ee" -Classification "low" -PermissionName "access_microsoftstream_embed" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

