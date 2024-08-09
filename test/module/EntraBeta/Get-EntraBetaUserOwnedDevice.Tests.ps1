BeforeAll {  
    if((Get-Module -Name Microsoft.Graph.Entra.Beta) -eq $null){
        Import-Module Microsoft.Graph.Entra.Beta       
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
                                                    "createdDateTime"        = "2024-01-18T08:50:28Z"
                                                    "deviceVersion"          = "2"
                                                    "displayName"            = "Mock-App"
                                                    "isCompliant"            = $false
                                                    "isManaged"              = $true
                                                    "operatingSystem"        = "WINDOWS"
                                                    "operatingSystemVersion" = "10.0.22621.1700"
                                                    "physicalIds"            = "[HWID]:h:6825786449406074"
                                                    "systemLabels"           = @{}
                                                    "extensionAttributes"    = $null
                                                 }
              "Parameters"                   = $args
            }
        )
    }

    Mock -CommandName Get-MgBetaUserOwnedDevice -MockWith $scriptblock -ModuleName Microsoft.Graph.Entra.Beta
}

Describe "Get-EntraBetaUserOwnedDevice" {
Context "Test for Get-EntraBetaUserOwnedDevice" {
        It "Should return specific user registered device" {
            $result = Get-EntraBetaUserOwnedDevice -ObjectId "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "74825acb-c984-4b54-ab65-d38347ea5e90"
            $result.AdditionalProperties.deviceId | Should -Be "6e9d44e6-f191-4957-bb31-c52f33817204"
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgBetaUserOwnedDevice  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when ObjectlId is empty" {
            { Get-EntraBetaUserOwnedDevice -ObjectId    } | Should -Throw "Missing an argument for parameter 'ObjectId'*"
        }
        It "Should fail when ObjectlId is invalid" {
            { Get-EntraBetaUserOwnedDevice -ObjectId  ""} | Should -Throw "Cannot bind argument to parameter 'ObjectId' because it is an empty string."
        }
        It "Should return All user registered devices" {
            $result = Get-EntraBetaUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -All $true
            $result | Should -Not -BeNullOrEmpty

            Should -Invoke -CommandName Get-MgBetaUserOwnedDevice  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when All is empty" {
            { Get-EntraBetaUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -All  } | Should -Throw "Missing an argument for parameter 'All'*"
        }
        It "Should fail when All is invalid" {
            { Get-EntraBetaUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -All xyz } | Should -Throw "Cannot process argument transformation on parameter 'All'*"
        }
        It "Should return top 1 user registered device" {
            $result = Get-EntraBetaUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top 1
            $result | Should -Not -BeNullOrEmpty
            $result.Id | Should -Be "74825acb-c984-4b54-ab65-d38347ea5e90"
            $result.AdditionalProperties.deviceId | Should -Be "6e9d44e6-f191-4957-bb31-c52f33817204"
            $result.AdditionalProperties.displayName | Should -Be "Mock-App"

            Should -Invoke -CommandName Get-MgBetaUserOwnedDevice  -ModuleName Microsoft.Graph.Entra.Beta -Times 1
        }
        It "Should fail when Top is empty" {
            { Get-EntraBetaUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top } | Should -Throw "Missing an argument for parameter 'Top'*"
        }
        It "Should fail when Top is invalid" {
            { Get-EntraBetaUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1" -Top xyz } | Should -Throw "Cannot process argument transformation on parameter 'Top'*"
        }
        It "Should contain UserId in parameters when passed ObjectId to it" {              
            $result = Get-EntraBetaUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.UserId | Should -Be "fd560167-ff1f-471a-8d74-3b0070abcea1"
        }
        It "Should contain 'User-Agent' header" {
            $userAgentHeaderValue = "PowerShell/$psVersion EntraPowershell/$entraVersion Get-EntraBetaUserOwnedDevice"

            $result = Get-EntraBetaUserOwnedDevice -ObjectId  "fd560167-ff1f-471a-8d74-3b0070abcea1"
            $params = Get-Parameters -data $result.Parameters
            $params.Headers["User-Agent"] | Should -Be $userAgentHeaderValue
        }


    }
}
 