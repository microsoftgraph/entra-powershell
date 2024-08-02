BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgGroupOwnerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Add-EntraGroupOwner" {
    Context "Test for Add-EntraGroupOwner" {
        It "Should add an owner to a group" {
            $result = Add-EntraGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -RefObjectId "3015621f-bfb5-40ca-923d-8439ff7db286"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgGroupOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectId is empty" {
            { Add-EntraGroupOwner -ObjectId  -RefObjectId "3015621f-bfb5-40ca-923d-8439ff7db286"  } | Should -Throw "Missing an argument for parameter 'ObjectId'.*"
        }

        It "Should fail when ObjectId is invalid" {
            { Add-EntraGroupOwner -ObjectId "" -RefObjectId "3015621f-bfb5-40ca-923d-8439ff7db286"  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should fail when RefObjectId is empty" {
            { Add-EntraGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -RefObjectId   } | Should -Throw "Missing an argument for parameter 'RefObjectId'.*"
        }

        It "Should fail when RefObjectId is invalid" {
            { Add-EntraGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -RefObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }

        It "Should contain GroupId in parameters when passed ObjectId to it" {
            Mock -CommandName New-MgGroupOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Add-EntraGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -RefObjectId "3015621f-bfb5-40ca-923d-8439ff7db286"
            $params = Get-Parameters -data $result
            $params.GroupId | Should -Be "fe4619d9-9ce7-4141-a367-ec10f3fb8af4"
        }

        It "Should contain BodyParameter in parameters when passed RefObjectId to it" {
            Mock -CommandName New-MgGroupOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Add-EntraGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -RefObjectId "3015621f-bfb5-40ca-923d-8439ff7db286"
            $value = @{
                "@odata.id" = "https://graph.microsoft.com/beta/users/3015621f-bfb5-40ca-923d-8439ff7db286"
            } | ConvertTo-Json -Depth 5
            $params= $result | Convertto-json -Depth 10 | Convertfrom-json 
            $additionalProperties = $params[-1].AdditionalProperties | ConvertTo-Json -Depth 5
            $additionalProperties | Should -Be $value
        }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgGroupOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraGroupOwner"
            $result = Add-EntraGroupOwner -ObjectId "fe4619d9-9ce7-4141-a367-ec10f3fb8af4" -RefObjectId "3015621f-bfb5-40ca-923d-8439ff7db286"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}
