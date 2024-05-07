BeforeAll {
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $PSScriptRoot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @{
            value = @(
                @{
                    "Id"                               = "412be9d1-1460-4061-8eed-cca203fcb215"
                    "onPremisesImmutableId"            = $null
                    "deletedDateTime"                  = $null
                    "onPremisesSyncEnabled"            = $null
                    "OnPremisesLastSyncDateTime"       = $null
                    "onPremisesProvisioningErrors"     = @{}
                    "mobilePhone"                      = "425-555-0100"
                    "BusinessPhones"                   = @("425-555-0100")
                    "ExternalUserState"                = $null
                    "ExternalUserStateChangeDateTime"  = $null
                    "Parameters"                       = $args
                }
            )
        }
    }
    

    Mock -CommandName Invoke-GraphRequest -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}



Describe "Get-EntraDeviceRegisteredOwner" {
    Context "Test for Get-EntraDeviceRegisteredOwner" {
        It "Should return specific device registered owner" {
            $result = Get-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '412be9d1-1460-4061-8eed-cca203fcb215'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraDeviceRegisteredOwner -ObjectId   } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraDeviceRegisteredOwner -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        }
        It "Should return all device registered owner" {
            $result = Get-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -All $true
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '412be9d1-1460-4061-8eed-cca203fcb215'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -All  } | Should -Throw "Missing an argument for parameter 'All'*"
        }
        It "Should fail when All is invalid" {
            { Get-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -All xyz } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }
        It "Should return top device registered owner" {
            $result = Get-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '412be9d1-1460-4061-8eed-cca203fcb215'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when top is empty" {
            { Get-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -Top  } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when top is invalid" {
            { Get-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Result should Contain Alias property" {
            $result = Get-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755"
            $result.ObjectId | should -Be "412be9d1-1460-4061-8eed-cca203fcb215"
            $result.DeletionTimestamp | should -Be $null
            $result.DirSyncEnabled | should -Be $null
            $result.ImmutableId | should -Be $null
            $result.LastDirSyncTime | should -Be $null
            $result.Mobile | should -Be "425-555-0100"
            $result.ProvisioningErrors | Should -BeNullOrEmpty
            $result.TelephoneNumber | should -Be "425-555-0100"
            $result.UserState | should -Be $null
            $result.UserStateChangedOn | should -Be $null

        }
        It "Should contain DeviceId in parameters when passed Name to it" { 

            $result = Get-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755"
            $params = Get-Parameters -data $result.Parameters
            $a= $params | ConvertTo-json | ConvertFrom-Json
            $params.URI  | Should -Match "8542ebd1-3d49-4073-9dce-30f197c67755"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraDeviceRegisteredOwner"

            $result = Get-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755"
            $params = Get-Parameters -data $result.Parameters
            $a= $params | ConvertTo-json | ConvertFrom-Json
            $a.headers.'User-Agent' | Should -Be $userAgentHeaderValue
        }


    }

}