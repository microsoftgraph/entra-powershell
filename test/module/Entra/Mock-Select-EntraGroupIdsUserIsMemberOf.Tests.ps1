BeforeAll {  
    if ((Get-Module -Name Microsoft.Graph.Entra) -eq $null) {
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"               = "056b2531-005e-4f3e-be78-01a71ea30a04"
              "Parameters"       = $args
            }
        )
    }

    Mock -CommandName Get-MgUserMemberOfAsGroup -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Select-EntraGroupIdsUserIsMemberOf" {
    Context "Test for Select-EntraGroupIdsUserIsMemberOf" {
        It "Should return group membership id's" {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "056b2531-005e-4f3e-be78-01a71ea30a04"
            $userID = "996d39aa-fdac-4d97-aa3d-c81fb47362ac"
            $result = Select-entraGroupIdsUserIsMemberOf  -ObjectId $UserId -GroupIdsForMembershipCheck $Groups
            $result | Should -Not -BeNullOrEmpty      
            $result | Should -Be '056b2531-005e-4f3e-be78-01a71ea30a04'     

            Should -Invoke -CommandName Get-MgUserMemberOfAsGroup -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when UserID is invalid " {
            $Groups = New-Object Microsoft.Open.AzureAD.Model.GroupIdsForMembershipCheck
            $Groups.GroupIds = "69641f6c-41dc-4f63-9c21-cc9c8ed12931"
            $UserID = ""
            { Select-EntraGroupIdsUserIsMemberOf -ObjectId $UserID -GroupIdsForMembershipCheck $Groups } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

    }
}