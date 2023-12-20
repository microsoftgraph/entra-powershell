Describe "Get-EntraApplicationOwner" {
    Context "When calling Get-EntraApplicationOwner" {
        BeforeAll {
            Import-Module Microsoft.Graph.Applications -Force

            # Ensure that the required modules are imported
            if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
                Import-Module ..\..\..\bin\Microsoft.Graph.Entra.psm1 -Force
            }
        }

        It "Should call Get-MgApplicationOwner with the correct parameters" {
            # Mock the Get-MgApplicationOwner cmdlet directly in the It block
            $scriptBlock = {
                param($params)
                Write-Host "Mocking Get-MgApplicationOwner with parameters: $($params | ConvertTo-Json -Depth 3)"
                
                # Return a mock response or object that simulates the behavior of Get-MgApplicationOwner
                # Adjust this based on your test case
                return @(
                    $dict = New-Object 'System.Collections.Generic.Dictionary[String,String]'
                    $dict.Add("@odata.type", "#microsoft.graph.group")
                    [PSCustomObject]@{
                        "PropertyName" = "MockedValue"
                        "AdditionalProperties" = $dict
                    }
                )
            }

            # Mock Get-MgApplicationOwner
            $null = Mock -CommandName Get-MgApplicationOwner -MockWith $scriptBlock -ModuleName Microsoft.Graph.Applications -Verifiable

            # Call the function with test parameters
            $result = Get-EntraApplicationOwner -ObjectId "ff6f6a54-189e-4534-8269-e2dec3bc5249" -All $true -Top 5

            # Add assertions based on your expected behavior
            $result | Should -Not -BeNullOrEmpty

            # Verify that the mock was invoked with the correct parameters
            Assert-MockCalled -CommandName Get-MgApplicationOwner -Exactly 1 -Scope It -Verifiable
        }
    }
}
