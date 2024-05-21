BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra        
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force

    $scriptblock = {
        return @(
            [PSCustomObject]@{
                "Id"                           = "8542ebd1-3d49-4073-9dce-30f197c67755"
                "DeletedDateTime"              = $null
                "AdditionalProperties"         = @{
                                                      "@odata.type"            = "#microsoft.graph.device"
                                                      "accountEnabled"         = $true
                                                      "createdDateTime"        = "2024-01-18T08:50:28Z"
                                                      "deviceId"               = "6e9d44e6-f191-4957-bb31-c52f33817204"
                                                      "deviceMetadata"         = "MetaData"
                                                      "deviceVersion"          = "2"
                                                      "displayName"            = "AkshayLodha"
                                                      "isCompliant"            = $false
                                                      "isManaged"              = $true
                                                      "operatingSystem"        = "WINDOWS"
                                                      "operatingSystemVersion" = "10.0.22621.1700"
                                                      "physicalIds"            = @(
                                                                                    "[HWID]:h:6825786449406074"
                                                                                    "[USER-HWID]:7f08336b-29ed-4297-bb1f-60520d34577f:6825786449406074"
                                                                                    "[GID]:g:6966518641169130"
                                                                                  )
                                                      "systemLabels"           = @{}
                                                      "extensionAttributes"    = $null
                                                      "alternativeSecurityIds" = @(
                                                                                    @{
                                                                                        "type" = 2
                                                                                        "key"  = "dGVzdA=="
                                                                                    }
                                                                                  )
                                                   }
                "Parameters"                   = $args
            }
        )
    }    
    Mock -CommandName Get-MgUserOwnedDevice -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraUserOwnedDevice" {
Context "Test for Get-EntraUserOwnedDevice" {
        It "Should get devices owned by a user" {
            $result = Get-EntraUserOwnedDevice -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "8542ebd1-3d49-4073-9dce-30f197c67755"
            $result.AdditionalProperties.deviceId | Should -Be "6e9d44e6-f191-4957-bb31-c52f33817204"
            $result.AdditionalProperties.displayName | Should -Be "AkshayLodha"

            Should -Invoke -CommandName Get-MgUserOwnedDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when ObjectlId is empty" {
            { Get-EntraUserOwnedDevice -ObjectId    } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }

        It "Should fail when ObjectlId is invalid" {
            { Get-EntraUserOwnedDevice -ObjectId  ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }

        It "Should get all devices owned by a user" {
            $result = Get-EntraUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -All $true
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Contain "8542ebd1-3d49-4073-9dce-30f197c67755"

            Should -Invoke -CommandName Get-MgUserOwnedDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when All is empty" {
            { Get-EntraUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -All  } | Should -Throw "Missing an argument for parameter 'All'*"
        }

        It "Should fail when All is invalid" {
            { Get-EntraUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -All "XCX" } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }

        It "Should get top one device owned by a user" {
            $result = Get-EntraUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "8542ebd1-3d49-4073-9dce-30f197c67755"
            $result.AdditionalProperties.deviceId | Should -Be "6e9d44e6-f191-4957-bb31-c52f33817204"
            $result.AdditionalProperties.displayName | Should -Be "AkshayLodha"

            Should -Invoke -CommandName Get-MgUserOwnedDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }

        It "Should fail when Top is empty" {
            { Get-EntraUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }

        It "Should fail when Top is invalid" {
            { Get-EntraUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top "XCX" } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }

        It "Should contain UserId in parameters when passed ObjectId to it" {              
            $result = Get-EntraUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
        }

        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserOwnedDevice"

            $result = Get-EntraUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }
    }
}