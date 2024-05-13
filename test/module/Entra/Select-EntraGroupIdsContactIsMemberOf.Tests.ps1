BeforeAll {
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"               = "69641f6c-41dc-4f63-9c21-cc9c8ed12931"
              "Parameters"       = $args
            }
        )
    }  

    Mock -CommandName Get-MgContactMemberOfAsGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}
  
Describe "Select-EntraGroupIdsContactIsMemberOf" {
    Context "Test for Select-EntraGroupIdsContactIsMemberOf" {
        It "Should return specific Contact Membership" {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "69641f6c-41dc-4f63-9c21-cc9c8ed12931"
            $UserID = "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
            $result = Select-EntraGroupIdsContactIsMemberOf -ObjectId $UserID -GroupIdsForMembershipCheck $Groups
            $result | Should -Not -BeNullOrEmpty
            $result | Should -Be '69641f6c-41dc-4f63-9c21-cc9c8ed12931' 
            
            Should -Invoke -CommandName Get-MgContactMemberOfAsGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when UserID is missing" {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "69641f6c-41dc-4f63-9c21-cc9c8ed12931"
            { Select-EntraGroupIdsContactIsMemberOf -ObjectId  -GroupIdsForMembershipCheck $Groups } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when UserID is empty" {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "69641f6c-41dc-4f63-9c21-cc9c8ed12931"
            { Select-EntraGroupIdsContactIsMemberOf -ObjectId "" -GroupIdsForMembershipCheck $Groups } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when GroupID is empty" {
            $UserID = "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
            { Select-EntraGroupIdsContactIsMemberOf -ObjectId $UserID  -GroupIdsForMembershipCheck  } | Should -Throw "Missing an argument for parameter 'GroupIdsForMembershipCheck'*"
        }

        It "Should fail when GroupID is invalid" {
            $UserID = "cb4e4d7f-3cd6-43f2-8d37-b23b04b6417c"
            { Select-EntraGroupIdsContactIsMemberOf -ObjectId $UserID -GroupIdsForMembershipCheck "ZZZ" } | Should -Throw "Cannot process argument transformation on parameter 'GroupIdsForMembershipCheck'.*"
        }
    }
}
