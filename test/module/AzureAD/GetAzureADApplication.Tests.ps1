# Test cases for Get-EntraApplication
Describe "Get-EntraApplication" {
  BeforeAll {
    Import-Module -Name Microsoft.Graph.Applications -Force

    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module ..\..\..\bin\Microsoft.Graph.Entra.psm1 -Force
    }
  }
  Context "Test for Get-EntraApplication" {

      It "Should return all application" {
      # Mock the Get-MgApplication cmdlet for this specific test case
        $scriptblock = {
        # Your mock implementation here
        param($params)
        Write-Host "Mocking Get-MgApplication with parameters: $($params | ConvertTo-Json -Depth 3)"

        return @(
            [PSCustomObject]@{
                "CreatedDateTime" = "/Date(1699611758000)/"
                "CreatedOnBehalfOf" = @{
                    "DeletedDateTime" = $null
                    "Id" = $null
                }
                "DisplayName" = "test app"
                "Id" = "010cc9b5-fce9-485e-9566-c68debafac5f"
            }
        )
      }     

        $null = Mock -CommandName Get-MgApplication -MockWith $scriptBlock -ModuleName Microsoft.Graph.Entra -Verifiable

          $result = Get-EntraApplication -All $true
          $result | Should -Not -BeNullOrEmpty
          $result.Count | Should -Be 1

          # Add assertions based on your expected behavior
          $result | Should -Not -BeNullOrEmpty

          # Verify that the mock was invoked with the correct parameters
          Assert-MockCalled -CommandName Get-MgApplication -Exactly 1 -Scope It -Verifiable
      }
  }
}
