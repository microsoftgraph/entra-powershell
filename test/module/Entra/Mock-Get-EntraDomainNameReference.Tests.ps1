BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
$scriptblock = @{
        value = @(
            @{
           "Id"                               = "996d39aa-fdac-4d97-aa3d-c81fb47362ac" 
           "onPremisesImmutableId"            = $null
           "deletedDateTime"                  = $null
           "onPremisesSyncEnabled"            = $null
           "mobilePhone"                      = "425-555-0101"
           "onPremisesProvisioningErrors"     = @{}
           "businessPhones"                   = @("425-555-0100")
           "externalUserState"                = $null
           "externalUserStateChangeDate"      = $null
           "Parameters"                       = $args
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith { $scriptblock } -ModuleName Microsoft.Graph.Entra

}


Describe "Get-EntraDomainNameReference" {
    Context "Test for Get-EntraDomainNameReference" {
        It "Should return specific domain Name Reference" {
            $result = Get-EntraDomainNameReference -Name "M365x99297270.mail.onmicrosoft.com"
            Write-Host $result
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '996d39aa-fdac-4d97-aa3d-c81fb47362ac'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Name is empty" {
            { Get-EntraDomainNameReference -Name  } | Should -Throw "Missing an argument for parameter 'Name'*"
        }
        It "Should fail when Name is invalid" {
            { Get-EntraDomainNameReference -Name "" } | Should -Throw "Cannot bind argument to parameter 'Name' because it is an empty string.*"
        }
        It "Result should Contain Alias property" {
            $result = Get-EntraDomainNameReference -Name "M365x99297270.mail.onmicrosoft.com"
            $result.ObjectId | should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $result.DeletionTimestamp | should -Be $null
            $result.DirSyncEnabled | should -Be $null
            $result.ImmutableId | should -Be $null
            $result.Mobile | should -Be "425-555-0101"
            $result.ProvisioningErrors | Should -BeNullOrEmpty
            $result.TelephoneNumber | should -Be "425-555-0100"
            $result.UserState | should -Be $null
            $result.UserStateChangedOn | should -Be $null

        }
        # It "Should contain DomainId in parameters when passe Name to it" {

        #     $result = Get-EntraDomainNameReference -Name "M365x99297270.mail.onmicrosoft.com"
        #     Write-host $result.Parameters
            # $params = Get-Parameters -data $result.Parameters
            # Write-host $params
            # $params.DomainId | Should -Be "M365x99297270.mail.onmicrosoft.com"
        # }
        # It "Should contain 'User-Agent' header" {

        #     $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDomainNameReference"

        #     $result = Get-EntraDomainNameReference -Name "M365x99297270.mail.onmicrosoft.com"
        #     $params = Get-Parameters -data $result.Parameters
        #     $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        # }  



    }

}    