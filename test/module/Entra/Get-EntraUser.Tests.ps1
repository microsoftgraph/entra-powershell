BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        # Write-Host "Mocking Get-MgDevice with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
                "DisplayName"                   = "Mock-User"
                "AccountEnabled"                = $true
                "Mail"                          = "User@aaabbbcccc.OnMicrosoft.com"
                "userPrincipalName"             = "User@aaabbbcccc.OnMicrosoft.com"      
                "DeletedDateTime"               = $null
                "CreatedDateTime"               = $null
                "EmployeeId"                    = $null
                "Id"                            = "bbbbbbbb-1111-2222-3333-cccccccccccc"
                "Surname"                       = $null
                "MailNickName"                  = "User"
                "onPremisesDistinguishedName"   = $null
                "onPremisesSecurityIdentifier"  = $null
                "onPremisesUserPrincipalName"   = $null
                "jobTitle"                      = $null
                "companyName"                   = $null
                "department"                    = $null           
                "country"                       = $null
                "businessPhones"                = @{}
                "onPremisesProvisioningErrors"  = @{}
                "ImAddresses"                   = @{}
            }
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraUser" {
    Context "Test for Get-EntraUser" {
        It "Should return specific user" {
            $result = Get-EntraUser -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('bbbbbbbb-1111-2222-3333-cccccccccccc')

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUser"

            $result = Get-EntraUser -SearchString 'Mock-User'
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}