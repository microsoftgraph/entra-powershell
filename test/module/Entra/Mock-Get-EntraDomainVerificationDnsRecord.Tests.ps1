BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

$scriptblock = {
    # Write-Host "Mocking Get-EntraDomainVerificationDnsRecord with parameters: $($args | ConvertTo-Json -Depth 3)"
    return @(
        [PSCustomObject]@{
           "Id"                               = "aceff52c-06a5-447f-ac5f-256ad243cc5c" 
           "Label"                            = "test.mail.onmicrosoft.com"
           "IsOptional"                       = $False
           "RecordType"                       = "Txt"
           "SupportedService"                 = "Email"
           "Ttl"                              = "3600"
           "AdditionalProperties"             = @{
                                                   "@odata.type"  = "#microsoft.graph.domainDnsTxtRecord"
                                                   "text" = "MS=ms75528557"
                                                }
           "Parameters"                       = $args
          
        } 
    )

}
  
    Mock -CommandName Get-MgDomainVerificationDnsRecord -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}   

Describe "Get-EntraDomainServiceConfigurationRecord" {
    Context "Test for Get-EntraDomainServiceConfigurationRecord" {
        It "Should return specific domain confuguration record" {
            $result = Get-EntraDomainVerificationDnsRecord -Name "test.mail.onmicrosoft.com"
            Write-Host $result
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be 'aceff52c-06a5-447f-ac5f-256ad243cc5c'

            Should -Invoke -CommandName Get-MgDomainVerificationDnsRecord -ModuleName Microsoft.Graph.Entra -Times 1

        }   
        It "Should fail when Name is empty" {
            { Get-EntraDomainVerificationDnsRecord -Name "" } | Should -Throw "Cannot bind argument to parameter 'Name' because it is an empty string."
        }
        It "Result should Contain DnsRecordId" {            
            $result = Get-EntraDomainVerificationDnsRecord -Name "test.mail.onmicrosoft.com"
            $result.DnsRecordId | should -Be "aceff52c-06a5-447f-ac5f-256ad243cc5c" 

            Should -Invoke -CommandName Get-MgDomainVerificationDnsRecord -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Result should Contain ObjectId" {            
            $result = Get-EntraDomainVerificationDnsRecord -Name "test.mail.onmicrosoft.com"
            $result.ObjectId | should -Be "aceff52c-06a5-447f-ac5f-256ad243cc5c" 

            Should -Invoke -CommandName Get-MgDomainVerificationDnsRecord -ModuleName Microsoft.Graph.Entra -Times 1 
        }
        It "Should contain DomainId in parameters when passed Name to it" {
            $result = Get-EntraDomainVerificationDnsRecord -Name "test.mail.onmicrosoft.com"
            $params = Get-Parameters -data $result.Parameters
            $params.DomainId | Should -Be "test.mail.onmicrosoft.com"
        } 
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDomainVerificationDnsRecord"
            $result = Get-EntraDomainVerificationDnsRecord -Name "test.mail.onmicrosoft.com"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }    
}    