BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    Mock -CommandName New-MgDeviceRegisteredOwnerByRef -MockWith {} -ModuleName Microsoft.Graph.Entra
}

Describe "Add-EntraDeviceRegisteredOwner" {
    Context "Test for Add-EntraDeviceRegisteredOwner" {
        It "Should return empty object" {
            $result = Add-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -RefObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
            $result | Should -BeNullOrEmpty

            Should -Invoke -CommandName New-MgDeviceRegisteredOwnerByRef -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectId is empty" {
            { Add-EntraDeviceRegisteredOwner -ObjectId  -RefObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"  } | Should -Throw "Missing an argument for parameter 'ObjectId'.*"
        }
        It "Should fail when ObjectId is invalid" {
            { Add-EntraDeviceRegisteredOwner -ObjectId "" -RefObjectId "996d39aa-fdac-4d97-aa3d-c81fb47362ac"  } | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should fail when RefObjectId is empty" {
            { Add-EntraDeviceRegisteredOwner -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -RefObjectId   } | Should -Throw "Missing an argument for parameter 'RefObjectId'.*"
        }
        It "Should fail when RefObjectId is invalid" {
            { Add-EntraDeviceRegisteredOwner -ObjectId "468cf92a-f38b-44a1-8007-3ca3c1dcea99" -RefObjectId ""  } | Should -Throw "Cannot bind argument to parameter 'RefObjectId' because it is an empty string."
        }
        It "Should contain DeviceId in parameters when passed ObjectId to it" {
            Mock -CommandName New-MgDeviceRegisteredOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Add-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -RefObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
            $params = Get-Parameters -data $result
            $params.DeviceId | Should -Be "8542ebd1-3d49-4073-9dce-30f197c67755"
        }
        It "Should contain BodyParameter in parameters when passed RefObjectId to it" {
            Mock -CommandName New-MgDeviceRegisteredOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $result = Add-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -RefObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
             $value = @{
                "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/412be9d1-1460-4061-8eed-cca203fcb215"
            } | ConvertTo-Json -Depth 5
            $params= $result | Convertto-json -Depth 10 | Convertfrom-json 
            $additionalProperties = $params[-1].AdditionalProperties | ConvertTo-Json -Depth 5
            $additionalProperties | Should -Be $value
        }
        It "Should contain 'User-Agent' header" {
            Mock -CommandName New-MgDeviceRegisteredOwnerByRef -MockWith {$args} -ModuleName Microsoft.Graph.Entra

            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Add-EntraDeviceRegisteredOwner"
            $result = Add-EntraDeviceRegisteredOwner -ObjectId "8542ebd1-3d49-4073-9dce-30f197c67755" -RefObjectId "412be9d1-1460-4061-8eed-cca203fcb215"
            $params = Get-Parameters -data $result
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }

    }

}        