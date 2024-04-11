BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        # Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
         Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

$scriptblock = {
    # Write-Host "Mocking Get-MgApplication with parameters: $($args | ConvertTo-Json -Depth 3)"
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
          
        } 
    )

}
  
    Mock -CommandName Get-MgDomain -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}   

Describe "Get-EntraDomain" {
    Context "Test for Get-EntraDomain" {
        It "Should return specific domain" {
            $result = Get-EntraDomain -Name "test.mail.onmicrosoft.com"
            Write-Host $result
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
        # issue in addins DomainId param transformation in args, will uncomment after resolve.
        # It "Should contain DomainId in parameters when passed Name to it" {
        #     Mock -CommandName Get-MgDomain -MockWith {$args} -ModuleName Microsoft.Graph.Entra

        #     $result = Get-EntraDomain -Name "test.mail.onmicrosoft.com"
        #     $params = Get-Parameters -data $result
        #     $params.DomainId | Should -Be "test.mail.onmicrosoft.com"
        # }
        # It "Should contain 'User-Agent' header" {
        #     Mock -CommandName Get-MgDomain -MockWith {$args} -ModuleName Microsoft.Graph.Entra

        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDomain"

        #     $result = Get-EntraDomain -Name "test.mail.onmicrosoft.com"
        #     $params = Get-Parameters -data $result
        #     $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        # }

    }
}