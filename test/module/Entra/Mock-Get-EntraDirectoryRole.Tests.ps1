BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        #Import-Module .\bin\Microsoft.Graph.Entra.psm1 -Force
        Import-Module Microsoft.Graph.Entra
    }
    $scriptblock = {
        # Write-Host "Mocking Get-EntraDirectoryRole with parameters: $($args | ConvertTo-Json -Depth 3)"
        return @(
            [PSCustomObject]@{
              "DeletedDateTime"              = $null
              "Description" = "Read custom security attribute keys and values for supported Microsoft Entra objects."
              "DisplayName"                  = "Attribute Assignment Reader"
              "Id"                         = "dc587a80-d49c-4700-a73b-57227856fc32"
              "RoleTemplateId"    = "ffd52fa5-98dc-465c-991d-fc073eb59f8f"
              "Members"       = $null
              "ScopedMembers"               = $null
            }
        )
        }     
        Mock -CommandName Get-MgDirectoryRole -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra
  }
  
  Describe "Get-EntraDirectoryRole" {
    Context "Test for Get-EntraDirectoryRole" {
        It "Should return specific role" {
            $result = Get-EntraDirectoryRole -ObjectId "dc587a80-d49c-4700-a73b-57227856fc32"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | should -Be "dc587a80-d49c-4700-a73b-57227856fc32"

            Should -Invoke -CommandName Get-MgDirectoryRole  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Get-EntraDirectoryRole -ObjectId "" } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return specific role by filter" {
            $result = Get-EntraDirectoryRole -Filter "DisplayName -eq 'Attribute Assignment Reader'"
            $result | Should -Not -BeNullOrEmpty
            $result.DisplayName | should -Be 'Attribute Assignment Reader'

            Should -Invoke -CommandName Get-MgDirectoryRole  -ModuleName Microsoft.Graph.Entra -Times 1
        }  
        It "Result should Contain ObjectId" {
            $result = Get-EntraDirectoryRole -ObjectId "dc587a80-d49c-4700-a73b-57227856fc32"
            $result.ObjectId | should -Be "dc587a80-d49c-4700-a73b-57227856fc32"
        }      
    }
  }