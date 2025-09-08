# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Entra.DirectoryManagement) -eq $null){
        Import-Module Microsoft.Entra.DirectoryManagement
    }
    Import-Module (Join-Path $PSScriptRoot "..\..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "AvailabilityStatus"                  = $null
              "IsAdminManaged"                      = "True"
              "IsDefault"                           = "False"
              "IsInitial"                           = "False"
              "IsRoot"                              = "False"
              "IsVerified"                          = "False"
              "Id"                                  = "lala.uk"
              "Manufacturer"                        = $null
              "Model"                               = $null
              "PasswordNotificationWindowInDays"    = $null
              "PasswordValidityPeriodInDays"        = $null
              "ServiceConfigurationRecords"         = $null
              "SupportedServices"                   = @("Email", "OfficeCommunicationsOnline")
              "AdditionalProperties"                = @{"@odata.context" = "https://graph.microsoft.com/v1.0/`$metadata#domains/`$entity"}
              "Parameters"                          = $args
            }
        )
    }     

    Mock -CommandName New-MgDomain -MockWith $scriptBlock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Domain.ReadWrite.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}
  
Describe "New-EntraDomain" {
    Context "Test for New-EntraDomain" {
        It "Create a new Domain" {
            $result = New-EntraDomain -Name "lala.uk"
            $result.ObjectId | should -Be "lala.uk" 
            $result.Name | should -Be "lala.uk" 

            Should -Invoke -CommandName New-MgDomain -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }

        It "Create a new Domain with a list of domain capabilities" {
            $result = New-EntraDomain -Name "lala.uk" -SupportedServices @("Email", "OfficeCommunicationsOnline")
            $result.ObjectId | should -Be "lala.uk" 
            $result.Name | should -Be "lala.uk" 
            $result.SupportedServices | should -Not -BeNullOrEmpty
        }

        It "Create a new Domain and make if the default new user creation" {
            $result = New-EntraDomain -Name "lala.uk" -IsDefault $false
            $result.IsDefault | should -Be "False" 
        }

        It "Should fail when parameters are empty" {
            { New-EntraDomain -Name -IsDefault -IsDefaultForCloudRedirections -SupportedServices} | Should -Throw "Missing an argument for parameter*"
        }      

        It "Should fail when Name parameters are invalid" {
            { New-EntraDomain -Name "" } | Should -Throw "Cannot bind argument to parameter 'Name' because it is an empty string."
        }      

        It "Should fail when IsDefault parameters are invalid" {
            { New-EntraDomain -Name "lala.uk" -IsDefault FD } | Should -Throw "Cannot process argument transformation on parameter 'IsDefault'*"
        }     

        It "Should fail when IsDefaultForCloudRedirections parameters are invalid" {
            { New-EntraDomain -Name "lala.uk" -IsDefaultForCloudRedirections GH } | Should -Throw "Cannot process argument transformation on parameter 'IsDefaultForCloudRedirections'*"
        }     

        It "Should fail when SupportedServices parameters are invalid" {
            { New-EntraDomain -Name "lala.uk" -SupportedServices $true } | Should -Throw "Cannot process argument transformation on parameter 'SupportedServices'*"
        }     

        It "Should contain Id in parameters when passed Name to it" {
            $result = New-EntraDomain -Name "lala.uk"
            $params = Get-Parameters -data $result.Parameters
            $params.Id | Should -Match "lala.uk"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraDomain"

            $result = New-EntraDomain -Name "lala.uk"
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraDomain"

            Should -Invoke -CommandName New-MgDomain -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        } 

        It "Should execute successfully without throwing an error" {
            # Disable confirmation prompts       
            $originalDebugPreference = $DebugPreference
            $DebugPreference = 'Continue'

            try {
                # Act & Assert: Ensure the function doesn't throw an exception
                {  New-EntraDomain -Name "lala.uk" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }   
    }
}

