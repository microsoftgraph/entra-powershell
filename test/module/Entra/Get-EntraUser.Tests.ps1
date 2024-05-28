BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        $valueObject = [PSCustomObject]@{
            "DisplayName"                      = "Mock-User"
            "AccountEnabled"                   = $true
            "Mail"                             = "User@aaabbbcccc.OnMicrosoft.com"
            "userPrincipalName"                = "User@aaabbbcccc.OnMicrosoft.com"
            "DeletedDateTime"                  = $null
            "CreatedDateTime"                  = $null
            "EmployeeId"                       = $null
            "Id"                               = "bbbbbbbb-1111-2222-3333-cccccccccccc"
            "Surname"                          = $null
            "MailNickName"                     = "User"
            "OnPremisesDistinguishedName"      = $null
            "OnPremisesSecurityIdentifier"     = $null
            "OnPremisesUserPrincipalName"      = $null
            "OnPremisesSyncEnabled"            = $false
            "onPremisesImmutableId"            = $null
            "OnPremisesLastSyncDateTime"       = $null
            "JobTitle"                         = $null
            "CompanyName"                      = $null
            "Department"                       = $null
            "Country"                          = $null
            "BusinessPhones"                   = @{}
            "OnPremisesProvisioningErrors"     = @{}
            "ImAddresses"                      = @{}
            "ExternalUserState"                = $null
            "ExternalUserStateChangeDateTime"  = $null
            "MobilePhone"                      = $null
        }

        # Response from an Invoke-GraphRequest is a hashtable with @odata.context and Value objects

        # Name                           Value
        # ----                           -----
        # @odata.context                 https://graph.microsoft.com/v1.0/$metadata#users
        # value                          {System.Collections.Hashtable, System.Collections.Hashtable, System.Collections.Hasht...

        $response = @{
            '@odata.context'        = 'Users()'
            Value                   = $valueObject
        }

        return @(
            $response
        )
    }

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Get-EntraUser" {
    Context "Test for Get-EntraUser" {
        It "Should return specific user" {
            $result = Get-EntraUser -ObjectId "bbbbbbbb-1111-2222-3333-cccccccccccc"
            Write-Verbose "Result : {$result}" -Verbose
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be @('bbbbbbbb-1111-2222-3333-cccccccccccc')

            Should -Invoke -CommandName Invoke-GraphRequest  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUser"

            $result = Get-EntraUser -Top 1
            $result | Should -Not -BeNullOrEmpty

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUser"

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1 -ParameterFilter {
                $Headers.'User-Agent' | Should -Be $userAgentHeaderValue
                $true
            }
        }
    }
}