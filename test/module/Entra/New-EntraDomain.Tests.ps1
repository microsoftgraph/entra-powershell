BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

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
              "AdditionalProperties"                = @{"@odata.context" = "https://graph.microsoft.com/v1.0/$metadata#domains/$entity"}
              "Parameters"                          = $args
            }
        )
    }     

    Mock -CommandName New-MgDomain -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra
}
  
Describe "New-EntraDomain" {
    Context "Test for New-EntraDomain" {
        It "Create a new Domain" {
            $result = New-EntraDomain -Name "lala.uk"
            $result.ObjectId | should -Be "lala.uk" 
            $result.Name | should -Be "lala.uk" 

            Should -Invoke -CommandName New-MgDomain -ModuleName Microsoft.Graph.Entra -Times 1
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

        It "Should fail when parameters are invalid" {
            { New-EntraDomain -Name HH -IsDefault FD -IsDefaultForCloudRedirections GH -SupportedServices HH } | Should -Throw "Cannot process argument transformation on parameter 'IsDefault'*"
        }      

        It "Should contain Id in parameters when passed Name to it" {
            $result = New-EntraDomain -Name "lala.uk"
            $params = Get-Parameters -data $result.Parameters
            $params.Id | Should -Match "lala.uk"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraDomain"
            
            $result = New-EntraDomain -Name "lala.uk"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        } 
    }
}