BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgServicePrincipalOwnerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Add-EntraServicePrincipalOwner" {
    Context "Test for Add-EntraServicePrincipalOwner" {
        It "Should return empty object" {
            $result = Add-EntraServicePrincipalOwner -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -RefObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgServicePrincipalOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Add-EntraServicePrincipalOwner -ObjectId  -RefObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"  } | Should -Throw "Missing an argument for parameter 'ObjectId'.*"
        }
        It "Should fail when ObjectId is invalid" {
            { Add-EntraServicePrincipalOwner -ObjectId "" -RefObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"   } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when RefObjectId is empty" {
            { Add-EntraServicePrincipalOwner -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -RefObjectId   } | Should -Throw "Missing an argument for parameter 'RefObjectId'.*"
        }
        It "Should fail when RefObjectId is invalid" {
            { Add-EntraServicePrincipalOwner -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -RefObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }
        It "Should contain ServicePrincipalId in parameters when passed ObjectId to it" {
            Mock -CommandName New-MgServicePrincipalOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Add-EntraServicePrincipalOwner -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -RefObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result
            $params.ServicePrincipalId | Should -Be "0008861a-d455-4671-bd24-ce9b3bfce288"
        }
        It "Should contain BodyParameter in parameters when passed RefObjectId to it" {
                Mock -CommandName New-MgServicePrincipalOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra
    
                $result = Add-EntraServicePrincipalOwner -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -RefObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
                $value = @{"@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/fd560167-ff1f-471a-8d74-3b0070abcea1"}
                $params= $result | Convertto-json -Depth 10 | Convertfrom-json 
                $additionalProperties = $params[-1].AdditionalProperties
                $additionalProperties.'@odata.id' | Should -Be $value.'@odata.id'
            }

        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgServicePrincipalOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraServicePrincipalOwner"
            $result = Add-EntraServicePrincipalOwner -ObjectId "0008861a-d455-4671-bd24-ce9b3bfce288" -RefObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }

}  