BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"               = "140036f7-33f9-4f06-bdd6-39de8fe65d81"
              "Parameters"       = $args
            }
        )
    }  

    Mock -CommandName Get-MgServicePrincipalMemberOf -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Select-EntraGroupIdsServicePrincipalIsMemberOf" {
    Context "Test for Select-EntraGroupIdsServicePrincipalIsMemberOf" {
        It "Should Selects the groups in which a service principal is a member." {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = @("140036f7-33f9-4f06-bdd6-39de8fe65d81","ac200d11-ddc8-412a-b292-679849b6a8f0","f6a621be-fe31-480e-8cf5-c9e5bdf94aeb")
            $SPId = "2be1f4b2-1d16-4e85-a892-268eb4164e79"
            $result = Select-EntraGroupIdsServicePrincipalIsMemberOf -ObjectId $SPId -GroupIdsForMembershipCheck $Groups
            $result | Should -Not -BeNullOrEmpty
            write-host  $result
            Should -Invoke -CommandName Get-MgServicePrincipalMemberOf -ModuleName Microsoft.Graph.Entra -Times 1
        }    
        It "Should fail when ObjectID parameter is empty" {
            { Select-EntraGroupIdsServicePrincipalIsMemberOf -ObjectId  -GroupIdsForMembershipCheck "140036f7-33f9-4f06-bdd6-39de8fe65d81" } | Should -Throw "Missing an argument for parameter*"
        }
        It "Should fail when ObjectID parameter is invalid" {
            { Select-EntraGroupIdsServicePrincipalIsMemberOf -ObjectId "" -GroupIdsForMembershipCheck "140036f7-33f9-4f06-bdd6-39de8fe65d81" } | Should -Throw "Cannot bind argument to parameter*"
        }  
        It "Should fail when GroupIdsForMembershipCheck parameter is empty" {
            {$result = Select-EntraGroupIdsServicePrincipalIsMemberOf -ObjectId $SPId -GroupIdsForMembershipCheck  } | Should -Throw "Missing an argument for parameter 'GroupIdsForMembershipCheck'.*"
        }
        It "Should fail when GroupIdsForMembershipCheck parameter is invalid" {
            {$result = Select-EntraGroupIdsServicePrincipalIsMemberOf -ObjectId "2be1f4b2-1d16-4e85-a892-268eb4164e79" -GroupIdsForMembershipCheck "" } | Should -Throw "Cannot process argument transformation on parameter 'GroupIdsForMembershipCheck'*"
        }  

    }
}