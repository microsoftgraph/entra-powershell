BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

$scriptblock = {
    return @(
        [PSCustomObject]@{
           "Id"                               = "2b672ab0-0bee-476f-b334-be436f2449bd" 
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
  
    Mock -CommandName Get-MgDomainServiceConfigurationRecord -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}   

Describe "Get-EntraDomainServiceConfigurationRecord" {
    Context "Test for Get-EntraDomainServiceConfigurationRecord" {
        It "Should return specific domain confuguration record" {
            $result = Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '2b672ab0-0bee-476f-b334-be436f2449bd'

            Should -Invoke -CommandName Get-MgDomainServiceConfigurationRecord -ModuleName Microsoft.Graph.Entra -Times 1

        }   
        It "Should fail when Name is empty" {
            { Get-EntraDomainServiceConfigurationRecord -Name "" } | Should -Throw "Cannot bind argument to parameter 'Name' because it is an empty string."
        }
        It "Result should Contain DnsRecordId" {            
            $result = Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com"
            $result.DnsRecordId | should -Be "2b672ab0-0bee-476f-b334-be436f2449bd" 

            Should -Invoke -CommandName Get-MgDomainServiceConfigurationRecord -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Result should Contain ObjectId" {            
            $result = Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com"
            $result.ObjectId | should -Be "2b672ab0-0bee-476f-b334-be436f2449bd" 

            Should -Invoke -CommandName Get-MgDomainServiceConfigurationRecord -ModuleName Microsoft.Graph.Entra -Times 1 
        }
        It "Should contain DomainId in parameters when passed Name to it" {
            $result = Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com"
            $params = Get-Parameters -data $result.Parameters
            $params.DomainId | Should -Be "test.mail.onmicrosoft.com"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDomainServiceConfigurationRecord"
            $result = Get-EntraDomainServiceConfigurationRecord -Name "test.mail.onmicrosoft.com"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 

    }    
}    