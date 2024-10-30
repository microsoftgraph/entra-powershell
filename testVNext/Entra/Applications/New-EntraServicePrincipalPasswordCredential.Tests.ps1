# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Applications) -eq $null){
        Import-Module Microsoft.Graph.Entra.Applications    
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\build\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Add-MgServicePrincipalPassword with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "CustomKeyIdentifier"              = $null
              "DisplayName"                      = $null
              "EndDateTime"                      = "16/12/2024 13:14:14"
              "Hint"                             = "YWE"
              "KeyId"                            = "aaaaaaaa-0b0b-1c1c-2d2d-333333333333"
              "SecretText"                       = "Aa1Bb2Cc3.-Dd4Ee5Ff6Gg7Hh8Ii9_~Jj0Kk1Ll2"
              "StartDateTime"                    = "16/09/2024 14:14:14"
        
            }
        )
    }

    Mock -CommandName Add-MgServicePrincipalPassword -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Applications
}

Describe "New-EntraServicePrincipalPasswordCredential"{
    Context "Test for New-EntraServicePrincipalPasswordCredential" {
        It "Should return created password credential for a service principal."{
            $result =  New-EntraServicePrincipalPasswordCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -StartDate  "2024-09-16T14:14:14Z" -EndDate "2024-12-16T13:14:14Z"
            $result | Should -Not -Be NullOrEmpty
            $result.StartDate | should -Be "16/09/2024 14:14:14"
            $result.EndDate | should -Be "16/12/2024 13:14:14"

            Should -Invoke -CommandName Add-MgServicePrincipalPassword -ModuleName Microsoft.Graph.Entra.Applications -Times 1
        }
        It "Should update the parameter with Alias" {
            $result =  New-EntraServicePrincipalPasswordCredential -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc" -StartDate  "2024-09-16T14:14:14Z" -EndDate "2024-12-16T13:14:14Z"
            $result | Should -Not -Be NullOrEmpty

            Should -Invoke -CommandName Add-MgServicePrincipalPassword -ModuleName Microsoft.Graph.Entra.Applications -Times 1
        }
        It "Should fail when ServicePrincipalId is empty" {
            {New-EntraServicePrincipalPasswordCredential -ServicePrincipalId  } | Should -Throw "Missing an argument for parameter 'ServicePrincipalId'.*"
        }
        It "Should fail when ServicePrincipalId is Invalid" {
            { New-EntraServicePrincipalPasswordCredential -ServicePrincipalId "" } | Should -Throw "Cannot bind argument to parameter 'ServicePrincipalId' because it is an empty string.*"
        }
        It "Should fail when StartDate is empty" {
            { New-EntraServicePrincipalPasswordCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -StartDate   } | Should -Throw "Missing an argument for parameter 'StartDate'.*"
        }
        It "Should fail when StartDate is invalid" {
            { New-EntraServicePrincipalPasswordCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -StartDate "xyz"  } | Should -Throw "Cannot process argument transformation on parameter 'StartDate'. Cannot convert value*"
        }
        It "Should fail when EndDate is empty" {
            { New-EntraServicePrincipalPasswordCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -EndDate   } | Should -Throw "Missing an argument for parameter 'EndDate'.*"
        }
        It "Should fail when EndDate is invalid" {
            { New-EntraServicePrincipalPasswordCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -EndDate "xyz"  } | Should -Throw "Cannot process argument transformation on parameter 'EndDate'. Cannot convert value*"
        }
        It "Result should Contain StartDate and EndDate" {
            $result =  New-EntraServicePrincipalPasswordCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -StartDate  "2024-09-16T14:14:14Z" -EndDate "2024-12-16T13:14:14Z"
            $result.StartDate | should -Be "16/09/2024 14:14:14"
            $result.EndDate | should -Be "16/12/2024 13:14:14"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraServicePrincipalPasswordCredential"

            $result = New-EntraServicePrincipalPasswordCredential -ServicePrincipalId "bbbbbbbb-1111-2222-3333-cccccccccccc" -StartDate  "2024-09-16T14:14:14Z" -EndDate "2024-12-16T13:14:14Z"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraServicePrincipalPasswordCredential"

            Should -Invoke -CommandName Add-MgServicePrincipalPassword -ModuleName Microsoft.Graph.Entra.Applications -Times 1 -ParameterFilter {
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
                { New-EntraServicePrincipalPasswordCredential -ObjectID "bbbbbbbb-1111-2222-3333-cccccccccccc" -StartDate  "2024-09-16T14:14:14Z" -EndDate "2024-12-16T13:14:14Z" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        } 
    }
}
