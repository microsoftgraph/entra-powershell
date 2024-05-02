BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
$scriptblock = @{
        value = @(
            @{
           "Id"                               = "996d39aa-fdac-4d97-aa3d-c81fb47362ac" 
           "OnPremisesSyncEnabled"            = $null
           "OnPremisesLastSyncDateTime"       = $null
           "mobilePhone"                      = "425-555-0101"
           "onPremisesProvisioningErrors"     = @{}
           "businessPhones"                   = @("425-555-0100")
            }
        )
    }
    
    Mock -CommandName Invoke-GraphRequest -MockWith  { $scriptblock }  -ModuleName Microsoft.Graph.Entra

}


Describe "EntraDirectoryRoleMember" {
    Context "Test for EntraDirectoryRoleMember" {
        It "Should return specific directory rolemember" {
            $result = (Get-EntraDirectoryRoleMember -ObjectId "1d73e796-aac5-4b3a-b7e7-74a3d1926a85") | ConvertTo-json | ConvertFrom-json
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be '996d39aa-fdac-4d97-aa3d-c81fb47362ac'

            Should -Invoke -CommandName Invoke-GraphRequest -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraDirectoryRoleMember -ObjectId } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectId is invalid" {
            { Get-EntraDirectoryRoleMember -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string.*"
        }
        It "Result should Contain Alias property" {
            $result = Get-EntraDirectoryRoleMember -ObjectId "1d73e796-aac5-4b3a-b7e7-74a3d1926a85"
            $result.ObjectId | should -Be "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $result.DirSyncEnabled | should -Be $null
            $result.LastDirSyncTime | should -Be $null
            $result.Mobile | should -Be "425-555-0101"
            $result.ProvisioningErrors | Should -BeNullOrEmpty
            $result.TelephoneNumber | should -Be "425-555-0100"
        }

    }

}    