BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra    
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Add-MgServicePrincipalPassword with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "CustomKeyIdentifier"              = $null
              "DisplayName"                      = $null
              "EndDateTime"                      = "16/12/2024 13:14:14"
              "Hint"                             = "YWE"
              "KeyId"                            = "7aa34377-276f-4ea7-a7cb-31c3711f794b"
              "SecretText"                       = "YWE8Q~~yRXoB42WwGVEP.5csr2gwD10DOPfJWc~o"
              "StartDateTime"                    = "16/09/2024 14:14:14"
        
            }
        )
    }

    Mock -CommandName Add-MgServicePrincipalPassword -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "New-EntraServicePrincipalPasswordCredential"{
    Context "Test for New-EntraServicePrincipalPasswordCredential" {
        It "Should return created password credential for a service principal."{
            $result =  New-EntraServicePrincipalPasswordCredential -ObjectID "50b6ee9c-563f-402f-9922-c0d7adc86bf0" -StartDate  "2024-09-16T14:14:14Z" -EndDate "2024-12-16T13:14:14Z"
            $result | Should -Not -Be NullOrEmpty
            $result.StartDate | should -Be "16/09/2024 14:14:14"
            $result.EndDate | should -Be "16/12/2024 13:14:14"

            Should -Invoke -CommandName Add-MgServicePrincipalPassword -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectID is empty" {
            {New-EntraServicePrincipalPasswordCredential -ObjectID  } | Should -Throw "Missing an argument for parameter 'ObjectID'.*"
        }
        It "Should fail when ObjectID is Invalid" {
            { New-EntraServicePrincipalPasswordCredential -ObjectID "" } | Should -Throw "Cannot bind argument to parameter 'ObjectID' because it is an empty string.*"
        }
        It "Should fail when StartDate is empty" {
            { New-EntraServicePrincipalPasswordCredential -ObjectID "50b6ee9c-563f-402f-9922-c0d7adc86bf0" -StartDate   } | Should -Throw "Missing an argument for parameter 'StartDate'.*"
        }
        It "Should fail when StartDate is invalid" {
            { New-EntraServicePrincipalPasswordCredential -ObjectID "50b6ee9c-563f-402f-9922-c0d7adc86bf0" -StartDate "xyz"  } | Should -Throw "Cannot process argument transformation on parameter 'StartDate'. Cannot convert value*"
        }
        It "Should fail when EndDate is empty" {
            { New-EntraServicePrincipalPasswordCredential -ObjectID "50b6ee9c-563f-402f-9922-c0d7adc86bf0" -EndDate   } | Should -Throw "Missing an argument for parameter 'EndDate'.*"
        }
        It "Should fail when EndDate is invalid" {
            { New-EntraServicePrincipalPasswordCredential -ObjectID "50b6ee9c-563f-402f-9922-c0d7adc86bf0" -EndDate "xyz"  } | Should -Throw "Cannot process argument transformation on parameter 'EndDate'. Cannot convert value*"
        }
        It "Result should Contain StartDate and EndDate" {
            $result =  New-EntraServicePrincipalPasswordCredential -ObjectID "50b6ee9c-563f-402f-9922-c0d7adc86bf0" -StartDate  "2024-09-16T14:14:14Z" -EndDate "2024-12-16T13:14:14Z"
            $result.StartDate | should -Be "16/09/2024 14:14:14"
            $result.EndDate | should -Be "16/12/2024 13:14:14"
        } 
        It "Should contain 'User-Agent' header" {
            Mock -CommandName Add-MgServicePrincipalPassword -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion New-EntraServicePrincipalPasswordCredential"
            $result = New-EntraServicePrincipalPasswordCredential -ObjectID "50b6ee9c-563f-402f-9922-c0d7adc86bf0" -StartDate  "2024-09-16T14:14:14Z" -EndDate "2024-12-16T13:14:14Z"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}