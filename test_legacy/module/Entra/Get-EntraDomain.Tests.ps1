# ------------------------------------------------------------------------------
#  Copyright (c) Microsoft Corporation.  All Rights Reserved.  Licensed under the MIT License.  See License in the project root for license information.
# ------------------------------------------------------------------------------
BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

$scriptblock = {
    return @(
        [PSCustomObject]@{
           "Id"                               = "test.mail.onmicrosoft.com" 
           "State"                            = @{LastActionDateTime=""; Operation=""; Status=""; AdditionalProperties=""}
           "AuthenticationType"               = "Managed"
           "IsAdminManaged"                   = $True
           "IsDefault"                        = $False
           "IsInitial"                        = $False
           "IsRoot"                           = $False
           "IsVerified"                       = $False
           "Manufacturer"                     = $null
           "Model"                            = $null
           "PasswordNotificationWindowInDays" = $null
           "PasswordValidityPeriodInDays"     = $null
           "ServiceConfigurationRecords"      = $null
           "SupportedServices"                = {}
           "VerificationDnsRecords"           = $null
           "AdditionalProperties"             = {}
           "Parameters"                       = $args
          
        } 
    )

}
  
    Mock -CommandName Get-MgDomain -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}   

Describe "Get-EntraDomain" {
    Context "Test for Get-EntraDomain" {
        It "Should return specific domain" {
            $result = Get-EntraDomain -Name "test.mail.onmicrosoft.com"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'test.mail.onmicrosoft.com'

            Should -Invoke -CommandName Get-MgDomain -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Name is empty" {
            { Get-EntraDomain -Name "" } | Should -Throw "Cannot bind argument to parameter 'Name' because it is an empty string."
        }
        It "Result should Contain ObjectId" {            
            $result = Get-EntraDomain -Name "test.mail.onmicrosoft.com"
            $result.ObjectId | should -Be "test.mail.onmicrosoft.com" 

            Should -Invoke -CommandName Get-MgDomain -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Result should Contain Name" {            
            $result = Get-EntraDomain -Name "test.mail.onmicrosoft.com"
            $result.Name | should -Be "test.mail.onmicrosoft.com" 

            Should -Invoke -CommandName Get-MgDomain -ModuleName Microsoft.Graph.Entra -Times 1 
        }
        It "Should contain DomainId in parameters when passed Name to it" {
            $result = Get-EntraDomain -Name "test.mail.onmicrosoft.com"
            $params = Get-Parameters -data $result.Parameters
            $params.DomainId | Should -Be "test.mail.onmicrosoft.com"
        }
        It "Property parameter should work" {
            $result = Get-EntraDomain -Name "test.mail.onmicrosoft.com" -Property AuthenticationType
            $result | Should -Not -BeNullOrEmpty
            $result.AuthenticationType | Should -Be 'Managed'

            Should -Invoke -CommandName Get-MgDomain -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Property is empty" {
             {Get-EntraDomain -Name "test.mail.onmicrosoft.com" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDomain"

            Get-EntraDomain -Name "test.mail.onmicrosoft.com"
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDomain"

            Should -Invoke -CommandName Get-MgDomain -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
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
                {Get-EntraDomain -Name "test.mail.onmicrosoft.com" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }
}