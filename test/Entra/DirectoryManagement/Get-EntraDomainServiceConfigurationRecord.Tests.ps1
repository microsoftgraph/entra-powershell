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
           "Id"                               = "0000aaaa-11bb-cccc-dd22-eeeeee333333" 
           "Label"                            = "test.mail.onmicrosoft.com"
           "IsOptional"                       = $False
           "RecordType"                       = "Mx"
           "SupportedService"                 = "Email"
           "Ttl"                              = "3600"
           "AdditionalProperties"             = @{
                                                   "@odata.type"  = "#microsoft.graph.domainDnsMxRecord"
                                                   "mailExchange" = "test-mail-onmicrosoft-com.mail.protection.outlook.com"
                                                }
           "Parameters"                       = $args
          
        } 
    )

}
  
    Mock -CommandName Get-MgDomainServiceConfigurationRecord -MockWith $scriptblock -ModuleName Microsoft.Entra.DirectoryManagement

    Mock -CommandName Get-EntraContext -MockWith { @{
        Environment = @{ Name = "Global" }
        Scopes      = @('Domain.Read.All')
    }} -ModuleName Microsoft.Entra.DirectoryManagement
}   

Describe "Get-EntraDomainServiceConfigurationRecord" {
    Context "Test for Get-EntraDomainServiceConfigurationRecord" {
        It "Should throw when not connected and not invoke SDK call" {
            Mock -CommandName Get-EntraContext -MockWith { $null } -ModuleName Microsoft.Entra.DirectoryManagement
            { Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com" } | Should -Throw "Not connected to Microsoft Graph*"
            Should -Invoke -CommandName Get-MgDomainServiceConfigurationRecord -ModuleName Microsoft.Entra.DirectoryManagement -Times 0
        }

        It "Should return specific domain configuration record" {
            $result = Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '0000aaaa-11bb-cccc-dd22-eeeeee333333'

            Should -Invoke -CommandName Get-MgDomainServiceConfigurationRecord -ModuleName Microsoft.Entra.DirectoryManagement -Times 1

        }   
        It "Should fail when Name is empty" {
            { Get-EntraDomainServiceConfigurationRecord -Name  } | Should -Throw "Missing an argument for parameter 'Name'*"
        }
        It "Should fail when Name is invalid" {
            { Get-EntraDomainServiceConfigurationRecord -Name "" } | Should -Throw "Cannot bind argument to parameter 'Name' because it is an empty string."
        }
        It "Result should Contain DnsRecordId" {            
            $result = Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com"
            $result.DnsRecordId | should -Be "0000aaaa-11bb-cccc-dd22-eeeeee333333" 

            Should -Invoke -CommandName Get-MgDomainServiceConfigurationRecord -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Result should Contain ObjectId" {            
            $result = Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com"
            $result.ObjectId | should -Be "0000aaaa-11bb-cccc-dd22-eeeeee333333" 

            Should -Invoke -CommandName Get-MgDomainServiceConfigurationRecord -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 
        }
        It "Should contain DomainId in parameters when passed Name to it" {
            $result = Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com"
            $params = Get-Parameters -data $result.Parameters
            $params.DomainId | Should -Be "test.mail.onmicrosoft.com"
        }
        It "Property parameter should work" {
            $result = Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com" -Property RecordType
            $result | Should -Not -BeNullOrEmpty
            $result.RecordType | Should -Be 'Mx'

            Should -Invoke -CommandName Get-MgDomainServiceConfigurationRecord -ModuleName Microsoft.Entra.DirectoryManagement -Times 1
        }
        It "Should fail when Property is empty" {
             {Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com" -Property } | Should -Throw "Missing an argument for parameter 'Property'*"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDomainServiceConfigurationRecord"

            Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com"
            
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDomainServiceConfigurationRecord"

            Should -Invoke -CommandName Get-MgDomainServiceConfigurationRecord -ModuleName Microsoft.Entra.DirectoryManagement -Times 1 -ParameterFilter {
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
                {Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com" -Debug } | Should -Not -Throw
            } finally {
                # Restore original confirmation preference            
                $DebugPreference = $originalDebugPreference        
            }
        }
    }    
}    
