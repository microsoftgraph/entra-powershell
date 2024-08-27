BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra) -eq $null){
        Import-Module Microsoft.Graph.Entra      
    }
    Import-Module (Join-Path $psscriptroot "..\Common-Functions.ps1") -Force
    
    $scriptblock = {
        return @(
            [PSCustomObject]@{
              "Id"                           = "74825acb-c984-4b54-ab65-d38347ea5e90"
              "DeletedDateTime"              = $null
              "AdditionalProperties"         = @{
                                                    "@odata.type"            = "#microsoft.graph.device"
                                                    "accountEnabled"         = $true
                                                    "deviceId"               = "6e9d44e6-f191-4957-bb31-c52f33817204"
                                                    "displayName"            = "Mock-App"
                                                    "isCompliant"            = $false
                                                    "isManaged"              = $true
                                                    "operatingSystem"        = "WINDOWS"
                                                    "operatingSystemVersion" = "10.0.22621.1700"
                                                    "systemLabels"           = @{}
                                                    "extensionAttributes"    = $null
                                                 }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgUserRegisteredDevice -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra
}

Describe "Get-EntraUserRegisteredDevice" {
Context "Test for Get-EntraUserRegisteredDevice" {
        It "Should return specific user registered device" {
            $result = Get-EntraUserRegisteredDevice -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "74825acb-c984-4b54-ab65-d38347ea5e90"
            $result.AdditionalProperties.deviceId | Should -Be "6e9d44e6-f191-4957-bb31-c52f33817204"
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgUserRegisteredDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { Get-EntraUserRegisteredDevice -ObjectId    } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectlId is invalid" {
            { Get-EntraUserRegisteredDevice -ObjectId  ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return All user registered devices" {
            $result = Get-EntraUserRegisteredDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -All $true
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "74825acb-c984-4b54-ab65-d38347ea5e90"
            $result.AdditionalProperties.deviceId | Should -Be "6e9d44e6-f191-4957-bb31-c52f33817204"
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgUserRegisteredDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraUserRegisteredDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -All  } | Should -Throw "Missing an argument for parameter 'All'*"
        }
        It "Should fail when All is invalid" {
            { Get-EntraUserRegisteredDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -All xyz } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }
        It "Should return top 1 user registered device" {
            $result = Get-EntraUserRegisteredDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "74825acb-c984-4b54-ab65-d38347ea5e90"
            $result.AdditionalProperties.deviceId | Should -Be "6e9d44e6-f191-4957-bb31-c52f33817204"
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgUserRegisteredDevice  -ModuleName Microsoft.Graph.Entra -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraUserRegisteredDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraUserRegisteredDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should contain UserId in parameters when passed ObjectId to it" {              
            $result = Get-EntraUserRegisteredDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraUserRegisteredDevice"

            $result = Get-EntraUserRegisteredDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}
 